# ETCD

Installs [etcd-operator](https://github.com/helm/charts/tree/master/stable/etcd-operator)

## Install

- The **ETCD_YAML** env is optional, but accepts a path to a **value.yaml** file for further [configuration](https://github.com/helm/charts/tree/master/stable/etcd-operator#configuration) on etcd-operator.

`make install` or `make install ETCD_YAML=""`


### Optionals

- Once your etcd-operator is up and running you have two options to access it. You can expose the service or access it via another pod. If you have no external services, we suggest that you use internal access only.

#### Internal Access

This can be used to access the k/v store internally, other services in the cluster can get and put variables to etcd. This is a great option if you are concerned about security or don't require any external services.

```bash
kubectl run --rm -i --tty fun --image quay.io/coreos/etcd --restart=Never -- /bin/sh
ETCDCTL_API=3 etcdctl --endpoints http://etcd-cluster-client:2379 put foo bar
```

#### External Access

The etcd client API should now be accessible from outside the Kubernetes cluster. Also note that it will automatically create the load balancer with a publicly accessible IP.

1. Expose your etcd cluster by running `kubectl create -f etcd-service.yaml` and wait for it be available (use ping {service-ip})
2. `kubectl describe service etcd-client-service-lb` and copy the loadbalancer ingress

3. Install the [etcdctl](https://github.com/coreos/etcd/tree/master/etcdctl) or use the etcd docker images

```
export ETCDCTL_API=3
export ETCDCTL_ENDPOINTS={ip}:2379
./etcdctl put foo bar
./etcdctl get foo
```

[More Info](https://github.com/coreos/etcd-operator/blob/master/doc/user/client_service.md)