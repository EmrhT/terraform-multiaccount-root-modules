# Multi Account, Multi Environment, Multi Resource Playground
This module is a basic boilerplate for multi account, multi environment and multi resource deployments. It is based on Yevgeniy Brikman's repo --> https://github.com/brikis98/terraform-up-and-running-code

## Multi environment
1. Dev and Stage environments' root modules exist here
2. Within environments, each resource group has its own folder (e.g, services and data-store)
3. They are both consuming the same child modules to keep it DRY.
4. Child modules live in another repo in accordance with best practices.

## How to run manually
1. You're a devops/platform engineer who has a user living in a devops/platform account
2. Before you execute terraform commands and provision resources, you should assume a role in related account.
3. awsume is a great tool to assume roles practically. 
4. Within each env's directory, find your way to the resource's root module (e.g dev/data-stores/mysql)
5. A sample aws-config is given for reference. Simply use "awsume dev-admin/stage-admin" to assume roles in these accounts.
6. Check if you have the correct identity with "aws sts get-caller-identity"
7. Run terraform init, plan, apply

## How to create a CI/CD Pipeline with GitHub Actions
1. TODO