# Terraform Landing Zone for MongoDB Atlas on Azure

## Overview

This repository provides a modular Terraform solution for deploying a secure MongoDB Atlas environment on Azure, featuring private networking, DevOps automation, and end-to-end cluster setup.  
It supports both **single-region** and **multi-region** deployments and includes automation for provisioning infrastructure, configuring Atlas clusters, and deploying a test application for connectivity validation.

The infrastructures can be deployed using the provided GitHub Actions workflows, or manually with Terraform.  
The recommended approach is to use the workflows for full automation; alternatively, you can deploy manually using the CLI and follow the step-by-step instructions.

> For step-by-step deployment guidance, see the [deployment guide](docs/wiki/Introduction.md).

---

## Disclaimer

> **Warning:** Deploying this infrastructure is **NOT free**.  
> It provisions paid resources such as a dedicated MongoDB Atlas cluster (minimum M10 tier for Private Endpoints), Azure networking components, and other Azure services. Review pricing details in the [MongoDB Atlas Private Endpoint documentation](https://www.mongodb.com/docs/atlas/security-private-endpoint/) before running `terraform apply`.

This code is provided for demonstration purposes and should not be used in production without thorough testing.  
You are responsible for validating the configuration and ensuring it meets your environment's requirements.

For questions or to discuss suitability for your use case, please create an issue in this repository.

By using this repository, you agree to assume all risks and use it at your own discretion. The authors are not liable for damages or losses from its use.  
See the [Support section](./SUPPORT.md) for details.

---

## Wiki

Please see the content in the [wiki](docs/wiki/Home.md) for more detailed information about the repo and various other pieces of documentation.

---

## Known Issues

See the [Known Issues page](docs/wiki/KnownIssues.md) for the latest list of limitations, workarounds, and open problems.

---

## Frequently Asked Questions

See the [FAQ](docs/wiki/FAQ.md) for common questions and answers.
