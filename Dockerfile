FROM eclipse-temurin:11-jdk-alpine
WORKDIR /app
COPY target/helloworld-0.0.1-SNAPSHOT.jar app.jar
COPY application.yaml ./src/main/resources/application.yaml
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
