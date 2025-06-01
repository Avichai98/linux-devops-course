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
<summary><strong>Task 2 – Basic CI Pipeline for Testing</strong></summary>

- Create `.github/workflows/ci.yml`
- Run on push and pull_request
- Install dependencies
- Run test script (e.g., `npm test`, `pytest`)

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
