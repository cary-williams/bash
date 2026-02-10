# Bash Scripts and Utilities

This repo contains Bash scripts I’ve written to automate common operational, infrastructure, and security-related tasks. These are practical utilities used to solve real problems, not polished products or frameworks.

Most scripts are designed to be simple, readable, and easy to adapt to new environments.

---

## What You’ll Find Here

### Cloud and AWS
- **backup-to-s3.sh**  
  Pushes backups to Amazon S3.

- **rds-backup.sh**  
  Performs backups of AWS RDS databases.

- **rds-log-gather.sh**  
  Collects logs from RDS for troubleshooting or review.

- **cloudflare-log-push.sh**  
  Pushes Cloudflare logs fto S3.

---

### Infrastructure and IaC
- **install-terraform.sh**  
  Installs Terraform on a system using a specified version number.

- **terraform-setup.sh**  
  Helper for setting up Terraform environments and dependencies.

- **generate-state.sh**  
  Generates or prepares state-related files for infrastructure workflows.

---

### Jira and Workflow Automation
- **jira-comment.sh**  
  Adds comments to Jira tickets programmatically, useful for tying automation output back to tracking systems.

---

### SSL and Certificates
- **ssl-csr-generator.sh**  
  Generates SSL certificate signing requests.

- **ssl-csr-decoder.sh**  
  Decodes and inspects existing CSRs.

---

### System Utilities
- **ck-distro.sh**  
  Detects Linux distribution details.

- **install-apcupsd.sh**  
  Installs and configures APC UPS monitoring.

- **mapserv-status.sh**  
  Checks status of a map server service.

- **motd.sh**  
  Generates or updates message-of-the-day content.

- **sort_ips.sh**  
  Sorts IP address lists correctly.

- **whois.sh**  
  Runs whois lookups with cleaner output.

- **useful-snippets.sh**  
  Miscellaneous shell snippets that don’t warrant their own script.

- **help-template.sh**  
  Template for consistent help and usage output in scripts.

---

## Usage

Most scripts can be run directly:

```bash
chmod +x script-name.sh
./script-name.sh
