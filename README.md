## What is this

This is terraform project that can be used to create VM and all nesessary surrounding infrastructure in AWS in order to launch openvpn instance (like [this one](https://github.com/angristan/openvpn-install)).

It uses Ubuntu Server 22.04 ami. Security group allows only SSH and openvpn ports. Openvpn port is configurable.

## How to use

Tfstate is stored in S3 bucket so it has to be created beforehand:
```
aws s3api create-bucket --bucket <bucket> --create-bucket-configuration LocationConstraint=<region>
```

Credentials can be provided via [env vars](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables).

Configure backend in `config/backend-example.conf`

Configure variables in `config/example.tfvars`

Then:
```
terraform get -update=true
terraform init -reconfigure -backend-config=config/backend-example.conf
terraform plan -var-file=config/example.tfvars
terraform apply -var-file=config/example.tfvars
```

Instance also uses remote-exec provisioner to configure hostname, so it expects that you have ssh private key loaded in SSH agent.

SSH user is `ubuntu`.
