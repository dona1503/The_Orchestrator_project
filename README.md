"The Orchestrator: On-Demand Integration Testbed"

This project’s core idea is to automate the creation of integration testing environments for applications that use microservices.

Here’s a roadmap for you:

🧩 Step 1 — Design

Decide what microservices you’ll simulate (e.g., User Service, Order Service, Database).

Draw a small architecture diagram.

🏗️ Step 2 — Infrastructure (Terraform)

Write Terraform code to:

Create a Docker network.

Create Docker containers for each microservice.

⚙️ Step 3 — Configuration (Ansible)

Write Ansible playbooks to:

Install required packages inside containers.

Deploy mock Java apps into the containers.

Start the services and verify connections.

🧪 Step 4 — Testing Automation

Add a smoke test task in Ansible to ensure services are running and reachable.

🔁 Step 5 — Cleanup

Use Terraform destroy command to remove all containers when done.
