install:
	kubectl create -f storage_class.yaml
	helm install --name prometheus stable/prometheus \
		--set alertmanager.persistentVolume.storageClass=gp2 \
		--set server.persistentVolume.storageClass=gp2

uninstall:
	kubectl delete -f storage_class.yaml
	helm delete --purge prometheus	

.PHONY: install uninstall
