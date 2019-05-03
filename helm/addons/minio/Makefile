install:
	helm upgrade --install minio-eks stable/minio --values=values.yaml

uninstall:
	-helm delete --purge minio-eks 

.PHONY: install uninstall
