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
(setq twittering-icon-mode nil)
;; タイムラインを5分(300秒)間隔で更新
(setq twittering-timer-interval 300) 
;; アイコン取得時の情報表示をデフォルトで抑制するか
(setq twittering-url-show-status t)  
;; 全てのアイコンを保存するか
(setq twittering-icon-storage-limit t)
;; 最初に開くタイムラインを設定する
(setq twittering-initial-timeline-spec-string
      '(":home"
	;; ":mentions"
        ;; ":favorites"
        ;; ":retweets_of_me"
	))
;; ツイート取得数
(setq twittering-number-of-tweets-on-retrieval 50)
;; 表示する書式
(setq twittering-status-format "%RT{%FACE[bold]{RT}}%i %S [%s],  %@:\n%FOLD[  ]{%T // from %f%L%r%R%QT{\n+----\n%FOLD[|]{%i %s,  %@:\n%FOLD[  ]{%T // from %f%L%r%R}}\n+----}}\n ")
;; ;; o で次のURLをブラウザでオープン
;; (add-hook 'twittering-mode-hook
;;           (lambda ()
;;             (local-set-key (kbd "o")
;;                (lambda ()
;;                  (interactive)
;;                  (twittering-goto-next-uri)
;;                  (execute-kbd-macro (kbd "C-m"))
;;                  ))))
(defun my-eww-goto-url-new-session ()
  (interactive)
  (let ((uri (get-text-property (point) 'uri)))
    (if uri
	(eww uri))))
(define-key twittering-mode-map (kbd "C-m")
  'my-eww-goto-url-new-session)
;; ------------------------------------------------------------------------
