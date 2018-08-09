install:
	helm upgrade --install etcd-operator stable/etcd-operator
	kubectl apply -f etcd-cluster.yaml

uninstall:
	kubectl delete -f etcd-cluster.yaml
	helm delete --purge etcd-operator

.PHONY: install uninstall
