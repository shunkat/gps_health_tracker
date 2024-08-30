# gps_health_tracker
このアプリは実験の協力者のGPS情報とHealthConnect(iOSはHealthkit)の情報をトラッキングするためのものです。
実験の最終目標は、認知症の兆候をGPS情報とHealthkitの情報を使って検出することです。
もし実験に興味がある方がいらっしゃいましたら、ご連絡いただけると幸いです。
shunk0616@gmail.com

This app is only for tracking gps and health of the collaborator of my research project.
My research project'g goal is to detect signs of dementia by using GPS and health data.
If you want to know the details of the project, please contact me.
shunk0616@gmail.com

because I'm not good at English, the sentences below are in Japanese. sorry for the inconvenience

# 概要と設計
## クライアント(当レポジトリのアプリ)
Flutterによるシングルページアプリケーションです。
Android、iOSに対応します。

### 必須機能
- [ ] ログイン（明示的にログアウトしない限りセッションは永続）
- [ ] ユーザー登録時に、ユーザーの情報を保存する
- [ ] バックグラウンドでGPS情報と健康情報を取得し、毎週月曜の0時0分にサーバーに送信する


### 任意機能
- [ ] 一週間に一度サーバー側からの通知を受け取り、その通知に従ってアプリを開くことで、その週の認知レベルに関するレポートを確認できる。
- [ ] いますぐ検査ボタンを押すことで、長谷川式の検査メソッドに則った検査を行う

## サーバー
サーバー側は別レポジトリで管理しますが、簡単な設計だけここに記述します。


### 必須機能
- [ ] ユーザー認証機能
- [ ] ユーザーの個人情報を保存する機能（読み取り不可）
- [ ] 一週間に一度送られてくるデータを保存する機能

### 任意機能
- [ ] データを元にして認知レベルに関するレポートを作成する機能
- [ ] 長谷川式の検査メソッドに則った検査を行う機能
  - [ ] ユーザーの音声をテキストに変換する機能
  - [ ] テキストを元にして長谷川式に沿った点数計測を行う機能
  - [ ] 点数を元にして認知レベルを計算する機能
- [ ] 一定期間たったユーザーのデータをcloud storageのarchiveクラスに移動する機能

## ページ構成
### 必須
- [ ] ログインページ
- [ ] 初回登録ページ
- [ ] ホームページ
- [ ] 設定ページ

### 任意
- [ ] レポートページ
- [ ] 長谷川式検査ページ
  - [ ] チャットページ
  - [ ] 結果表示ページ

# 開発環境
- Flutter 3.19.6
- Dart 3.3.4
- Version: 1.92.2 (Universal)
- macOS Sonoma 14.1(intel)