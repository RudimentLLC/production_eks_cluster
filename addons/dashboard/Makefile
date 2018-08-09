install:
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
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
	kubectl -n kube-system delete service/kubernetes-dashboard --ignore-not-found
	kubectl -n kube-system delete serviceaccount/kubernetes-dashboard --ignore-not-found
	kubectl -n kube-system delete secret/kubernetes-dashboard-certs --ignore-not-found
	kubectl -n kube-system delete role.rbac.authorization.k8s.io/kubernetes-dashboard-minimal --ignore-not-found
	kubectl -n kube-system delete rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard-minimal --ignore-not-found
	kubectl -n kube-system delete deployment.apps/kubernetes-dashboard --ignore-not-found
	kubectl -n kube-system delete serviceaccount/heapster --ignore-not-found
	kubectl -n kube-system delete deployment.extensions/heapster --ignore-not-found
	kubectl -n kube-system delete service/heapster --ignore-not-found
	kubectl -n kube-system delete deployment.extensions/monitoring-influxdb --ignore-not-found
	kubectl -n kube-system delete service/monitoring-influxdb --ignore-not-found
	kubectl -n kube-system delete clusterrolebinding.rbac.authorization.k8s.io/heapster --ignore-not-found
	kubectl -n kube-system delete serviceaccount/eks-admin --ignore-not-found

.PHONY: install uninstall delete_pods update
