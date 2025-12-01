# Build stage
FROM maven:3.9.11-eclipse-temurin-22 as build
WORKDIR /app
COPY pom.xml .
# copy only source to leverage caching for maven dependencies
COPY src ./src
RUN mvn -B -DskipTests clean package

# Run stage
FROM eclipse-temurin:22-jre-jammy
ARG JAR_FILE=target/backend-0.0.1-SNAPSHOT.jar
COPY --from=build /app/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
