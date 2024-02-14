# Windowsでmakeのインストールをしている前提
.PHONY: tf_plan
tf_plan:
	cd terraform && \
	terraform fmt && \
	terraform plan

.PHONY: tf_apply
tf_apply:
	cd terraform && \
	terraform fmt && \
	terraform apply -var-file=secret.tfvars

.PHONY: tf_destroy
tf_destroy:
	cd terraform && \
	terraform destroy

.PHONY: docker_start
docker_start:
	cd ansible/docker && \
	docker compose up -d

.PHONY: docker_in
docker_in:
	docker exec -it ansible_palworld bash

.PHONY: docker_stop
docker_stop:
	cd ansible/docker && \
	docker compose down

