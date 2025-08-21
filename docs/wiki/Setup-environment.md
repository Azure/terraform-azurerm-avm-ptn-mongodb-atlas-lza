# Environment Setup

This document describes the required environment variables, prerequisites, and setup steps for running Terraform and automation pipelines.

---

## Table of Contents

- [Variable Overview](#variable-overview)
- [Setting Environment Variables Locally](#setting-environment-variables-locally)
- [Pipeline / CI Setup](#pipeline--ci-setup)
- [Additional Notes](#additional-notes)

---

## Variable Overview

| Variable                        | When to Set                                      | Purpose                                       |
|----------------------------------|--------------------------------------------------|-----------------------------------------------|
| `ARM_SUBSCRIPTION_ID`            | Before any step (including step 00-devops)        | Azure subscription for all resources          |
| `MONGODB_ATLAS_PUBLIC_API_KEY`   | After creating Atlas org (after step 00-devops)   | MongoDB Atlas API access (from step 01 onward)|
| `MONGODB_ATLAS_PRIVATE_API_KEY`  | After creating Atlas org (after step 00-devops)   | MongoDB Atlas API access (from step 01 onward)|

---

## Setting Environment Variables Locally

Set the required variables in your terminal session before running Terraform or automation scripts.

### macOS/Linux or Bash on Windows

```bash
export ARM_SUBSCRIPTION_ID="<your-subscription-id>"
# After step 00-devops:
export MONGODB_ATLAS_PUBLIC_API_KEY="<ATLAS_PUBLIC_KEY>"
export MONGODB_ATLAS_PRIVATE_API_KEY="<ATLAS_PRIVATE_KEY>"
```

### Windows (Command Prompt)

```bat
set ARM_SUBSCRIPTION_ID=<your-subscription-id>
:: After step 00-devops:
set MONGODB_ATLAS_PUBLIC_API_KEY=<ATLAS_PUBLIC_KEY>
set MONGODB_ATLAS_PRIVATE_API_KEY=<ATLAS_PRIVATE_KEY>
```

### Windows (PowerShell)

```powershell
$env:ARM_SUBSCRIPTION_ID = "<your-subscription-id>"
# After step 00-devops:
$env:MONGODB_ATLAS_PUBLIC_API_KEY = "<ATLAS_PUBLIC_KEY>"
$env:MONGODB_ATLAS_PRIVATE_API_KEY = "<ATLAS_PRIVATE_KEY>"
```

---

## Pipeline / CI Setup

### GitHub Environment Requirements

You must create a GitHub environment named `dev` in your repository settings. See the [Creating a GitHub Environment](https://docs.github.com/en/actions/how-tos/deploy/configure-and-manage-deployments/manage-environments#creating-an-environment) documentation for instructions.

In this environment, set the following:

- **Secrets:**
  - `MONGODB_ATLAS_PUBLIC_KEY` (Atlas public API key)
  - `MONGODB_ATLAS_PRIVATE_KEY` (Atlas private API key)
- **Variables:**
  - `ARM_CLIENT_ID`
  - `ARM_SUBSCRIPTION_ID`
  - `ARM_TENANT_ID`
  - `BACKEND_CONTAINER` (from the `container_name` output of step 00-devops)
  - `BACKEND_RG` (from the `resource_group_name` output of step 00-devops)
  - `BACKEND_STORAGE_ACCOUNT` (from the `storage_account_name` output of step 00-devops)

---

## Additional Notes

- Each environment (`dev`, `test`, `prod`, etc.) should have its own folder under `envs/` inside the respective single-region or multi-region folder.
- Never hardcode sensitive values (such as API keys or subscription IDs) directly in code or version control.

---
