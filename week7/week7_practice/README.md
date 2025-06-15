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
<summary><strong>Task 4 – Docker Compose + CI Integration</strong></summary>

✅ **Goal**: Use Docker Compose in CI pipeline.

---

### 🤧 Sample GitHub Actions workflow:

```yaml
name: Docker Compose CI

on: [push]

jobs:
  compose-test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Install Docker Compose
      run: sudo apt-get install docker-compose -y
    - name: Build and Run
      run: |
        docker-compose up -d
        docker-compose ps
    - name: Run tests (example)
      run: |
        curl http://localhost:5000
    - name: Shutdown
      run: docker-compose down
```

---
</details>

<details>
<summary><strong>Task 5 – Lightweight Base Images and Optimization</strong></summary>

✅ **Goal**: Use optimized base images and compare sizes.

---

### 🔧 Use `python:3.11-slim` or `python:3.11-alpine`

```dockerfile
FROM python:3.11-alpine

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

CMD ["python", "app.py"]
```

### 🔧 Build and compare sizes

```bash
docker build -t myapp:alpine .
docker images
```

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
