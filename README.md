# Arostark-Core Infrastructure

Production-grade AWS cloud infrastructure for Arostark, built and managed with Terraform. Security-first.

## Architecture Overview

- **VPC** — Isolated network with public and private subnets across multiple availability zones
- **Public Subnet** — For internet-facing resources (load balancers, bastion hosts)
- **Private Subnet** — For internal resources (databases, application servers)
- **Internet Gateway** — Controlled internet access for public subnet
- **Route Tables** — Traffic routing rules enforcing network segmentation

## Security Stack

- **CloudTrail** — Every API call logged across all regions with tamper detection via log file validation
- **GuardDuty** — Active threat detection monitoring for malicious activity and unauthorized behavior
- **Security Hub** — Centralized security findings aggregated against CIS AWS Foundations Benchmark v1.2.0
- **SNS Alerts** — Real-time email notifications on security findings

## CI/CD

- GitHub Actions runs Terraform plan on every push to main
- Zero manual infrastructure changes — everything is code

## Stack

- AWS (VPC, CloudTrail, GuardDuty, Security Hub, SNS, S3)
- Terraform v1.15.5
- GitHub Actions

## Project Status

| Component | Status |
|---|---|
| VPC & Networking | Complete |
| CloudTrail Audit Logging | Complete |
| GuardDuty Threat Detection | Complete |
| Security Hub + CIS Benchmark | Complete |
| SNS Security Alerts | Complete |
| GitHub Actions CI/CD | Complete |
| Lambda Auto-Remediation | Complete |
| AWS Config Resource Recording | Complete |
| AI Integration | Planned, coming soon |

## Screenshots

See `/screenshots` folder for console evidence of deployed infrastructure.