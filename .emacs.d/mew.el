;;;; -*- coding: iso-2022-7bit -*-
;; (require 'mew-w3m)
;; 猫アイコンセット
(setq mew-icon-directory "~/.emacs.d/plugins/mew-6.7/etc/")

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

;; ;; color
;; (setq mew-theme-file "~/.emacs.d/mew-theme.el")

;; summary mode
(setq mew-summary-form '(type (5 date) " " (14 from) " " t (80 subj) "|" (0 body)))
(add-hook 'mew-init-hook (lambda () (require 'mew-fancy-summary)))
(require 'font-lock)

;; Apple-mail
(setq mew-disable-alternative-regex-list '("Apple Mail"))
(setq mew-mime-multipart-alternative-list '("Multipart/.*" "Text/Plain" "Text/Html" ".*"))

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
(setq mew-prog-grep "mg")
(setq mew-prog-grep-opts '("-j" "jis" "-l" "-e" "-x" "&mime"))
(setq mew-use-suffix t)
(setq mew-search-method 'wds)
(with-eval-after-load "mew"
  (defun mew-search-wds (pattern path)
    (setq pattern (mew-cs-encode-string pattern default-file-name-coding-system))
    (let* ((ent (mew-search-get-ent mew-search-method))
	   (prog (mew-search-get-prog ent)))
      (mew-plet
       (mew-alet
	(call-process prog nil t nil "-e" mew-suffix "-p2" path "-s"
		      (encode-coding-string pattern 'shift_jis))))))
  (defun mew-search-virtual-with-wds (pattern flds &optional dummy)
    (let* ((path (mew-expand-folder mew-folder-local))
	   (mail-regex (regexp-quote (file-name-as-directory path)))
	   (regex (concat "^" mail-regex "\\(.*\\)/" "\\([0-9]+\\)"))
	   (file (mew-make-temp-name))
	   (prev "") (rttl 0)
	   crnt
	   (fld (car flds))
	   (folder (if (not (null fld))
		       (replace-regexp-in-string "^+" "" fld))))
      (if folder
	  (mew-search-wds pattern (concat path "/" folder))
	(mew-search-wds pattern path))
      (goto-char (point-min))
      (while (not (eobp))
	(when (looking-at regex)
	  (setq rttl (1+ rttl))
	  (setq crnt (match-string 1))
	  (delete-region (match-beginning 0) (match-beginning 2))
	  (when (not (string= crnt prev))
	    (beginning-of-line)
	    (insert "CD:" mew-folder-local crnt "\n"))
	  (setq prev crnt))
	(forward-line))
      (mew-frwlet mew-cs-text-for-read mew-cs-text-for-write
	(write-region (point-min) (point-max) file nil 'no-msg))
      (list file rttl)))
  )

(setq mew-prog-image/*-ext "display")

;; Mewでシグネチャを対話的に選択する設定
;(add-hook 'mew-draft-mode-hook
;	  (function (lambda ()
;		      (define-key mew-draft-mode-map "\C-ci" 'insert-signature-eref)))) 

;; htmlメールをewwで開く
;; http://suzuki.tdiary.net/20140813.html#c04
(when (and (fboundp 'shr-render-region)
           ;; \\[shr-render-region] requires Emacs to be compiled with libxml2.
           (fboundp 'libxml-parse-html-region))
  (setq mew-prog-text/html 'shr-render-region)) ;; 'mew-mime-text/html-w3m
;; (defadvice mew-summary-display (after mew-auto-analize-again activate)
;;   (mew-summary-analyze-again))
