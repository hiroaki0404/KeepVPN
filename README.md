# KeepVPN
![KeepVPN icon](http://www.home.group.jp/hiroaki/KeepVPN/image/KeepVPN.tiff)

## 概要
KeepVPN は、VPNの自動接続、自動再接続を行うアプリケーションです。  
VPNで繋いだ時にアクセスできるマシンと通信できるかをチェックし、通信できない場合、"ネットワーク"環境設定で作成したVPN設定を呼び出して接続します。
また、定期的にVPN接続できているかを確認し、必要に応じて再接続します。

## 必要なソフトウェア
perlのConfig-Simpleを使用しています。cpanコマンドでConfig-Simpleをインストールしてください。

## ライセンス
vpnc を除き、BSDライセンスに従うものとします。詳しくは、同梱の License.txt を参照してください。

## ダウンロード
[KeepVPN-0.1.zip](http://www.home.group.jp/hiroaki/archive/keepvpn/KeepVPN-0.1.zip)

## その他
"ネットワーク"環境設定で作成したVPN設定を呼び出すプログラム(vpnc)は、  
[仮想化雑記帳: [余談] MacOS X のVPN接続をコマンドラインから実行する](http://virtnote.blogspot.jp/2012/02/macos-x-vpn.html)
に記載されているものです。
