;;;; -*- coding: iso-2022-7bit -*-

;; 猫アイコンセット
(setq mew-icon-directory "~/.emacs.d/plugins/mew/etc/")

(setq mew-ask-subject nil) 
(setq mew-pop-size 0)			; Un-limit the receiving POP mail size
;(setq mew-pop-size 55296)

(setq mew-use-unread-mark t)
(setq mew-delete-unread-mark-by-mark nil)
(setq mew-use-node-folder nil)
(setq mew-use-cached-passwd t)		; If you want to cache password, activate following line
(setq mew-use-pgp-cached-passphrase t)  ; PGP/GPG's passphrase
;; PGP
;;
;; GnuPG
(setq mew-prog-gpg "gpg")
(setq mew-prog-pgp mew-prog-gpg)
					; End of additional part
					;

(setq mew-addrbook-for-cite-label 'nickname)
(setq mew-addrbook-for-cite-prefix 'nickname)
(setq mew-signature-insert-last nil)
;(setq mew-opt-highlight-header nil)
(setq mew-use-highlight-header nil)

;; summary mode
(setq mew-summary-form '(type (5 date) " " (14 from) " " t (80 subj) "|" (0 body)))

;; フォルダの自動推測ルール
(defvar mew-refile-guess-control
  '(mew-refile-guess-by-alist
    mew-refile-ctrl-throw
;    mew-refile-guess-by-newsgroups
    mew-refile-guess-by-folder
    mew-refile-ctrl-throw
    mew-refile-guess-by-thread
    mew-refile-ctrl-throw
    mew-refile-guess-by-from
    mew-refile-ctrl-throw
    mew-refile-guess-by-from-folder
    mew-refile-ctrl-throw
    mew-refile-ctrl-auto-boundary      ; 自動推測ここまで
    mew-refile-guess-by-default))
(setq mew-refile-ctrl-multi nil)       ; 複数を許さない
(setq mew-lisp-max-length 3000)        ; 自動推測数
(setq mew-use-node-folder t)         ; 末端のフォルダだけ選ぶ


(setq mew-use-biff t)
(setq mew-use-biff-bell t)

;; 検索設定
(setq mew-prog-vgrep "mg")
(setq mew-prog-vgrep-opts '("-j" "jis" "-l" "-e" "-x" "&mime"))

(setq mew-prog-image/*-ext "display")

;; Mewでシグネチャを対話的に選択する設定
;(add-hook 'mew-draft-mode-hook
;	  (function (lambda ()
;		      (define-key mew-draft-mode-map "\C-ci" 'insert-signature-eref)))) 

