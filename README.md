# palworld_server

Windows前提のためMacは考慮していない

## 1. 概要

パルワールド用の専用サーバーをAzure上に構築するためのサーバースタック<br>Windows Serverで構築していたが、サイズが大きいのと値段が少し高いのでUbuntu乗り換え用に作成

## 2. 実行環境の構築

- Makefileのインストール
  - [こちら](https://gnuwin32.sourceforge.net/packages/make.htm)からインストールを行い`make`コマンドが通るようにする
- Azure CLIのインストール(Terraformの実行が必要でないならスルーしてOKです)
  - [こちら](https://learn.microsoft.com/ja-jp/cli/azure/install-azure-cli)を見てセットアップ
- `cmd_bat/env.bat`の用意
  - `examplle.env.bat`をコピーしリネーム
  - 環境変数に何を設定するかは管理者へ問い合わせてください

## 3. サーバー作成と設定

```sh
# 構築されるリソースを確認
make tf_plan

# 問題なさそうならリソース作成
make tf_apply

# 作成が終わったらプロビジョニング用のコンテナ起動
make docker_start

# コンテナに入る
make docker_in

# コンテナに入ったらプロビジョニング
make palworld_provisioning
```

## 4. サーバー起動

`example.env.bat`を`env.bat`へリネームし、変数を設定する<br>
※通知用の変数もあるので不要ならコメントアウト

- `palworld_start.bat`: VMサーバー起動
- `palworld_stop.bat`: VMサーバー停止

## 5. Makefile

### 5.1. terraoformとdocker

- `tf_plan`構築されるリソースの確認する
- `tf_apply`: リソースの作成 
- `tf_destroy`: リソースの破棄
- `docker_start`: Ansible実行用のDockerコンテナ起動
- `docker_in`: Ansible実行用のDockerコンテナへ入る
- `docker_stop`: Dockerコンテナの破棄

### 5.2. Ansible

Dockerコンテナに入ってから実行

- `palworld_provisioning`: サーバーのプロビジョニング
- `palworld_update_settings_ini`: iniファイルの更新
- `palworld_save_data_backup`: セーブデーターのバックアップ取得
- `palworld_update_server_sh`: `Palworld.sh`の更新

## 6. Tips

### 6.1. データの移行

1. 旧サーバーのファイルをコピーしておく
2. リソース作成とプロビジョニングを実施
3. ssh接続でvmへ接続
   1. `steamapps/common/PalServer/Pal/Saved/SaveGames/0/{HashId}/`のディレクトリを確認
   2. `sudo systemctl stop palworld`でサーバーを止める
   3. 移行元サーバーの`steamapps/common/PalServer/Pal/Saved/SaveGames/0/{HashId}/`配下のファイルを<br>移行先サーバーの`steamapps/common/PalServer/Pal/Saved/SaveGames/0/{HashId}/`へコピーする（SFTPクライアントなどで）
4. ローカルのセーブデータを移行先へ合わせる
   1. `C:\Users\{Your UserName}\AppData\Local\Pal\Saved\{hash}\{hash}`内にあるファイルをコピー
   2. `C:\Users\{Your UserName}\AppData\Local\Pal\Saved\{hash}\{移行先サーバー側のHash}`とし、ディレクトリを作成しコピーしたファイルをコピー
   3. 
5. `sudo systemctl start palworld`でサーバー起動

ゲームを起動し、セーブデータが復元されていたら完了

### 6.2. リソースの更新

1. terraformのコードを直す
2. `make tf_plan`で実行計画を確認（しっかり確認する）
3. `make tf_apply`でリソース更新