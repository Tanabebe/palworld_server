# palworld_server

Windows前提のためMacは考慮していない

## 概要

パルワールド用の専用サーバーをAzure上に構築するためのサーバースタック<br>Windows Serverで構築していたが、サイズが大きいのと値段が少し高いのでUbuntu乗り換え用に作成

## Ansible

前提としてDockerコンテナに入ってから実行

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
make docker_in
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

- 旧サーバーのファイルをコピーしておく
- リソース作成とプロビジョニングを実施
- ssh接続でvmへ接続
- `steamapps/common/PalServer/Pal/Saved/SaveGames/0/{HashId}/`のディレクトリが確認出来たら
`sudo systemctl stop palworld`でサーバーを止める
- 旧データの`steamapps/common/PalServer/Pal/Saved/SaveGames/0/{HashId}/`配下のファイルを新サーバーの`steamapps/common/PalServer/Pal/Saved/SaveGames/0/{HashId}/`へコピーする（SFTPクライアントなどで）
- ローカルデータをサーバー側へ紐付ける
  - `C:\Users\{Your UserName}\AppData\Local\Pal\Saved\{hash}\{hash}`にサーバーと紐づいたローカルセーブデータがある
  - `C:\Users\{Your UserName}\AppData\Local\Pal\Saved\{hash}\{ここを新しいサーバー側のHashに合わせる}`の中へ上記のデータをコピーする
- `sudo systemctl start palworld`でサーバー起動

セーブデータが復元されていたらOK