#Stage 1
FROM maven:3.8.6-jdk-11-slim AS build

WORKDIR /app

COPY . .

RUN mvn validate test
RUN mvn package install 

# Stage 2
FROM openjdk:11-jre-slim

COPY --from=build /app/target/*.jar /app/target/app.jar

CMD ["java","-jar","/app/target/app.jar"]
