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




-----

# Startup - Free Next.js Startup Website Template

Startup free, open-source, and premium-quality startup website template for Next.js comes with everything you need to launch a startup, business, or SaaS website, including all essential sections, components, and pages.

If you're looking for a high-quality and visually appealing, feature-rich Next.js Template for your next startup, SaaS, or business website, this is the perfect choice and starting point for you!

### ✨ Key Features
- Crafted for Startup and SaaS Business
- Next.js and Tailwind CSS
- All Essential Business Sections and Pages
- High-quality and Clean Design
- Dark and Light Version
- TypeScript Support
and Much More ...

### 🙌 Detailed comparison between the Free and Pro versions of Startup

| Feature             | Free | Pro |
|---------------------|------------|----------|
| Next.js Landing Page             | ✅ Yes      | ✅ Yes      |
| All The Integrations - Auth, DB, Payments, Blog and many more ...             | ❌ No      | ✅ Yes |
| Homepage Variations             | 1      | 2 |
| Additional SaaS Pages and Components             | ❌ No      | ✅ Yes |
| Functional Blog with Sanity       | ❌ No      | ✅ Yes | ✅ Yes |
| Use with Commercial Projects            | ✅ Yes      | ✅ Yes      |
| Lifetime Free Updates             | ✅ Yes      | ✅ Yes |
| Email Support       | ❌ No         | ✅ Yes       |
| Community Support         | ✅ Yes         | ✅ Yes       |


### [🔥 Get Startup Pro](https://nextjstemplates.com/templates/saas-starter-startup)

[![Startup Pro](https://raw.githubusercontent.com/NextJSTemplates/startup-nextjs/main/startup-pro.webp)](https://nextjstemplates.com/templates/saas-starter-startup)

Startup Pro - Expertly crafted for fully-functional, high-performing SaaS startup websites. Comes with with Authentication, Database, Blog, and all the essential integrations necessary for SaaS business sites.


### [🚀 View Free Demo](https://startup.nextjstemplates.com/)

### [🚀 View Pro Demo](https://startup-pro.nextjstemplates.com/)

### [📦 Download](https://nextjstemplates.com/templates/startup)

### [🔥 Get Pro](https://nextjstemplates.com/templates/saas-starter-startup)

### [🔌 Documentation](https://nextjstemplates.com/docs)

### ⚡ Deploy Now

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2FNextJSTemplates%2Fstartup-nextjs)

[![Deploy with Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/NextJSTemplates/startup-nextjs)


### 📄 License
Startup is 100% free and open-source, feel free to use with your personal and commercial projects.

### 💜 Support
If you like the template, please star this repository to inspire the team to create more stuff like this and reach more users like you!

### ✨ Explore and Download - Free [Next.js Templates](https://nextjstemplates.com)
