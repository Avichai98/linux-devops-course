# Git Practice – Week 4 Tasks

This repository includes daily Git practice tasks for Week 4. Each task demonstrates key Git concepts and workflows. Click on a task to expand and view the details.

---

<details open>
<summary>✅ Task 1: Branching & Switching</summary>

### 1. Initialize a Local Git Repository

```bash
git init
```
Creates an empty Git repository in the current directory.

---

### 2. Create and Switch to `feature-a` Branch

Attempting to run `git branch feature-a` before any commits results in:

```bash
fatal: not a valid object name: 'main'
```
This is because Git requires at least one commit to serve as the base for the new branch.

Instead, use:
```bash
git checkout -b feature-a
```

---

### 3. Create a File and Make an Initial Commit on `feature-a`

```bash
echo "example" > example.txt
git add example.txt
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git commit -m "Initial commit"
```
**Note:** Git requires a user name and email to be set before committing. Otherwise, it will throw an error like:
```
fatal: empty ident name (for <user@host>) not allowed
```

---

### 4. Create and Switch to `feature-b` Branch

```bash
git checkout -b feature-b
```

---

### 5. Create a Bash Script to Switch Back to `feature-a`

```bash
printf '#!/bin/bash\n\ngit switch feature-a\n' > switch_to_feature_a.sh
chmod +x switch_to_feature_a.sh
```

Script contents:
```bash
#!/bin/bash

git switch feature-a
```

---

### 6. Commit the Script in `feature-b`

```bash
git add switch_to_feature_a.sh
git commit -m "Add switch script"
```

---

### 7. Run the Script to Switch Branches

```bash
./switch_to_feature_a.sh
```
Output:
```
Switched to branch 'feature-a'
```

---

### 8. Create a Third Branch

Now that an initial commit exists, creating a new branch with `git branch feature-c` works as expected.

```bash
git branch feature-c
```

---

### 9. Branch Listing

When running `git branch -a` before any commits, Git returns nothing because no branches (beyond HEAD) have actual commit references.

After creating commits and branches, `git branch -a` shows all local branches, even if a branch has no commits yet (like `feature-c`).

</details>

---

<details>
<summary>✅ Task 2: Simulate and Resolve Merge Conflicts</summary>

### 🎯 Goal:
Modify the same file (`example.txt`) in both `feature-a` and `feature-b` to simulate a conflict and resolve it.

### ✅ Steps Performed:

**In `feature-b`:**
```bash
git switch feature-b
echo "adding conflict feature-b" >> example.txt
git add example.txt
git commit -m "Adding conflict feature-b"
```

**In `feature-a`:**
```bash
git switch feature-a
echo "adding conflict feature-a" >> example.txt
git add example.txt
git commit -m "Adding conflict feature-a"
```

**Merge `feature-b` into `feature-a`:**
```bash
git merge feature-b
```

You will see:
```
CONFLICT (content): Merge conflict in example.txt
Automatic merge failed; fix conflicts and then commit the result.
```

### 🛠️ Conflict Resolution:
Opened the folder using:
```bash
code .
```
Used the VS Code UI to resolve the conflict by selecting both changes.

**Final content of `example.txt`:**
```txt
example
adding conflict feature-a
adding conflict feature-b
```

Then:
```bash
git add example.txt
git commit -m "Resolve merge conflict between feature-a and feature-b"
```

### ✅ Final Status:
```bash
git status
# On branch feature-a
# nothing to commit, working tree clean
```

### ℹ️ Explanation of the Commit:
> The merge commit resolves a conflict between `feature-a` and `feature-b`, where both branches appended different lines to `example.txt`. Both changes were kept to preserve work from both branches.

### ⚠️ Note About `code .` Command:
Running `code .` just opens the current directory in VS Code — this command is helpful but not necessary for the Git workflow. It was used to assist visually in resolving the conflict.

</details>

---

<details>
<summary>✅ Task 3: Rebase and Cherry-Pick</summary>

## 🎯 Goal

- Use `git rebase` to reapply commits from `feature-a` onto `main`.
- Document what happens to the commit history.
- Use `git cherry-pick` to apply a single commit from `feature-b` to `main`.
- Explain the difference between `rebase` and `merge`.

---

## 🔁 Rebase

### ✔️ Commands Executed:

```bash
git checkout -b main
touch README.md
echo "# This is main" > README.md
git add README.md
git commit -m "Adding README file"
git switch feature-a
git rebase main
```

## 📝 Log Outputs After Rebase

Below are the three different ways used to inspect the commit history after rebase:

### 1. Using the branch name:
```bash
git log feature-a
```
🔹 This shows the commit history of `feature-a` even if you're not currently on that branch.  
🔹 It's useful to inspect another branch's log without switching to it.

### 2. Using `--oneline`:
```bash
git log --oneline
```
🔹 Shows the commit history in a compact single-line format per commit.

### 3. Current branch log:
```bash
git log
```
🔹 Shows the full commit history of the current branch.  

### 4. Using `--graph`:
```bash
git log --graph
🔹 Useful for understanding how branches diverged and merged over time.

---
## 📄 What Happens to the Commit History?

Rebasing `feature-a` onto `main` rewrites the commit history of `feature-a` so that it now appears as if all the commits from `main` came before any commits in `feature-a`. This creates a linear history and avoids a merge commit. It's as if `feature-a` was developed starting from the tip of `main`.

---

## 🍒 Cherry-Pick

### ✔️ Commands Executed:

```bash
git switch feature-b
echo "I'm feature-b" > README.txt
git add README.txt
git commit -m "Adding README for feature-b"
git switch main
git cherry-pick cc5ea79
```

Where `cc5ea79` is the commit hash of the "Adding README for feature-b" commit in `feature-b`.

---

## 🔀 Merge vs Rebase (In My Words)

The difference between merge and rebase is that when we use rebase, we rewrite the commits of the current branch and put in the beginning the commits of the other branch.  
For example, we are in the `feature-a` branch, and we use the command:  
`git rebase main`  
So now all the `main` commits are presented at the beginning of `feature-a`.  
A merge keeps the original commits as they are and adds a new commit representing the merge.

</details>

---

<details>
<summary>Task 4: GitHub Pull Requests & Code Review</summary>

- Push both branches (`feature-a`, `feature-b`) to your GitHub repository.
- Create a pull request from one branch into `main`.
- Request a review from a classmate or mentor.
- Write at least one constructive code comment in someone else's pull request.

</details>

---

<details>
<summary>Task 5: Stash, Amend, and Cleanup</summary>

- Make local changes and store them using `git stash`.
- Restore the changes using `git stash pop`.
- Amend your last commit using `git commit --amend`.
- Clean up local branches that have already been merged.

</details>
