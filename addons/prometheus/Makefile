install:
	kubectl apply -f storage_class.yaml
	helm upgrade --install prometheus stable/prometheus \
		--set alertmanager.persistentVolume.storageClass=gp2 \
		--set server.persistentVolume.storageClass=gp2

uninstall:
	kubectl delete -f storage_class.yaml --ignore-not-found
	helm delete --purge prometheus	

.PHONY: install uninstall
