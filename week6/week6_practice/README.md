
# Week 6 – Docker & Containers: Daily Practice Tasks

<details>
<summary><strong>Task 1 – Introduction to Docker CLI</strong></summary>

✅ **Goal**: Install Docker and learn basic CLI operations.

---

### 🧰 Step-by-step Instructions

1. **Install Docker** on your system from [https://docs.docker.com/get-docker](https://docs.docker.com/get-docker).
2. **Verify installation** by running your first container:

   ```bash
   docker run hello-world
   ```

   You should see a message saying Docker is installed and working.

   📌 This command also pulls the hello-world image from Docker Hub if it's not already present on your machine.

### 🔍 Explore Docker CLI

Use the following commands to explore and manage Docker containers and images:

```bash
docker ps            # Show running containers  
docker ps -a         # Show all containers (including stopped)  
docker images        # List all images  
docker stop <id>     # Stop a running container  
docker rm <id>       # Remove a stopped container  
docker rmi <id>      # Remove an image
```

📌 Replace <id> with the actual container ID, image ID, or name from the listing commands. Both ID and name can usually be used.



</details>

<details>
<summary><strong>Task 2 – Working with Docker Images</strong></summary>

Pull and run a simple web server image such as `nginx`. Explore how to expose ports using the `-p` flag. Use `curl` or a browser to verify the web server is running.

Bonus: Use a lightweight image like `nginx:alpine` and compare sizes using `docker image ls`.

</details>

<details>
<summary><strong>Task 3 – Dockerfile Basics</strong></summary>

Create your own Dockerfile for a basic Node.js or Python Flask app that prints `Hello from Docker`. Build the image and run the container. Add a `.dockerignore` file and examine the impact.

</details>

<details>
<summary><strong>Task 4 – Custom Networking and Multi-container Setup</strong></summary>

Create a custom Docker network with `docker network create mynet`. Run two containers (e.g., web app and database) on the same network. Ensure they can talk to each other using container names.

</details>

<details>
<summary><strong>Task 5 – Docker Compose Intro</strong></summary>

Write a `docker-compose.yml` file for a two-service app (web + db). Define environment variables, volumes, and network within the compose file. Bring everything up using `docker-compose up` and test inter-service communication.

</details>

<details>
<summary><strong>Task 6 – Monitoring & Logging Basics</strong></summary>

Add `HEALTHCHECK` to your Dockerfile to monitor container health. Install and use a simple logging method inside your app (e.g., log HTTP requests). Set up `docker logs` and `docker inspect` to validate container status and health.

</details>

<details>
<summary><strong>Task 7 – Advanced Docker Features</strong></summary>

- Tag your image with versions like `myapp:1.0.0`
- Use `docker push` to upload to Docker Hub (optional)
- Use `node:alpine` or `python:slim` to compare performance and size
- Connect your container status to Slack via webhook or simulate a post-build notification
- Bonus: Build a small web app that logs hits and returns a status code (200/500) for healthcheck testing

</details>
