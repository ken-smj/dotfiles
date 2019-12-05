; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; 起動時間計時用
(defadvice load (around require-benchmark activate)
  (let* ((before (current-time))
         (result ad-do-it)
         (after  (current-time))
         (time (+ (* (- (nth 1 after) (nth 1 before)) 1000)
                  (/ (- (nth 2 after) (nth 2 before)) 1000))))
    (when (> time 50)
      (message "%s: %d msec" (ad-get-arg 0) time))))
;; ------------------------------------------------------------------------
;; @ server start for emacs-client
(require 'server)
(when (and (>= emacs-major-version 23)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t)) ; Suppress error "directory
					; ~/.emacs.d/server is unsafe"
					; on windows.
(unless (server-running-p)
  (server-start))
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
(add-to-load-path "conf" "plugins" "elisp")
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
;; ;; @ fringe => it's too heavy.
;; (load "fringe-conf")
;; ------------------------------------------------------------------------
;; @ modeline
(load "modeline-conf")
;; ------------------------------------------------------------------------
;; @ sky-color-clock
(load "sky-color-clock-conf")
;; ------------------------------------------------------------------------
;; @ cursor
(load "cursor-conf")
;; ------------------------------------------------------------------------
;; @ backup
(load "backup-conf")
;; ------------------------------------------------------------------------
;; @ isearch
(load "isearch-conf")
;; ------------------------------------------------------------------------
;; @ super-smart-find
(load "smart-find-conf")
;; ------------------------------------------------------------------------
;; @ auto save
;; (require 'auto-save-buffers)
;; (run-with-idle-timer 0.5 t 'auto-save-buffers ""   "\\.howm$") 
;; ------------------------------------------------------------------------
;; @ scroll
(load "scroll-conf")
;; ------------------------------------------------------------------------
;; @ window resizer
(load "window-resizer-conf")
;; ------------------------------------------------------------------------
;; @ mew
(load "mew-conf")
;; ------------------------------------------------------------------------
;; ;; @ biff
;; (load "biff-conf")
;; ------------------------------------------------------------------------
;; ;; @ auto-complete mode
(load "auto-complete-mode-conf")
;; ------------------------------------------------------------------------
;; @ minbuf 履歴 と セッションの保存。
(load "minbuf-conf")
;; ------------------------------------------------------------------------
;; @ bookmarks
;; (load "bookmark+-mode-conf")
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
;; @ lua mode
(load "lua-mode-conf")
;; ------------------------------------------------------------------------
;; @ adoc mode
(load "adoc-mode-conf")
;; ------------------------------------------------------------------------
;; @ Calendar,ChengeLog memo and Howm. remark: Do NOT changed load order.
;; (load "changelog-memo-conf")
(load "rd-mode-conf")
;; (load "howm-mode-conf")
(load "calendar-conf")
;; ------------------------------------------------------------------------
;; @ Aspell
(load "ispell-conf")
;; ------------------------------------------------------------------------
;; ;; @ magit
;; (load "magit-conf")
;; ------------------------------------------------------------------------
;; @doxymacs
(load "doxymacs-conf")
;; ------------------------------------------------------------------------
;; @ server start for emacs-client
;; ------------------------------------------------------------------------
;; @ modeline-git-branch
;; (load "modeline-git-branch-conf")
;; ------------------------------------------------------------------------
;; @ yatex
;; (load "yatex-mode-conf")
;; ------------------------------------------------------------------------
;; ;; @ emacs w3m
;; (load "emacs-w3m-conf")
;; ------------------------------------------------------------------------
;; ;; @ facebook
;; (load "facebook-conf")
;; ------------------------------------------------------------------------
;; @ logview-mode
(load "logview-mode-conf")
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
;; @ vbnet mode
(load "vbnet-mode-conf")
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
;; @ eww mode
(load "eww-conf")
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
;; @ org2opml,opml2org
(load "org2opml-conf")
;; ------------------------------------------------------------------------
;; @ ox-gfm
(load "ox-gfm-conf")
;; ------------------------------------------------------------------------
;; @ ox-qmd
(load "ox-qmd-conf")
;; ------------------------------------------------------------------------
;; ;; @ evernote-mode
;; (load "evernote-mode-conf")
;; ------------------------------------------------------------------------
;; @ elfeed (rss reader)
(load "elfeed-conf")
;; ------------------------------------------------------------------------
;; @ openwith
(load "openwith-mode-conf")
;; ------------------------------------------------------------------------
;; @ game sudoku
(load "sudoku-conf")
;; ------------------------------------------------------------------------
;; ;; @ navi2ch
;; (load "navi2ch-conf")
;; ------------------------------------------------------------------------
;; @ yasnippet
(load "yasnippet-conf")
;; ------------------------------------------------------------------------
;; @ boot カレンダーと予定を表示する、MobileOrgの読込み。
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(add-hook 'emacs-startup-hook
	  (lambda ()
	    ;; (org-mobile-pull)			; 起動時に読み取り
	    (pop-to-buffer "*scratch*")
	    (delete-other-windows)
	    (calendar)))
;; ------------------------------------------------------------------------
;; @ emacs終了時のhook
(add-hook 'kill-emacs-hook
	  (lambda ()
	    ;; (org-mobile-push)
	    ;; (org2opml)
	    (bm-buffer-save-all)
	    (bm-repository-save)
	    ))
;; ------------------------------------------------------------------------
;;;
;;; end of file
;;;
