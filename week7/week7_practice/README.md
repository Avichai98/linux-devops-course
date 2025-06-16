# Week 7 – Docker Compose & Azure + VM: Daily Practice Tasks

<details>
<summary><strong>Task 1 – Create and Run Multi-Container App with Docker Compose ✅</strong></summary>

✅ **Goal**: Build a multi-container app using Docker Compose.

---

### 🧰 Instructions:

1. **Create a `docker-compose.yml` file**

```yaml
services:
  web:
    image: nginx:alpine
    container_name: my_nginx
    ports:
      - "8080:80"
    networks:
      - mynet

  db:
    image: mysql:8
    container_name: my_mysql
    environment:
      MYSQL_USER: user
      MYSQL_PASSWORD: password
      MYSQL_DATABASE: mydb
    ports:
      - "3306:3306"
    networks:
      - mynet
  
networks:
  mynet:
    driver: bridge
```

2. **Start containers**

```bash
docker-compose up -d
```

3. **Verify containers are running**

```bash
docker-compose ps
```

4. **Inspect networking**

```bash
docker exec -it my_nginx ping db
```

---
</details>

<details>
<summary><strong>Task 2 – Volume Mounting and Persistent Data ✅</strong></summary>

✅ **Goal**: Persist data and use mounted config files.

---

### 🔧 Update docker-compose.yml:

```yaml
version: '3.9'

services:
 services:
  web:
    image: nginx:alpine
    container_name: my_nginx
    ports:
      - "8080:80"
    networks:
      - mynet

  db:
    image: mysql:8
    container_name: my_mysql
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_USER: user
      MYSQL_PASSWORD: password
      MYSQL_DATABASE: mydb
    ports:
      - "3306:3306"
    volumes:
      - db_data:/var/lib/mysql
    networks:
      - mynet
  
volumes:
  db_data:

networks:
  mynet:
    driver: bridge
```

### 📦 Volume Explanation
The volumes section allows us to persist the database data outside the container filesystem.

Without volumes: if the container is stopped, deleted, or recreated, all database data is lost.

With volumes: data is stored on the host machine under Docker-managed storage (db_data), and survives restarts and rebuilds.

✅ This ensures your MySQL database keeps all tables, rows, and configurations even if the container is deleted.

✅ Docker automatically creates and manages the physical storage location for db_data.

You can inspect Docker volumes using:

```bash
docker volume ls
docker volume inspect db_data
```

### 🌐 Create .env file:

```env
MYSQL_ROOT_PASSWORD=rootpassword
MYSQL_USER=user
MYSQL_PASSWORD=password
MYSQL_DATABASE=mydb
```

### 🔐 .env File Explanation
The .env file contains environment variables that are injected into the docker-compose.yml file.

This allows you to separate configuration from code.

You can easily change database credentials without modifying your compose file.

Great for managing secrets and multiple environments (development, staging, production).

Docker Compose automatically loads the .env file located in the same directory.

✅ Use .gitignore to avoid pushing this file to public repositories for security:

```bash
echo ".env" >> .gitignore
```

### 🔄 Restart containers

```bash
docker-compose down
docker-compose up -d
```

### Inspect networking

```bash
docker exec -it my_nginx ping db
```

---
</details>

<details>
<summary><strong>Task 3 – Healthchecks and Logging ✅</strong></summary>

✅ **Goal**: Add healthchecks and log behavior.

---

### 🧰 Update docker-compose.yml:

```yaml
services:
  web:
    image: nginx:alpine
    container_name: my_nginx
    ports:
      - "8080:80"
    networks:
      - mynet
    restart: on-failure
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:80"]
      interval: 30s
      timeout: 10s
      retries: 3

  db:
    image: mysql:8
    container_name: my_mysql
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
    ports:
      - "3306:3306"
    volumes:
      - db_data:/var/lib/mysql
    networks:
      - mynet
  
volumes:
  db_data:

networks:
  mynet:
    driver: bridge
```

### 🩺 Healthcheck Explanation
Docker healthchecks allow you to monitor the internal health of your containerized services.

Docker Compose periodically runs the test command inside the container.

If the healthcheck fails repeatedly (after the number of retries), Docker marks the container as unhealthy.

This does not automatically restart the container unless combined with restart policies.

#### ✅ Fields explanation:

| Field    | Meaning |
| -------- | ------- |
| `test`   | The command Docker runs to verify health (`curl` checks HTTP status 200) |
| `interval` | Time between checks (e.g., `30s` means every 30 seconds) |
| `timeout` | How long Docker waits for a check to complete |
| `retries` | How many consecutive failures are allowed before marking as unhealthy |

#### ✅ Example:

```bash
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost:8080"]
  interval: 30s
  timeout: 10s
  retries: 3
```

* Every 30 seconds Docker sends HTTP request to port 8080.
* If curl fails 3 times in a row, container is marked unhealthy.

### 🔁 Restart Policy Explanation
The restart option controls whether and when Docker automatically restarts your container if it exits or becomes unhealthy.

* no (default): never restart.
* always: always restart if stopped.
* on-failure: restart only on non-zero exit codes.
* unless-stopped: restart unless stopped manually.

#### ✅ Example:

```bash
restart: always
```

* Ensures the service will automatically restart if it crashes or if healthcheck eventually causes it to fail.

✅ Restart policies are critical for production resiliency.

### 🔧 View health status

#### Full container inspection:

```bash
docker inspect my_nginx
```

* Shows full container configuration and runtime state.

#### Focused healthcheck inspection (clean JSON output):
```bash
docker inspect --format='{{json .State.Health}}' my_nginx
```

* Extracts only the Health section in JSON format.
* Useful for debugging health checks.

### 📊 Health Status States

| Status    | Meaning |
|-----------|---------|
| `starting` | Healthcheck is still running initial probes |
| `healthy`  | Healthcheck probes succeeded |
| `unhealthy` | Healthcheck probes failed |

- **.FailingStreak** — counts how many failures in a row.
- **.Log** — contains recent probe results, timestamps, exit codes and outputs.


### 🔧 View logs

```bash
docker-compose logs
```

---
</details>

<details>
<summary><strong>Task 4 – Docker Compose + CI Integration ✅</strong></summary>

✅ **Goal**: Use Docker Compose in CI pipeline.

The objective of this task is to **integrate Docker Compose into the CI pipeline** using GitHub Actions. In this workflow, we will:
- **Run `docker-compose up`** to launch containers for end-to-end test runs.
- **Test failure scenarios** and ensure container exit codes are properly handled.
- **Push test results or logs as CI artifacts** for later review.

---

## GitHub Actions Workflow Explanation

This section explains each step of the workflow.

### Trigger Conditions
The workflow is triggered on every push and pull request.

```bash
on:
  push:
  pull_request:
```

### Job Setup
A job called `integration-tests` is defined and runs on the latest Ubuntu image.

```bash
jobs:
  integration-tests:
    runs-on: ubuntu-latest
```

### Environment Variables
Sensitive MySQL credentials are loaded securely from GitHub Secrets.

```bash
env:
  MYSQL_ROOT_PASSWORD: ${{ secrets.MYSQL_ROOT_PASSWORD }}
  MYSQL_USER: ${{ secrets.MYSQL_USER }}
  MYSQL_PASSWORD: ${{ secrets.MYSQL_PASSWORD }}
  MYSQL_DATABASE: ${{ secrets.MYSQL_DATABASE }}
```

---

## Workflow Steps

### 1. Checkout Code
Retrieves the latest repository code.

```bash
- name: Checkout code
  uses: actions/checkout@v4
```

### 2. Set Up Docker Buildx
**Detailed Explanation:**  
Docker Buildx is an extended feature provided by the Docker CLI that uses BuildKit as the backend. It enables:
- **Multi-platform builds:** Create images for different CPU architectures (e.g., x86, ARM) from a single Dockerfile.
- **Improved caching:** Offers advanced caching mechanisms not available in the legacy build system.
- **Enhanced features:** Supports new build options and improved performance for complex Dockerfiles.

This step ensures that our CI environment can build images using these improved and flexible features.


```bash
- name: Set up Docker Buildx
  uses: docker/setup-buildx-action@v3
```

### 3. Install Docker Compose
Installs Docker Compose so that we can run Docker Compose commands.

```bash
- name: Set up Docker Compose
  run: sudo apt-get update && sudo apt-get install docker-compose -y
```

### 4. Start Docker Compose Services
Brings up all defined services from the Compose file in detached mode.

```bash
- name: Docker Compose Up
  run: docker-compose up -d
  working-directory: ./week7/week7_practice
```

### 5. Verify Running Containers
Lists all running and stopped containers to help diagnose potential startup issues.

```bash
- name: Check running containers
  run: docker ps -a
```

### 6. Health Check for Nginx
Waits until the Nginx container reports a "healthy" status. It checks the status every 5 seconds (up to 10 attempts). If Nginx is not healthy, it exits with an error.

- **`shell: bash`**

  This line specifies that the commands in the `run` block should be executed using the Bash shell. This is necessary because the command block contains Bash-specific syntax (like loops and conditional statements) that might not be correctly interpreted by other shells.

```bash
- name: Wait for healthcheck
  run: |
    echo "Waiting for Nginx healthcheck to be healthy..."
    for i in {1..10}; do
      health=$(docker inspect --format='{{.State.Health.Status}}' my_nginx)
      if [ "$health" = "healthy" ]; then
        echo "Nginx is healthy"
        exit 0
      fi
      echo "Still not healthy... retry $i"
      sleep 5
    done
    echo "Nginx failed to become healthy"
    exit 1
  shell: bash
```

### 7. Integration Test (Check Web Response)
Executes a curl command inside the Nginx container to validate the web service response. If the test fails, this step exits with an error.

```bash
- name: Integration Test (Check Web Response)
  run: |
    docker exec my_nginx curl -f http://localhost:80 || { echo "Web response failed!"; exit 1; }
```

### 8. Create Artifact Directory
Creates the directory that will store the CI artifact (logs). The use of `if: always()` ensures this step runs even if earlier steps failed.

```bash
- name: Create artifact directory
  if: always()
  run: mkdir -p artifact
  working-directory: ./week7/week7_practice
```

### 9. Collect Logs
Collects logs from Docker Compose and writes them to a file. This is crucial for debugging, even if the CI job fails.

```bash
- name: Collect logs
  if: always()
  run: docker-compose logs > docker-logs.txt
  working-directory: ./week7/week7_practice
```

### 10. Check Log File Existence
Verifies that the log file exists. If it doesn’t, the workflow fails with an error message.

```bash
- name: Check if logs file exists
  if: always()
  run: ls -l ./week7/week7_practice/docker-logs.txt || { echo "Log file not found"; exit 1; }
```

### 11. Upload Logs as Artifact
Uploads the log file as a CI artifact so that logs can be downloaded and reviewed post-run. The step runs regardless of previous failures.

```bash
- name: Upload logs as artifact
  if: always()
  uses: actions/upload-artifact@v4
  with:
    name: docker-logs
    path: ./week7/week7_practice/docker-logs.txt
```

### 12. Cleanup Docker Compose
Terminates and removes the Docker Compose services. The `if: always()` condition ensures cleanup occurs even if earlier steps have failed.

```bash
- name: Docker Compose Down
  if: always()
  run: docker-compose down
  working-directory: ./week7/week7_practice
```

---

</details>

<details>
<summary><strong>Task 5 – Lightweight Base Images and Optimization ✅</strong></summary>

✅ **Goal**: Use optimized base images and compare sizes.

---

### 🔧 Use `python:3.11-slim` or `python:3.11-alpine`

```dockerfile
# 🔹 Base image: using lightweight official Python image with pip
FROM python:3.11-slim

# 🔹 Set working directory inside container
WORKDIR /app

# 🔹 Copy files to container
COPY app.py .
COPY requirements.txt .

# 🔹 Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 🔹 Optional: document the port used by the app (Flask uses 5000)
EXPOSE 5000

# 🔹 Healthcheck to monitor the container
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:5000/health || exit 1

# 🔹 Run the app when the container starts
CMD ["python", "app.py"]
```

### Additional Explanations:

1. **Using a Minimal Base Image**  
   We are using `python:3.11-slim` in the Dockerfile. This image is a lightweight alternative compared to the full Python images, resulting in a smaller final image size and faster build times.  
   An alternative to consider is `python:3.11-alpine` which is even smaller; however, be aware that Alpine-based images sometimes have compatibility issues with certain Python packages.

2. **Multi-Stage Builds**  
   For more complex projects, multi-stage builds allow you to segment the build process into different stages. This technique helps eliminate unnecessary build artifacts from the final image. A conceptual example for a Python project might look like this:

```bash
# Stage 1: Build stage
FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Final stage
FROM python:3.11-slim
WORKDIR /app
# Only copy the necessary artifacts from the builder stage  
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY app.py .
EXPOSE 5000
CMD ["python", "app.py"]
```

*Note:* The above multi-stage build example is provided for projects where separation of build dependencies from runtime dependencies is beneficial. For a simple application, the single-stage Dockerfile might be sufficient.

---

## Build and Compare Image Sizes

To rebuild your container using the chosen base image and compare image sizes, run the following commands:

```bash
docker build -t myapp:alpine .
docker images
```

These commands will build your Docker image (tagged as `myapp:alpine` for example) and list all images with their sizes, allowing you to compare the optimized image size against previous builds.

---

</details>

<details>
<summary><strong>Task 6 – Azure VM Setup and Manual Deployment</strong></summary>

✅ **Goal**: Deploy app manually to Azure VM.

---

### 🔧 Steps:

1. Create Azure VM (Linux, free tier if possible)
2. SSH into VM:

```bash
ssh azureuser@<public-ip>
```

3. Install Docker & Compose:

```bash
sudo apt update
sudo apt install docker.io docker-compose -y
```

4. Copy project files using `scp`:

```bash
scp -r ./project azureuser@<public-ip>:~/project
```

5. Deploy:

```bash
cd project
docker-compose up -d
```

---
</details>

<details>
<summary><strong>Task 7 – Deploy to Azure VM via CI/CD</strong></summary>

✅ **Goal**: Automate deployment from CI to Azure VM.

---

### 🔧 Generate SSH key and add to VM:

```bash
ssh-keygen -t rsa -b 4096
ssh-copy-id azureuser@<public-ip>
```

### 🔧 Store SSH key as GitHub Secret

- `AZURE_PRIVATE_KEY`
- `AZURE_HOST`
- `AZURE_USER`

### 🔧 Sample GitHub Actions workflow:

[yaml]
name: Deploy to Azure VM

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Copy files to VM
      uses: appleboy/scp-action@v0.1.3
      with:
        host: ${{ secrets.AZURE_HOST }}
        username: ${{ secrets.AZURE_USER }}
        key: ${{ secrets.AZURE_PRIVATE_KEY }}
        source: "*"
        target: "/home/${{ secrets.AZURE_USER }}/project"

    - name: Deploy via SSH
      uses: appleboy/ssh-action@v0.1.6
      with:
        host: ${{ secrets.AZURE_HOST }}
        username: ${{ secrets.AZURE_USER }}
        key: ${{ secrets.AZURE_PRIVATE_KEY }}
        script: |
          cd project
          docker-compose pull
          docker-compose down
          docker-compose up -d

---
</details>
