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
<summary><strong>Task 3 – Matrix Strategy</strong></summary>

- Modify CI workflow to use matrix strategy (e.g., Node.js 14, 16, 18)
- Confirm it runs per version

</details>

<details>
<summary><strong>Task 4 – Artifacts and Post-job Monitoring</strong></summary>

- Upload test artifacts using `actions/upload-artifact`
- Use `curl` or similar to validate endpoint in post-job step

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
