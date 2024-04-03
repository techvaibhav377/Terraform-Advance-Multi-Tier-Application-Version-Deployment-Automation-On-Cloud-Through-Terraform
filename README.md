# Automated Multi-Tier Application Deployment with Secure Database

Author: **Vaibhav Gautam**

## 🚀 Project Overview

This Terraform project automates the deployment of a multi-tier web application architecture on AWS, featuring secure database integration and automatic updates via S3. The infrastructure includes an Application Load Balancer (ALB), auto-scaling group, EC2 instances, security groups, IAM roles, S3 bucket for content updates, and a Virtual Private Cloud (VPC) with public and private subnets.

## 📂 Project Structure

- **keypair.tf**: Securely manages AWS key pairs for SSH access.
- **lb-tg.tf**: Orchestrates the setup of the Application Load Balancer, target group, and attachments.
- **providers.tf**: Configures the AWS provider with region and credentials for secure access.
- **resource.tf**: Defines EC2 instances, IAM roles, and instance profiles for secure application deployment.
- **s3-bucket-and-role.tf**: Establishes an S3 bucket for automatic application updates and an IAM role for secure EC2 instance access.
- **security-group.tf**: Constructs security groups for EC2 instances and databases to ensure a secure environment.
- **template.tf**: Configures launch configurations with encrypted user data for secure application deployment.
- **variable.tf**: Declares input variables to customize and enhance the deployment process.
- **vpc-public-pvt-subnet.tf**: Creates a Virtual Private Cloud (VPC), subnets, route tables, and a NAT gateway to maintain a secure network environment.
- **script.sh**: Executes a secure bash script for configuring the web server and DNS.
- **vaibhav.pub**: Public SSH key for authorized access to EC2 instances.
- **vaibhav.pem**: Private SSH key for authorized access to EC2 instances.

## 🛠️ Deployment Steps

1. **Set Up AWS Credentials**: Ensure secure AWS access and secret keys are configured in `providers.tf`.
2. **Customize Input Variables**: Modify input variables in `variable.tf` to tailor the deployment to your specific requirements.
3. **Initialize Terraform**: Execute `terraform init` to initialize the working directory securely.
4. **Preview Changes**: Utilize `terraform plan` to review and validate the proposed infrastructure changes securely.
5. **Apply Changes**: Apply secure changes by executing `terraform apply` to provision the infrastructure.
6. **Access the Website**: Access the deployed website securely using the public IP address of the Application Load Balancer.

## 🔒 Requirements

- Terraform installed on your local machine for secure infrastructure as code deployment.
- AWS account with appropriate permissions for secure access.
- Fundamental understanding of AWS services and Terraform concepts for secure infrastructure management.

## 📝 License

This project is licensed under the techvaibhav.site.

---

Feel free to adjust the content further to meet your specific project requirements and preferences! If you need any more assistance, just let me know.
