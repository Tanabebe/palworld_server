# Windowsでmakeのインストールをしている前提
BECOME_PASS=$(shell cat $(HOME)/ansible/.become_pass)
VAULT_PASS=$(HOME)/ansible/.vault_pass

# 初回のプロビジョニング実行
.PHONY: palworld_provisioning
palworld_provisioning:
	ansible-playbook \
	-i inventory init_palworld.yml \
	--vault-password-file=$(VAULT_PASS) \
	--e "ansible_become_pass=$(BECOME_PASS)"

# iniファイルの更新
.PHONY: palworld_update_settings_ini
palworld_update_settings_ini:
	ansible-playbook \
	-i inventory update_settings.yml \
	--vault-password-file=$(VAULT_PASS) \
	--e "ansible_become_pass=$(BECOME_PASS)" \
	--e "exec_condition=update_ini_file"

# バックアップデータだけ取得したい場合
.PHONY: palworld_save_data_backup
palworld_save_data_backup:
	ansible-playbook \
	-i inventory save_data_backup.yml \
	--vault-password-file=$(VAULT_PASS) \
	--e "ansible_become_pass=$(BECOME_PASS)"

#  PalServer.shを更新した場合に流す
.PHONY: palworld_update_server_sh
palworld_update_server_sh:
	ansible-playbook \
	-i inventory update_settings.yml \
	--vault-password-file=$(VAULT_PASS) \
	--e "ansible_become_pass=$(BECOME_PASS)" \
	--e "exec_condition=update_server_sh"