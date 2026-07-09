# ==========================================
# Stage 1: Build the Spring Boot application
# ==========================================
FROM maven:3.9.16-eclipse-temurin-17 AS builder

# Set the working directory
WORKDIR /app

# Copy Maven configuration
COPY pom.xml .

# Download dependencies first 
RUN mvn dependency:go-offline

# Copy application source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# ==========================================
# Stage 2: Runtime
# ==========================================
FROM eclipse-temurin:17-jre

LABEL maintainer="Nourhan Khalid"
LABEL application="Azure DevOps Technical Assessment"


# Create a non-root user
RUN groupadd -r spring && \
    useradd -r -g spring -s /usr/sbin/nologin spring

# Set working directory
WORKDIR /app

# Copy the application JAR & Change file ownership
COPY --from=builder --chown=spring:spring /app/target/*.jar app.jar


# Run as non-root user
USER spring

# Expose application port
EXPOSE 8080

# Start the application
ENTRYPOINT ["java", "-jar", "app.jar"]