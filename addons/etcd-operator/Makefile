install:
	helm install stable/etcd-operator --name etcd-operator
	kubectl create -f etcd-cluster.yaml

uninstall:
	kubectl delete -f etcd-cluster.yaml
	helm delete --purge etcd-operator

.PHONY: install uninstall
