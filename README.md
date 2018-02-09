# inspec-cloud-demo
Demo profiles for various cloud capabilities of InSpec 2.0

## Requirements

As of 2018-02-09, this requires inspec 2.0, which means a git clone of inspec on the release-2.0 branch.

Alternatively, you may use a stock 1.51.x series inspec, if you make these adjustments:
1. Export your AWS creds as env vars and remove the `-t aws://` CLI option
2. Modify the demo profiles to have a dependency on git@github.com:chef/inspec-aws.git (that is, use inspec-aws as a resource pack)

## Credentials

### AWS
Setup an AWS CLI profile.  You can use the integration testing profile, stored in LastPass under "inspec-aws AWS test accounts" secure note, test-fixture-maker credentials.  Any other IAM user able to make buckets and IAM users on an account will also work.  Place the credentials in a profile; here I'm using the profile name 'demo-profile'.  You can use `-t aws://us-east-2/demo-profile` to provide the creds to InSpec 2.0.

While InSpec can read credentials from a Train target, if you wish to modify the terraform setup, you'll need to export two environment vars: `AWS_PROFILE` and `AWS_REGION`. 

## Terraform Fixtures

Terraform code is included which may be used to setup the environment.  For the demo 2018-02-10, I've run Terrform already, so you just need to run InSpec against it.

To run the Terraform setup:
 ```bash
 cd aws/terraform
 terraform init
 terraform apply
 ```

Teardown:
```bash
terraform destroy --force
```

 ## Running the Demo

### Command line for AWS

 ```bash
 # in your inspec-2.0 clone
 bundle exec bin/inspec exec path/to/this/demo/aws/aws-demo/profile -t aws://us-east-2/demo-profile
 ```

 ### AWS expected results

 The demo includes a non-compliant S3 bucket; the others should pass.
 ```
   ×  Check our demo bucket for dangerous settings: S3 Bucket inspec-testing-public-default.chef.io
     ×  S3 Bucket inspec-testing-public-default.chef.io should not be public
     expected `S3 Bucket inspec-testing-public-default.chef.io.public?` to return false, got true
  ✔  Users that have a password but do not have MFA enabled: IAM Users with has_console_password has_mfa_enabled
     ✔  IAM Users with has_console_password has_mfa_enabled should not exist
  ✔  Do not allow access keys older than 90 days: IAM Access Keys with created_days_ago > 90
     ✔  IAM Access Keys with created_days_ago > 90 should not exist
 ```