# Arostark-Core Infrastructure

Production-grade AWS cloud infrastructure for Arostark, built and managed with Terraform.

## Architecture Overview

- **VPC** — Isolated network with public and private subnets across multiple availability zones
- **Public Subnet** — For internet-facing resources (load balancers, bastion hosts)
- **Private Subnet** — For internal resources (databases, application servers)
- **Internet Gateway** — Controlled internet access for public subnet
- **Route Tables** — Traffic routing rules enforcing network segmentation

## Security Principles

- Network segmentation via public/private subnets
- All resources tagged and managed by Terraform — no manual console changes
- Least privilege networking — private resources have no direct internet exposure

## Stack

- AWS (VPC, Subnets, IGW, Route Tables)
- Terraform v1.15.5
- GitHub Actions (coming soon)

## Project Status

| Component | Status |
|---|---|
| VPC & Networking | ✅ Complete |
| Security Layer (GuardDuty, CloudTrail) | 🔄 In Progress |
| GitHub Actions CI/CD | ⏳ Planned |
| AI Integration | ⏳ Planned |

## Screenshots

See `/screenshots` folder for console evidence of deployed infrastructure.