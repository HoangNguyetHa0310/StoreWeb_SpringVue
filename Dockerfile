###
# Multi-stage Dockerfile (frontend + backend -> single runnable image)
# - Stage 1: build frontend (Vite)
# - Stage 2: build backend (Maven) and copy frontend dist into resources/static
# - Stage 3: minimal runtime image (OpenJDK JRE)
###

#### Stage 1: Frontend build (Vite)
FROM node:18-alpine AS frontend-build
WORKDIR /home/app/frontend

# Copy package manifests first to leverage Docker cache for dependencies
COPY frontend/package*.json ./
# Use npm ci if lockfile later added; fallback to npm install
RUN npm ci --silent || npm install --silent

# Copy source and build
COPY frontend/ .
# Build: prefer `build:vite` then `build` (package.json defines both)
RUN if npm run | grep -q "build:vite"; then npm run build:vite; else npm run build; fi


#### Stage 2: Backend build (Maven) - produce fat jar
FROM maven:3.8.5-openjdk-17 AS backend-build
WORKDIR /home/app

# Copy pom first and pre-download dependencies (cacheable layer)
COPY pom.xml ./
RUN mvn -B dependency:go-offline

# Copy application source
COPY src ./src

# Copy frontend build output into Spring Boot static resources so it will be served
# If frontend produced `dist` directory, copy it into src/main/resources/static
COPY --from=frontend-build /home/app/frontend/dist ./src/main/resources/static

# Build the application (skip tests to speed up image build; remove -DskipTests in CI if you want tests)
RUN mvn -B clean package -DskipTests


#### Stage 3: Runtime image
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Copy the packaged jar from builder stage. The wildcard handles versioned jar names.
COPY --from=backend-build /home/app/target/*.jar ./app.jar

# Defaults suitable for local development. Can be overridden with `docker run -e ...`.
ENV SPRING_PROFILES_ACTIVE=local
ENV SERVER_PORT=8080
ENV JAVA_OPTS="-Xms256m -Xmx512m"

EXPOSE 8080

ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar /app/app.jar"]