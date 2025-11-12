# Use a lightweight Java 11 runtime
FROM eclipse-temurin:11-jre-focal

WORKDIR /app

# Assume the .jar file is built and copied into this directory
# In a real CI/CD pipeline, a build stage would create this JAR.
# For this project, build it locally first: mvn clean package
COPY target/api-service-1.0.0-SNAPSHOT.jar api-service.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "api-service.jar"]