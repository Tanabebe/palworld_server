# Windowsでmakeのインストールをしている前提
BECOME_PASS=$(shell cat $(HOME)/ansible/.become_pass)
VAULT_PASS=$(HOME)/ansible/.vault_pass

.PHONY: palworld_provisioning
palworld_provisioning:
	ansible-playbook \
	-i inventory init_palworld.yml \
	--vault-password-file=$(VAULT_PASS) \
	--e "ansible_become_pass=$(BECOME_PASS)"

# 挙動が怪しい感じもあったので、一応セーブデータのバックアップを取得しておいた方がよさげ
.PHONY: palworld_ini_update
palworld_ini_update:
	ansible-playbook \
	-i inventory ini_update_palworld.yml \
	--vault-password-file=$(VAULT_PASS) \
	--e "ansible_become_pass=$(BECOME_PASS)"