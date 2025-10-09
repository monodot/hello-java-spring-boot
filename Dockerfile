# Build the application first using Maven
#FROM maven:3.8-openjdk-11 as build
#FROM 3.9.11-sapmachine-11 as build
#WORKDIR /app
#COPY . .
#RUN mvn clean install

# Inject the JAR file into a new container to keep the file small
#FROM openjdk:11-jre-slim
#WORKDIR /app
#COPY --from=build /app/target/hello-java-spring-boot-*.jar /app/app.jar
#EXPOSE 8080
#ENTRYPOINT ["sh", "-c"]
#CMD ["java -jar app.jar"]
FROM m1k3pjem/hello-java-spring-boot:latest
