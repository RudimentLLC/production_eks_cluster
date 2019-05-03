install:
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/heapster.yaml
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/influxdb.yaml
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/rbac/heapster-rbac.yaml
	kubectl apply -f eks-admin-service-account.yaml
	kubectl apply -f eks-admin-cluster-role-binding.yaml
	@./get-token.sh

# https://github.com/kubernetes/dashboard/wiki/Installation#update
update: delete_pods

delete_pods:
	kubectl -n kube-system delete $(kubectl -n kube-system get pod -o name | grep dashboard)

uninstall: 
	kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml --ignore-not-found
	kubectl delete -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/heapster.yaml --ignore-not-found
	kubectl delete -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/influxdb.yaml --ignore-not-found
	kubectl delete -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/rbac/heapster-rbac.yaml --ignore-not-found
	kubectl delete -f eks-admin-service-account.yaml --ignore-not-found
	kubectl delete -f eks-admin-cluster-role-binding.yaml --ignore-not-found

.PHONY: install uninstall delete_pods update
