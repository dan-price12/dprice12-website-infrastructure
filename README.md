# Salient Technology Consulting Website Infrastructure

This repository contains the terraform/terragrunt code used to provision the infrastructure for the Salient Technology Consulting Website. To run locally, the terraform and terragrunt CLI must be installed and available.

The following environment variables are required to authenticate to Microsoft Azure:

- `ARM_CLIENT_ID`: An Azure Client ID with sufficient permissions to manage infrastructure.
- `ARM_CLIENT_SECRET`: The Client Secret for the above Client ID.
- `ARM_TENANT_ID`: The Tenant ID where infrastructure will be provisioned.
- `ARM_SUBSCRIPTION_ID`: The Subscription ID where infrastructure will be provisioned.

When running locally, these must be set in the terminal session prior to running any terragrunt commands.

Back-end state is stored in an Azure blob container.

# Action Pipelines

There are deployment pipelines to deploy to Development, Staging, and Production environments. These actions will check and validate the terragrunt and terraform files, run `terragrunt plan`, and finally `terragrunt apply` to the appropriate environment.
