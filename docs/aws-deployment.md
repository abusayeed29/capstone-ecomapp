# AWS deployment with GitHub Actions

This repository includes a GitHub Actions workflow at `.github/workflows/deploy-aws.yml` that deploys the app to an EC2 instance using Docker and Amazon ECR when code is pushed to `main` or when the workflow is run manually.

## What the workflow does

1. Installs PHP 8.2 and Node.js 20.
2. Creates a temporary CI `.env`, generates an app key, and runs the Laravel test suite against SQLite.
3. Builds a Docker image from the repository.
4. Pushes the image to Amazon ECR using GitHub OIDC and an AWS IAM role.
5. Connects to the EC2 instance over SSH.
6. Pulls the new image, replaces the running container, and runs Laravel deploy tasks.

## AWS setup

Create:

- An ECR repository for the application image
- An EC2 instance with Docker and AWS CLI installed
- An IAM role that GitHub Actions can assume with OIDC

The EC2 instance also needs:

- A deployment user that can run `docker` and `aws`
- An application env file already present on the server, for example `/opt/ecommerce-app/.env`
- A persistent storage directory, for example `/opt/ecommerce-app/storage`

The workflow will run these Laravel commands on the EC2 host after the container starts:

- `php artisan storage:link --force`
- `php artisan migrate --force`
- `php artisan optimize:clear`
- `php artisan config:cache`

## GitHub repository configuration

Add these repository secrets:

- `AWS_ROLE_TO_ASSUME`: the IAM role ARN that GitHub Actions will assume with OIDC
- `EC2_SSH_PRIVATE_KEY`: the private SSH key used to connect to the EC2 instance

Add these repository variables:

- `AWS_REGION`: AWS region, for example `us-east-1`
- `ECR_REPOSITORY`: ECR repository name
- `EC2_HOST`: public DNS name or IP of the EC2 instance
- `EC2_SSH_USER`: SSH user on the EC2 instance
- `APP_CONTAINER_NAME`: Docker container name, for example `ecommerce-app`
- `APP_ENV_FILE`: absolute path to the production `.env` file on EC2, for example `/opt/ecommerce-app/.env`
- `APP_STORAGE_PATH`: absolute path to the persistent storage directory on EC2, for example `/opt/ecommerce-app/storage`

## EC2 environment variables

Set your production environment values in the env file referenced by `APP_ENV_FILE`, not in the repository.

Minimum recommended values:

- `APP_ENV=production`
- `APP_DEBUG=false`
- `APP_URL=https://your-domain.example`
- `APP_KEY=base64:...`
- `DB_CONNECTION=mysql`
- `DB_HOST=your-rds-or-mysql-host`
- `DB_PORT=3306`
- `DB_DATABASE=...`
- `DB_USERNAME=...`
- `DB_PASSWORD=...`

If you use RDS, set the standard Laravel `DB_*` values to the RDS endpoint.

## First deploy checklist

1. Push the workflow changes to GitHub.
2. Create the IAM OIDC trust and deployment role in AWS.
3. Create the ECR repository.
4. Install Docker and AWS CLI on the EC2 instance.
5. Add the GitHub secrets and variables.
6. Create the production env file on EC2.
7. Run the `Deploy Ecom App to AWS EC2` workflow or push to `main`.
