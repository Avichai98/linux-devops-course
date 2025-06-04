# Week 5 – Daily Practice Tasks (CI/CD with GitHub Actions)

<details>
<summary><strong>Task 1 – Introduction to GitHub Actions ✅</strong></summary>

**What is a GitHub Action?**  
GitHub Actions is a platform that can run automation tasks triggered by different events like pull request, push to main and so on.  
The most popular use case is CI/CD pipelines, but there are many more possibilities.

**What is the difference between a job and a step?**  
The difference between a job and a step is that each job runs on a separate machine and doesn’t share memory with other jobs.  
A step is a part of a job. A job has one or more steps, and the steps in a job do share memory between them.

**What triggers a workflow?**  
Triggers are the reason a workflow starts.  
For example, if someone opens a new issue or makes a push – the workflow begins running.

</details>

<details>
<summary><strong>Task 2 – Basic CI Pipeline for Testing ✅</strong></summary>

A GitHub Actions workflow was created at `.github/workflows/ci.yml` to implement Continuous Integration (CI) for this project.

### 🎯 Requirements

The pipeline meets the following requirements:
- ✅ Runs on every `push` and `pull_request` to any branch.
- ✅ Installs dependencies via `npm ci`.
- ✅ Runs the test script (`npm test`).

### 🛠️ Technology Used

This CI workflow is based on **Node.js**, and runs against Node versions **18.x**, **20.x**, and **22.x** in parallel using a matrix strategy. This helps ensure compatibility with different versions of Node.

---

## 📁 File: `.github/workflows/ci.yml`

```yaml
name: Node.js CI

on:
  push:
    branches: [ "*" ]        # Triggers on push to any branch
  pull_request:
    branches: [ "*" ]        # Triggers on pull request to any branch

jobs:
  build:
    runs-on: ubuntu-latest   # Runner environment: latest Ubuntu

    strategy:
      matrix:
        node-version: [18.x, 20.x, 22.x]  # Test against multiple Node.js versions

    steps:
    - uses: actions/checkout@v4          # Checkout the repository code

    - name: Use Node.js ${{ matrix.node-version }}
      uses: actions/setup-node@v4
      with:
        node-version: ${{ matrix.node-version }}          # Set the node version dynamically
        cache: 'npm'                                      # Cache node_modules for faster builds
        cache-dependency-path: week5/week5_practice/ci-practice/package-lock.json

    - run: npm ci
      working-directory: week5/week5_practice/ci-practice  # Clean install dependencies

    - run: npm run build --if-present
      working-directory: week5/week5_practice/ci-practice  # Optional build step

    - run: npm test
      working-directory: week5/week5_practice/ci-practice  # Run tests
```

### 🔁 Workflow Explanation

| Step                         | Purpose                                                                 |
|-----------------------------|-------------------------------------------------------------------------|
| `on: push/pull_request`     | Triggers the workflow on any branch push or pull request                |
| `matrix.node-version`       | Runs the same job using Node.js 18, 20, and 22                          |
| `npm ci`                    | Installs dependencies quickly and predictably using `package-lock.json` |
| `npm run build --if-present`| Executes build script if defined in `package.json`                      |
| `npm test`                  | Executes unit tests for the project                                     |

---

## 📌 Notes

- `working-directory` ensures all npm commands run inside the actual project path (`week5/week5_practice/ci-practice`).
- Using a matrix strategy helps detect compatibility issues with multiple Node.js versions.
- `actions/setup-node@v4` handles Node installation and caching.
- `npm ci` is preferred in CI/CD environments for clean and reproducible installs.

---

</details>

<details>
<summary><strong>Task 3 – Matrix Strategy ✅</strong></summary>

### 🎯 Goal
Modify the CI workflow to run tests using a matrix strategy.  
This allows testing across multiple versions of a language runtime (e.g., Node.js 18.x, 20.x, 22.x) to ensure compatibility.

---

### 📋 Checklist

- [x] Define a matrix for versions  
- [x] Confirm that the workflow runs once per version

---

### 🛠️ Files Modified

> `.github/workflows/ci.yml`

```yaml
name: Node.js CI

on:
  push:
    branches: [ "*" ]
  pull_request:
    branches: [ "*" ]

jobs:
  build:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [18.x, 20.x, 22.x]

    steps:
      - uses: actions/checkout@v4

      - name: Use Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          cache: 'npm'
          cache-dependency-path: week5/week5_practice/ci-practice/package-lock.json

      - run: npm ci
        working-directory: week5/week5_practice/ci-practice

      - run: npm run build --if-present
        working-directory: week5/week5_practice/ci-practice

      - run: npm test
        working-directory: week5/week5_practice/ci-practice
```

### 📘 Explanation

**Matrix Strategy**  
The matrix section defines multiple Node.js versions to test against. This will cause the job to run separately for each version defined.

</details>

<details>
<summary><strong>Task 4 – Artifacts and Post-job Monitoring ✅</strong></summary>

### 🧩 What was added

In this task, we extended our CI workflow with two main additions:

1. **Upload an artifact after the job runs**
2. **Verify service availability using `curl` as a post-job step**

---

### 📦 Artifact Upload

```yaml
- run: mkdir -p artifact
  working-directory: week5/week5_practice/ci-practice

- run: echo hello > artifact/world.txt
  working-directory: week5/week5_practice/ci-practice

- uses: actions/upload-artifact@v4
  with:
    name: my-artifact
    path: week5/week5_practice/ci-practice/artifact/world.txt
```

### 📘 Explanation: Artifact Creation and Upload

- `mkdir -p artifact`: Creates a directory named `artifact` in the project subfolder.

- `echo hello > artifact/world.txt`: Adds a test file with content `"hello"` to simulate a build artifact.

- `actions/upload-artifact`: Uploads the file to GitHub Actions. It becomes available under the **Artifacts** tab for download.

---

### 🌐 Post-Job: Validate Service Availability

```yaml
- name: Check service availability
  run: |
    curl --fail --silent https://jsonplaceholder.typicode.com/posts || echo "Service not available"
```

### 📘 Explanation: Validate Service Availability

This step verifies that an external service or deployment endpoint is reachable.

- `curl --fail --silent`: Sends the request silently (without outputting response data), and causes the step to fail if the HTTP request fails (e.g., returns a 4xx or 5xx status).
  
- The `|| echo "Service not available"` part ensures that a meaningful message is shown in case the `curl` command fails.
 
</details>

<details>
<summary><strong>Task 5 – Slack/Discord Integration ✅</strong></summary>

In this task, we extended our GitHub Actions workflow to send notifications to **Slack** and **Discord** upon job success or failure using webhooks.

### ✅ What Was Added

We added two new steps to each job (`build` and `artifacts`) that:

- Determine the job result (success/failure).
- Send a notification to Slack and Discord using a webhook.
- Include helpful information such as job name, Node.js version (in the `build` job), and repository name.

### What is a Webhook?

A **webhook** is a way for an application to send real-time data to another service when certain events occur.  
In the context of GitHub Actions, a webhook URL (like a Discord or Slack webhook) acts as an endpoint that receives a message from the workflow when a job completes.  
This allows notifications or updates to be automatically sent to platforms like Slack or Discord without requiring manual polling or API requests.

### 🔧 Webhook Setup

1. **Slack:**
   - Create a [Slack Incoming Webhook](https://api.slack.com/messaging/webhooks).
   - Save the URL as a secret in your GitHub repository:
     - Name: `SLACK_WEBHOOK_URL`

2. **Discord:**
   - Go to your Discord server → Settings → Integrations → Webhooks.
   - Create a new webhook and copy the URL.
   - Save it as a secret:
     - Name: `DISCORD_WEBHOOK_URL`

> Note: Secrets are added in your GitHub repo under **Settings → Secrets → Actions**.

---

### 📄 Sample Notification Step

```yaml
- name: Notify Discord
  if: always()
  run: |
    STATUS="Failed"
    if [ "${{ job.status }}" == "success" ]; then
      STATUS="Succeeded"
    fi

    curl -H "Content-Type: application/json" \
         -X POST \
         -d "{\"content\": \"GitHub Actions job **${{ github.job }}** finished with status: $STATUS in repo: ${{ github.repository }}\"}" \
         ${{ secrets.DISCORD_WEBHOOK_URL }}
```

```yaml
- name: Notify Slack
  if: always()
  run: |
    STATUS="Failed"
    if [ "${{ job.status }}" == "success" ]; then
      STATUS="Succeeded"
    fi

    curl -H 'Content-type: application/json' \
         -X POST \
         --data "{\"text\":\"GitHub Actions job **${{ github.job }}** $STATUS in repo: ${{ github.repository }}\"}" \
         ${{ secrets.SLACK_WEBHOOK_URL }}
```

---

### 🧠 Explanation

- `if: always()` – ensures the step runs whether the job passes or fails.
- `STATUS="Failed"` – default value for failed jobs.
- `if [ "${{ job.status }}" == "success" ]` – changes status to Succeeded if job passed.
- `curl` – command-line tool to send HTTP requests.
- `-H` – sets request header (e.g., content type as JSON).
- `-X` – specifies the HTTP method (e.g., `POST`, `GET`, etc.). Here, we use `POST` to send data.
- `-d` or `--data` – specifies the body of the HTTP request (in JSON format).

---

### 🏁 Outcome

At the end of each job, you now receive:
- A **Discord message** in your chosen channel.
- A **Slack message** to your workspace.

Both contain:
- The name of the job (e.g., `build`, `artifacts`)
- The final status (✅ Succeeded / ❌ Failed)
- The name of the GitHub repository
- (In `build`) The Node.js version used.

---

</details>

<details>
<summary><strong>Task 6 – Combined Frontend and Backend CI/CD ✅</strong></summary>

In this task, we created a GitHub Actions workflow that performs CI/CD operations for both the frontend and backend parts of the project.

## ✔ Checklist Implemented

- ✅ Runs tests for both **frontend** and **backend**
- ✅ Uploads build artifacts for both (optional, can be extended)
- ✅ Prints a final success message if both flows finish successfully

## 📁 Project Structure

```plaintext
week5/week5_practice/ci-practice/
├── frontend/
│   └── package.json
├── backend/
│   ├── build.gradle.kts
│   ├── gradlew
│   └── src/
```

## 🛠 Workflow Overview

The workflow is split into **three jobs**:

### 🔹 `frontend` job

- Uses `actions/setup-node` to install Node.js versions (18.x and 20.x).
- Runs:
  - `npm ci`
  - `npm run build --if-present`
  - `npm test`
- Sends a notification to Discord with job status.

### 🔹 `backend` job

- Uses `actions/setup-java` to install JDK 17.
- Builds the Kotlin Spring Boot backend using Gradle:
  - `./gradlew build`
  - `./gradlew test`

> 🛠 Note: We added execution permissions using `chmod +x ./gradlew` to avoid the “Permission denied” error on Linux runners.

### 🔹 `success-message` job

- Runs only **after** both `frontend` and `backend` succeed.
- Prints:  
  `"Both frontend and backend CI/CD flows completed successfully!"`

## 🔧 Sample CI/CD Workflow

```yaml
name: Combined Frontend and Backend CI/CD

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  frontend:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [ 18.x, 20.x ]

    steps:
      - uses: actions/checkout@v4

      - name: Use Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          cache: 'npm'
          cache-dependency-path: week5/week5_practice/ci-practice/frontend/package-lock.json

      - run: npm ci
        working-directory: week5/week5_practice/ci-practice/frontend

      - run: npm run build --if-present
        working-directory: week5/week5_practice/ci-practice/frontend

      - run: npm test
        working-directory: week5/week5_practice/ci-practice/frontend

      - name: Notify Discord
        if: always()
        run: |
          STATUS="Failed"
          if [ "${{ job.status }}" == "success" ]; then
            STATUS="Succeeded"
          fi
          curl -H "Content-Type: application/json" \
               -X POST \
               -d "{\"content\": \"Frontend job finished with status: $STATUS\"}" \
               ${{ secrets.DISCORD_WEBHOOK_URL }}

  backend:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Set up JDK
        uses: actions/setup-java@v4
        with:
          distribution: 'temurin'
          java-version: '17'

      - name: Grant Gradle wrapper permission
        run: chmod +x ./gradlew
        working-directory: week5/week5_practice/ci-practice/backend

      - name: Build backend with Gradle
        run: ./gradlew build
        working-directory: week5/week5_practice/ci-practice/backend

      - name: Run backend tests
        run: ./gradlew test
        working-directory: week5/week5_practice/ci-practice/backend

  success-message:
    runs-on: ubuntu-latest
    needs: [ frontend, backend ]

    steps:
      - name: Echo success message
        run: echo "Both frontend and backend CI/CD flows completed successfully!"
```

</details>
