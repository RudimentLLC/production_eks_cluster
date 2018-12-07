MAXTIMES = 3

install:
	helm upgrade --install etcd-operator stable/etcd-operator
	for i in {1..$(MAXTIMES)}; \
		do kubectl apply -f etcd-cluster.yaml; \
		if [ $$? -eq '0' ]; then break; fi; \
		sleep 5; \
	done; \

uninstall:
	kubectl delete -f etcd-cluster.yaml --ignore-not-found
	helm delete --purge etcd-operator

.PHONY: install uninstall
