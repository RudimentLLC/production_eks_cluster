## Enabling the Kubernetes Dashboard

Run the Makefile we've included to configure the [EKS Kubernetes Dashboard](https://docs.aws.amazon.com/eks/latest/userguide/dashboard-tutorial.html). 

```
make install
```

After the Makefile finishes, you'll be presented with a `token` string:

```
Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     1025 bytes
namespace:  11 bytes
token:      LONG TOKEN STRING REDACTED
```

Copy this string; you'll use it to log into the Kubernetes Dashboard later.

Next, enable the EKS API proxy:

```
kubectl proxy
```

After the proxy is available locally, visit the Kubernetes Dashboard at [http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/](http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/). Use the token you copied previously for sign in.
