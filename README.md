# DevOps MODUL - Assignment 1

SDE25 WS2024/25

## Project Overview

objectives:

- [x] **Create Dockerfile:** a multi-stage Dockerfile was created to build and containerize the web application.
- [x] **Set up CI/CD Pipeline:**
    - [x] Linting: Runs on every push to any branch.
    - [x] Building: Runs on every push to any branch.
    - [x] Auditing: Runs only on merges to the `main` or `release` branches.
- [x] **Push Docker Image to Docker Hub:** The Docker image has been successfully pushed to [Docker Hub](https://hub.docker.com/r/erna67/devops-webapp).
- [ ] **Deploy on Azure Container Apps**

## Docker Image

The Docker image for this project is available on Docker Hub:

- **Repository:** [erna67/devops-webapp](https://hub.docker.com/r/erna67/devops-webapp)
- **Tag:** release

### How to Run Locally

To run the application locally using Docker, use the following commands:

```bash
docker pull erna67/devops-webapp:release
docker run -p 3000:3000 erna67/devops-webapp:release
```

The application will be available at `http://localhost:3000`.


# Assignment 2 - Kubernetes

For utilizing a local Kubernetes cluster, I have used Minikube, as I already had it installed on my machine. 

## Deploy the containerized app on local K8s cluster

The following steps were taken to deploy the application on Minikube:

1. **Start Minikube:**
    ```bash
    minikube start
    ```

2. **Create a Kubernetes service:** see `k8s/deployment.yaml`

3. **Apply the deployment:**
    ```bash
    kubectl apply -f k8s/deployment.yaml
    ```
   
4. Verify that the deployment is running:
    ```bash
    kubectl get pods
    
    NAME                                       READY   STATUS    RESTARTS   AGE
    devops-webapp-deployment-d7b6b98c7-69n5m   1/1     Running   0          2m6s
    devops-webapp-deployment-d7b6b98c7-727tn   1/1     Running   0          2m6s
    devops-webapp-deployment-d7b6b98c7-fhg7c   1/1     Running   0          2m6s
    ```
   
5. **Create a Service to expose the application**
    ```bash
    kubectl apply -f k8s/service.yaml
    ```
   
6. **Verify that the service is running:**
    ```bash
    kubectl get services
    ```
   
7. **Access the application:** Minikube provides a convenient command to access services.
   This command will automatically open your web browser to access the application using the correct Minikube IP and port:
    ```bash
    minikube service devops-webapp-service
    ```
   We can also see that the app is running and available on those addresses:
    ```bash
    |-----------|-----------------------|-------------|---------------------------|
    | default   | devops-webapp-service |          80 | http://192.168.49.2:30407 |
    |-----------|-----------------------|-------------|---------------------------|
    * Starting tunnel for service devops-webapp-service.
    |-----------|-----------------------|-------------|------------------------|
    | NAMESPACE |         NAME          | TARGET PORT |          URL           |
    |-----------|-----------------------|-------------|------------------------|
    | default   | devops-webapp-service |             | http://127.0.0.1:53312 |
    |-----------|-----------------------|-------------|------------------------|
    * Opening service default/devops-webapp-service in default browser...
   ```

## Implement a rolling update strategy for zero-downtime deployments

We can leverage the rolling update mechanism that Kubernetes provides by default. This approach updates pods 
incrementally, ensuring that some pods are always available, hence minimizing downtime.

We can just add the following command to the deployment file to update the image:

```yaml
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxUnavailable: 1
    maxSurge: 1
```

Explanation:
* `strategy.type: RollingUpdate`: This specifies that the deployment strategy will be a rolling update.
* `rollingUpdate.maxUnavailable: 1`: This controls how many pods can be unavailable during the update. Setting it to 1 means that one pod can be taken down at a time.
* `rollingUpdate.maxSurge: 1`: This controls how many new pods can be created over the desired count of replicas during the update. Setting it to 1 means that one new pod will be created before an old one is taken down, ensuring there is always a sufficient number of available pods.

**Updating the Deployment**

To perform a rolling update, we can just update the container image or other properties of the deployment and reapply the configuration.
For example, if we have a new version of the container image, we can edit the deployment YAML file with the new version:

```yaml
spec:
  containers:
  - name: devops-webapp
    image: erna67/devops-webapp:release-v2
```

Then, we can apply the updated configuration:

```bash
kubectl apply -f k8s/deployment.yaml
```

Kubernetes will start the rolling update:
* It will bring up a new pod with the updated image.
* Once the new pod is ready (i.e., passes readiness checks), it will take down an old pod.
* This process continues until all pods are updated.

**Verify the Rolling Update**

To verify that the rolling update is happening correctly, we can check the status of the pods:

```bash
kubectly rollout status deployment/devops-webapp-deployment
```

## Scale the application by adjusting replica counts

This step involves adjusting the number of replicas (pods) for the deployment. 
We can do this with `kubectl` commands:

1. **Manually scale the application Using `kubectl scale`**
    ```sh
    kubectl scale deployment devops-webapp-deployment --replicas=5
    ```
    This sets the number of replicas to `5`.


2. **Scaling by editing the deployment YAML**: We can also update the `replicas` field in the deployment YAML file and apply the changes:
    ```yaml
     apiVersion: apps/v1
     kind: Deployment
     metadata:
       name: devops-webapp-deployment
     spec:
       replicas: 5
     ```
    Apply the changes: `kubectl apply -f k8s/deployment.yaml`

After scaling, we can check the status of the deployment to verify that the number of replicas has changed:

```sh
> kubectl get deployment devops-webapp-deployment
NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
devops-webapp-deployment   5/5     5            5           37m
```
