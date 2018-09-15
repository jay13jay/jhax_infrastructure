# jhax_infrastructure
Infra scripts to provision and manage JHAX infrastructure

# Requirements
- Terraform (64-bit Windows binary provided in bin/ folder)
  - All other OS users can download here: https://www.terraform.io/downloads.html
- An AWS account (Signup link: https://amzn.to/2xjyzYH)
- git

# How to use
#### Please note: provided paths are for convenience and can be changed if you'd like, and know how
1) Clone the repository and create secrets directory
    ```bash
    git clone git@github.com:jay13jay/jhax_infrastructure.git && cd jhax_infrastructure;mkdir Terraform/Wordpress/secret
    ```
2) Create a file called `config.tf` in the Terraform/ folder
    ```bash
    provider "aws" {
       access_key = "YOUR_KEY_ID"
       secret_key = "YOUR_KEY"
       region     = "REGION"
    }
    ```

3) Create a KeyPair named 'wordpress' in your AWS dashboard. Place the .pem file into `Terraform/Wordpress/secret/wordpress.pem`

4) Run Terraform!
    ```bash
    # Change to the wordpress directory
    cd Terraform/Wordpress
    # Get a plan for changes that will be made
    terraform plan
    # Apply changes and spin up infrastructure
    terraform apply
    
    ```