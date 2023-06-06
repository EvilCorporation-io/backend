#build stage
FROM maven:3.5-jdk-8-alpine as build-stage
# FROM maven:3.9.2-eclipse-temurin-8-alpine as build-stage
WORKDIR /app
ARG USERNAME
ARG TOKEN
COPY ./ .
RUN mvn install -s ./settings.xml

#production stage
FROM openjdk:8-jre-alpine as prod-stage
WORKDIR /app
COPY --from=build-stage /app/target/*.jar /app/backend.jar
EXPOSE 8081
CMD ["java", "-jar", "backend.jar"]
