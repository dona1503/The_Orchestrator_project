terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {}

# 1. Build the mock API service image from its Dockerfile
resource "docker_image" "api_service_image" {
  name         = "mock-api-service:latest"
  build {
    context    = "../java-mock-services/api-service" # Path to the Dockerfile
    platform   = "linux/amd64"
  }
  force_remove = true
}

# 2. Define a custom network for the services to talk to each other
resource "docker_network" "testbed_network" {
  name   = "testbed-net"
  driver = "bridge"
}

# 3. Define the Database Container (using a standard image)
resource "docker_container" "user_db" {
  name     = "user-db"
  image    = "postgres:14-alpine"
  hostname = "user-db"
  networks_advanced {
    name = docker_network.testbed_network.name
  }
  env = [
    "POSTGRES_PASSWORD=mysecretpassword",
    "POSTGRES_USER=admin",
    "POSTGRES_DB=testbed"
  ]
}

# 4. Define the API Service Container (using the image we built)
resource "docker_container" "api_service" {
  name     = "api-service"
  image    = docker_image.api_service_image.name
  hostname = "api-service"
  networks_advanced {
    name = docker_network.testbed_network.name
  }

  # The API service depends on the database
  depends_on = [docker_container.user_db]

  # Pass environment variables so the API knows how to find the DB
  env = [
    "SPRING_DATASOURCE_URL=jdbc:postgresql://user-db:5432/testbed",
    "SPRING_DATASOURCE_USERNAME=admin",
    "SPRING_DATASOURCE_PASSWORD=mysecretpassword",
    "SERVER_PORT=8080"
  ]

  ports {
    internal = 8080
    external = 8081 # Expose on host port 8081 for the smoke test
  }
}

# (Optional: Add a 3rd "frontend" container here if needed)