# Managing infrastructure as code with Terraform, Cloud Build, and GitOps

This repo explains how to manage infrastructure as code with Terraform and Cloud Build using GitOps.

## Configuring Terraform to store state in a Cloud Storage bucket
1. In Cloud Shell, create the Cloud Storage bucket:

        PROJECT_ID=$(gcloud config get-value project)
        gsutil mb gs://${PROJECT_ID}-tfstate

1. Enable Object Versioning to keep the history of your deployments:

        gsutil versioning set on gs://${PROJECT_ID}-tfstate

## Trigger Cloud Build to build a new image with each commit

1. Connect your repository to Cloud Build
1. Create a trigger

## Enforcing Cloud Build execution success before merging branches
To make sure merges can be applied only when respective Cloud Build executions are successful, proceed with the following steps:

1. On GitHub, navigate to the main page of your forked repository.
1. Under your repository name, click Settings.
1. In the left menu, click Branches.
1. Under Branch protection rules, click Add rule.
1. In Branch name pattern, select dev.
1. In Rule settings, select Require status checks to pass before merging, and then in Status checks found in the last week for this repository, click Build.
1. Click Create.
1. Repeat steps 5–8, setting Branch name pattern to prod.

This configuration is important to protect both the dev and prod branches. Meaning, commits must first be pushed to another branch, and only then they can be merged to the protected branch. In this tutorial, the protection requires that the Cloud Build execution be successful for the merge to be allowed.

## Promoting your environment to **production**

Once you have tested your app (in this example an apache2 http server), you can promote your configuration to prodution. This step will:
 1. Configure an apache2 http server on network '**prod**' and subnet '**prod**-subnet-01'
 2. Open port 80 on firewall for this http server

```bash
cd ../prod
terraform init
terraform plan
terraform apply
terraform destroy
```
