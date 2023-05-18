# 20230518TEST

[機能要件]
* Animechan APIを利用して入力したアニメのタイトルから名言を取得する
   * https://animechan.vercel.app/guide
* 名言一覧画面を最下部までスクロールしたら自動的にページングする
* 検索結果をタップしたら詳細画面に遷移する
* 詳細画面では名言をお気に入りに追加・削除できる（SQLiteに保存・削除）
* お気に入りした名言を一覧で閲覧できる
* お気に入りの一覧画面からお気に入りを削除できる（SQLiteから削除）

[UI要件]（下記条件以外は自由）
* ２タブ（検索、お気に入り）
* 検索画面（検索タブ）
   * 検索窓
   * 検索結果の一覧（アニメ名・キャラ名・名言を表示）
* 詳細画面（検索タブ）
   * アニメ名・キャラ名・名言を表示
   * お気に入り追加・削除
* お気に入り画面（お気に入りタブ）
   * アニメ名・キャラ名・名言を表示
   * お気に入り削除


アーキテクチャ選定とかする時間がなかったので、実装を優先しています。
そのため画面遷移周りを作りきれなかったり、動画を見直して気づきましたがiOS14でのNavigationViewの高さを指定してなかったりでiOS16と差異が出ています。(この後夜間まで時間が取れないので残案件)
UIにこだわっている時間がなかったのでデザインは適当です。

ライブラリは選定に時間がなかったのでAPIKitとSqlite.swiftだけ利用しています。
MVVMでCombine
SqliteをSwiftで経験が乏しのとブランクがあるので使えるのかとライブラリの調査に時間がかかりました。

作業時間は全部で6〜７時間ぐらいです。
