
#Define the base layer for the container
FROM  openjdk:11.0-jre-slim

#Set the working directory
WORKDIR /opt
RUN groupadd -r demo && useradd -r -s /bin/false -g demo demo
#Use to set any env variables
ENV PORT 8080
EXPOSE 8080
#Copy the jar files from target into the directory inside the container
COPY /target/*.jar /opt/app.jar
#Execute java inside the container
ENTRYPOINT exec java $JAVA_OPTS -jar /opt/app.jar