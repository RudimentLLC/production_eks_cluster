install:
	helm upgrade --install cluster-autoscaler stable/cluster-autoscaler --values=values.yaml

uninstall:
	-helm delete --purge cluster-autoscaler

.PHONY: install uninstall
