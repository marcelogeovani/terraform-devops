# DevOpsChallenge



## Components

| Name | Description | 
|------|-------------|
| main.tf | AWS provider|
| lb.tf | ALB, Target Group,Listener|  
| discovery.tf | Service discovery |  
| ecr.tf | ECR repository |  
| ecs.tf | ECS Cluster, Service, Task Definition | 
| env.tf | variables | 
| iam.tf | IAM role | 
| local.tf | local variables |
| logs.tg | CloudWatch logs |
| network.tf | Availability zones, VPC, subnets, internet gateway, aws route, nat gateway|
| output.tf | output variables |
| security.tf | security group|

## Dependencies
```
# Install and configure docker
# Install and configure aws-cli
```

## Usage

```
# Sets up aws-cli
$ aws configure


# Sets up Terraform to run
$ terraform init

# Executes the Terraform run
$ terraform apply "

# run the application
After finishing the execution, an output will be displayed with the loadbalance access url, 
just wait for the container to be included in the target group and access the informed url.
This application use local state.
```


## Inputs

| Name | Description | Type | Default | 
|------|-----------|:----:|:-----:|
| app-name | The application's name | string | - | 
| access_key | access key to access AWS | string | - |
| secret_key | secret key to access AWS | string | - |
| region | region default AWS | string | us-east-1 | 
| env | Define profile| string | dev | 
| app-backend-image | Name backend image | string | geovs/bethehero-backend:latest | 
| app-frontend-image | Name frontend image | string | geovs/bethehero-frontend:latest | 
| az_count | Numbers of az | int | 2 | 
| ecs_task_exection_role_name | Role ecs task name  | string | EcsTaskExecutionRoleDevops | 
| fargate_backend_cpu | desired number of cpu  | int | 512 | 
| fargate_backend_memory | desired number of memory  | int | 1024 | 
| fargate_frontend_cpu | desired number of cpu  | int | 512 | 
| fargate_frontend_memory | desired number of memory  | int | 1024 | 
| frontend_port | The port the container will listen on| int | 3000 |
| backend_port | The port the container will listen on| int | 3031 |
| app_frontend_count | desired number of frontend tasks| int | 1 |
| app_backend_count | desired number of backend tasks| int | 2 |
| health_check_path | health check url | string | / |
| service_discovery_namespace | Name for service discovery | string | local |
| cidrblock | cidr block | string | 10.1.0.0/16 |

## Outputs

| Name | Description |
|------|-------------|
| ecs_task_definition_arn_frontend |arn task definition frontend |
| ecs_task_definition_arn_backend | arn task definition frontend|
| alb_url | url to access the application |
