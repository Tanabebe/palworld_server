# palworld_server

Windows前提のためMacは考慮していない

## 概要

パルワールド用の専用サーバーをAzure上に構築するためのサーバースタック<br>Windows Serverで構築していたが、サイズが大きいのと値段が少し高いのでUbuntu乗り換え用に作成

## Ansible

前提として、Dockerコンテナに入ってから実行

### secretの編集

ansibleのsecretに変数増やしたいならこちらで

```sh
ansible-vault edit group_vars/secret.yml
```

### リソース作成とプロビジョニング

```sh
make tf_plan
# 問題なさそうならリソース作成
make tf_apply
# 作成が終わったらプロビジョニング用のコンテナ起動
make docker_start
# コンテナに入る
make docker_cli
# コンテナに入ったら
make palworld_provisioning
```

## サーバー構築後

ディスクのサイズダウンは出来ないので初期少なめの方が良い

`cmd_bat/example.env.bat`内の変数を設定する<br>
通知用の変数もあるので不要ならコメントアウト

VMサーバー起動：`palworld_start.bat`<br>
VMサーバー停止（割り当て解除）：`palworld_stop.bat`

## iniファイルを変更する

公開しても良いパラメーターなら`all.yml`に変数追加や、修正を行う<br>
Dockerコンテナに入り`make palworld_ini_update`

## データの移行

旧サーバーのファイルをコピーしておく<br>
一度サーバーに入ると`steamapps/common/PalServer/Pal/Saved/SaveGames/0/{HashId}/`が作成されるので、ディレクトリが確認出来たら`sudo systemctl stop palworld`で止める<br>
旧データの`steamapps/common/PalServer/Pal/Saved/SaveGames/0/{HashId}/`配下のファイルを新サーバーへコピーする<br>
コピー先：`steamapps/common/PalServer/Pal/Saved/SaveGames/0/{HashId}/`
`sudo systemctl start palworld`でサーバー起動

セーブデータが復元されていたらOKではあるが、マッピングが白紙になってしまう課題がある