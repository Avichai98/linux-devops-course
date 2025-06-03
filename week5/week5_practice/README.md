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

- `curl --fail --silent`: Attempts a silent request and fails the step if the service is unreachable.
  
- The `|| echo "Service not available"` part ensures that a meaningful message is shown in case the `curl` command fails.
 
</details>

<details>
<summary><strong>Task 5 – Slack/Discord Integration</strong></summary>

- Send a message via webhook or action on job success/failure
- (Bonus) Add job name, duration, or summary

</details>

<details>
<summary><strong>Task 6 – Combined Frontend and Backend CI/CD</strong></summary>

- Handle CI/CD for both frontend and backend
- Optionally upload build artifacts
- Echo a message confirming both parts succeeded

</details>
