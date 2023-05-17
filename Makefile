rancher-up:
	docker-compose  -f rancher_server/docker-compose.yml up -d

rancher-down:
	docker-compose  -f rancher_server/docker-compose.yml down

rancher-reup:
	rancher-down
	rancher-up

rancher-ip:
	docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rancher_server

kube-create:
	ansible-playbook  "kube/rancher_local_cluster_creation.yml"