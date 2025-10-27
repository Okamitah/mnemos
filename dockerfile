# Use Java 17 runtime
FROM openjdk:17-jdk-slim

# Set working directory inside the container
WORKDIR /app

# Copy the JAR file from backend folder into the container
COPY mnemos-back/target/mneoms-back-0.0.1-SNAPSHOT.jar app.jar

# Expose the port your Spring Boot app uses
EXPOSE 8080

# Run the Spring Boot JAR
ENTRYPOINT ["java","-jar","app.jar"]
