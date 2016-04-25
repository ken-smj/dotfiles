; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ twitter
(require 'twittering-mode)
;; 証明書を検証しない
(setq twittering-allow-insecure-server-cert nil)
;; 認証済みaccess tokenをGnuPGで暗号化して保存する
(setq twittering-use-master-password t)
(setq twittering-use-ssl t)

;; アイコン表示
(setq twittering-icon-mode t)

;; タイムラインを5分(300秒)間隔で更新
(setq twittering-timer-interval 300) 

;; ;; アイコン取得時の情報表示をデフォルトで抑制するか
;; (setq twittering-url-show-status t)  

;; ;; 全てのアイコンを保存するか
;; (setq twittering-icon-storage-limit t)

;; ;; 最初に開くタイムラインを設定する
;; (setq twittering-initial-timeline-spec-string
;;       '(":replies"
;;         ":favorites"
;;         ":retweets_of_me"
;;         ":home"
;; ))
;; ;; 短縮URLにbit.lyを使う
;; (setq twittering-tinyurl-service 'bit.ly)
;; (setq twittering-bitly-login "hogehoge")
;; (setq twittering-bitly-api-key "hoge_key")
;; ------------------------------------------------------------------------
