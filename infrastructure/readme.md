To init terraform, you should run:

```
terraform init --backend-config=/path_to_file/backend.hcl
```

To apply:

```
terraform apply -var-file=/path_to_file/01-app.tfvars
```