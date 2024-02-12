# palworld_server

Windows前提のためMacは考慮していない

## 概要

パルワールド用の専用サーバーをAzure上に構築するためのサーバースタック<br>Windows Serverで構築していたが、サイズが大きいのと値段が少し高いのでUbuntu乗り換え用に作成

## Ansible

前提として、Dockerコンテナに入ってから実行

### secretの編集

```bash
ansible-vault create secret.yml`
```

### playbook実行例

```bash
ansible-playbook -i inventory task/test.yml
```