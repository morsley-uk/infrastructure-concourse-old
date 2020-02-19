# Infrastructure - Concourse

The most simple provisioning of Concourse for use with our Walking Skeleton.

## AWS

To make things as simple as possible, let's use the modules available withing Terraform.

### Backend

```
terraform init --backend-config="access_key=[]" --backend-config="secret_key=[]"
```

### ToDo 

1. Route 53 --> concourse.morsley.io