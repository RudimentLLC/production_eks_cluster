# Minio + EKS

Until the Terraform Helm provider supports Helm 3, installing add-ons must be done by hand. Please add valid AWS credentials to lines 242 and 243 of `values-template.yaml`, and save the changes to `values.yaml`.

Then run:

```bash
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm install minio-eks stable/minio --values=values.yaml
```
