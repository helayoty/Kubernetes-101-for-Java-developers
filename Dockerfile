FROM maven:3.6.3-jdk-11 AS base
WORKDIR /app
ADD pom.xml /app

# ----Build App with Dependencies ----
FROM base AS dependencies
ADD . /app

RUN mvn clean package -DskipTests

#Define the base layer for the container
FROM adoptopenjdk/openjdk11:jdk-11.0.2.9-slim AS release
#Set the working directory
WORKDIR /opt
#Use to set any env variables
ENV PORT 8080
EXPOSE 8080
#Copy the jar files from target into the directory inside the container
COPY --from=dependencies /app/target/*.jar /opt/app.jar
#Execute java inside the container
ENTRYPOINT exec java $JAVA_OPTS -jar /opt/app.jar