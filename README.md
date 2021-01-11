# Kubernetes-101-for-Java-Developers
Kubernetes 101 for Java Developers Demo

### Build and run application:

Spring boot and mysql database running on docker

**Clone from repository**
```bash
git clone git@github.com:helayoty/Kubernetes-101-for-Java-Developers.git
```

**Build application**
```bash
cd java-kubernetes
mvn clean install
```

**Set CosmosDB connection variables**
```bash
cd src/main/resources
vim application.yml
```
Update the following variables with your DB ones

```yaml


```

**Run application**
```bash
mvn spring-boot:run

# or you can use this command: 
# java --enable-preview -jar target/java-kubernetes.jar
```

**Check**

http://localhost:8080/

**Stop the running application**


## Part two - Dockerize Java app:

Create a Dockerfile:

```yaml
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
```
**Build application and docker image**

```bash
docker build -t mininote-java .

```

Create Docker network
```bash
docker network create mininote
```

Run mongoDB inside docker
```bash
docker run --name=mongo --rm --network=mininote mongo
```

Create and run the application container
```bash
docker run --name=mininote-java --rm --network=mininote -p 8080:8080 -e MONGO_URL=mongodb://mongo:27017/dev <your-dockerhub-username>/mininote-java:1.0.0
```

**Check**

http://localhost:8080/


Stop all:

`
docker stop mongo mininote-java
`

## Part three - app on local Kubernetes:

We have an application and image running in docker
Now, we deploy application in a kubernetes cluster running in our machine

### Push your image to Docker Hub first
```bash
docker tag mininote-java <your-dockerhub-username>/mininote-java:1.0.0

docker push <your-dockerhub-username>/mininote-java:1.0.0
```

### Start minikube
```
minikube start
```

### deploy your app
```bash
cd kube

kubectl apply -f mininote.yaml
kubectl apply -f mongo.yaml

```

### Open Dashboard
```
minikube dashboard
```

**Check**
```bash
minikube service mininote-service
```

### stop minikube
```bash
minikube stop
```

## Part four - app on cloud Kubernetes (AKS):

```bash
az login
az aks get-credentials --name MyManagedCluster --resource-group MyResourceGroup
```

### deploy your app
```bash
cd kube

kubectl apply -f mininote.yaml

kubectl apply -f mongo.yaml
```

### verify pod is up and running
```bash
kubectl get pods
```

### get service ip to access application
```bash
kubectl get service
```

**Check**
```bash
http://<service_IP>
```

