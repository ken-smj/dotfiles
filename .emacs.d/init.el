; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ load path
(when (< emacs-major-version 23)
  (defver user-emacs-directory "~/.emacs.d"))
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
(add-to-load-path "conf" "elisp" "plugins")
;; ------------------------------------------------------------------------
;; ;; $ auto-async-byte-compile
;; (load "auto-async-byte-compile")
;; ------------------------------------------------------------------------
;; @ exec path
(load "exec-path-conf")
;; ------------------------------------------------------------------------
;; @ shell
(load "shell-conf")
;; ------------------------------------------------------------------------
;; @ coding system
(load "coding-system")
;; ------------------------------------------------------------------------
;; @ ime
(load "ime-conf")
;; ------------------------------------------------------------------------
;; @ 基本設定
(load "emacs-base-conf")
;; ------------------------------------------------------------------------
;; @ font
(load "font-conf")
;; ------------------------------------------------------------------------
;; @ frame
(load "frame-conf")
;; ------------------------------------------------------------------------
;; @ buffer
(load "buffer-conf")
;; ------------------------------------------------------------------------
;; @ fringe
(load "fringe-conf")
;; ------------------------------------------------------------------------
;; @ modeline
(load "modeline-conf")
;; ------------------------------------------------------------------------
;; @ cursor
(load "cursor-conf")
;; ------------------------------------------------------------------------
;; @ backup
(load "backup-conf")
;; ------------------------------------------------------------------------
;; @ auto save
;; (require 'auto-save-buffers)
;; (run-with-idle-timer 0.5 t 'auto-save-buffers ""   "\\.howm$") 
;; ------------------------------------------------------------------------
;; @ scroll
(load "scroll-conf")
;; ------------------------------------------------------------------------
;; @ mew
(load "mew-conf")
;; ------------------------------------------------------------------------
;; @ auto-complete mode
(require 'auto-complete)
(require 'auto-complete-config)    ; 必須ではないですが一応
(global-auto-complete-mode t)
;; ------------------------------------------------------------------------
;; @ minbuf 履歴 と セッションの保存。
(load "minbuf-conf")
;; ------------------------------------------------------------------------
;; @ bookmarks
(load "bookmark+-mode-conf")
;; ------------------------------------------------------------------------
;; @ line highlight and jump
(load "bm-mode-conf")
;; ------------------------------------------------------------------------
;; ;; @ ack-mode
;; (require 'ack)
;; ------------------------------------------------------------------------
;; @ wgrep-ag
(load "wgrep-conf")
;; ------------------------------------------------------------------------
;; @ migemo
(load "migemo-conf")
;; ------------------------------------------------------------------------
;; @ tabbar
;; (load "tabbar-mode-conf")
;; ------------------------------------------------------------------------
;; @ gtags
(load "gtags-mode-conf")
;; ------------------------------------------------------------------------
;; @ emacs-nav
(load "emacs-nav-mode-conf")
;; ------------------------------------------------------------------------
;; @ C++ style
(load "cc-mode-style-conf")
;; ------------------------------------------------------------------------
;; @ Calender,ChengeLog memo and Howm. remark: Do NOT changed load order.
(load "changelog-memo-conf")
(load "rd-mode-conf")
(load "howm-mode-conf")
(load "calender-conf")
;; ------------------------------------------------------------------------
;; @ Aspell
(load "ispell-conf")
;; ------------------------------------------------------------------------
;; @ modeline-git-branch
(load "modeline-git-branch-conf")
;; ------------------------------------------------------------------------
;; @ yatex
(load "yatex-mode-conf")
;; ------------------------------------------------------------------------
;; ;; @ emacs w3m
;; (load "emacs-w3m-conf")
;; ------------------------------------------------------------------------
;; @ twitter
(require 'twittering-mode)
;; ------------------------------------------------------------------------
;; @ css-mode
(load "css-mode-conf")
;; ------------------------------------------------------------------------
;; @ php-mode
(load "php-mode-conf")
;; ------------------------------------------------------------------------
;; @ sql-mode
(load "sql-mode-conf")
;; ------------------------------------------------------------------------
;; @ yasnippet
(load "yasnippet-conf")
;; ------------------------------------------------------------------------
;; @ byte-compile
(defun byte-compile-this-file ()
  "Compile current-buffer-file of Lisp into a file of byte code."
  (interactive)
  (byte-compile-file buffer-file-name t))
;; ------------------------------------------------------------------------
;; @hideshow
(load "hs-mode-conf")
;; ------------------------------------------------------------------------
;; @ growl
(autoload 'growl "growl" nil t)
;; ------------------------------------------------------------------------
;; @ markdown mode
(load "markdown-mode-conf")
(setq auto-mode-alist (cons '("\\.md" . gfm-mode) auto-mode-alist))
;; ------------------------------------------------------------------------
;; @ textile mode
(require 'textile-mode)
(setq auto-mode-alist (cons '("\\.textile" . textile-mode) auto-mode-alist))
;; ------------------------------------------------------------------------
;; @ web-mode
(load "web-mode-conf")
;; ------------------------------------------------------------------------

;;;
;;; end of file
;;;
