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
;; @ custom face
(load "emacs-faces-conf")
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
;; ;; @ biff
;; (load "biff-conf")
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
;; @ moccur
(load "moccur-conf")
;; ------------------------------------------------------------------------
;; @ ibuffer
(load "ibuffer-conf")
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
;; @ expand-region
(load "expand-region-conf")
;; ------------------------------------------------------------------------
;; @ C++ style
(require 'flymake)
(load "cc-mode-style-conf")
;; ------------------------------------------------------------------------
;; @ C# mode
(load "csharp-mode-conf")
;; ------------------------------------------------------------------------
;; @ Calendar,ChengeLog memo and Howm. remark: Do NOT changed load order.
(load "changelog-memo-conf")
(load "rd-mode-conf")
;; (load "howm-mode-conf")
(load "calendar-conf")
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
(load "twittering-mode-conf")
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
;; @ org mode
(load "org-mode-conf")
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
;; @ org2blog
(load "org2blog-mode-conf")
;; ------------------------------------------------------------------------
;; @ evernote-mode
(load "evernote-mode-conf")
;; ------------------------------------------------------------------------
;; @ elfeed (rss reader)
(load "elfeed-conf")
;; ------------------------------------------------------------------------
;; @ game sudoku
(load "sudoku-conf")
;; ------------------------------------------------------------------------
;; @ boot カレンダーと予定を表示する
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (pop-to-buffer "*scratch*")
	    (delete-other-windows)
	    (calendar)))
;; ------------------------------------------------------------------------

;;;
;;; end of file
;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(vc-handled-backends nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-date ((t (:foreground "orange" :underline t))))
 '(outline-1 ((t (:foreground "orchid"))))
 '(outline-2 ((t (:foreground "deep sky blue"))))
 '(outline-3 ((t (:foreground "medium spring green"))))
 '(outline-4 ((t (:foreground "pale goldenrod"))))
 '(outline-5 ((t (:foreground "light slate blue"))))
 '(outline-6 ((t (:foreground "light goldenrod"))))
 '(outline-7 ((t (:foreground "tomato"))))
 '(outline-8 ((t (:foreground "forest green")))))
