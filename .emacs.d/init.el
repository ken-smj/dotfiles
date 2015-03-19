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
;; @ C++ style
(require 'flymake)
(load "cc-mode-style-conf")
;; ------------------------------------------------------------------------
;; @ C# mode
(load "csharp-mode-conf")
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

;;;
;;; end of file
;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(elfeed-feeds
   (quote
    ("http://www.geocities.jp/ktaro38/rss.xml" "http://magazine.rubyist.net/atom.xml" "http://sourceforge.net/projects/msys2/rss?path=/Base/x86_64" "http://pipes.yahoo.com/pipes/pipe.run?_id=MDQodEaT3RGT7j5gBRNMsA&_render=rss" "http://headlines.yahoo.co.jp/rss/cnippou-c_int.xml" "http://headlines.yahoo.co.jp/rss/san-dom.xml" "http://rss.dailynews.yahoo.co.jp/fc/world/rss.xml" "http://headlines.yahoo.co.jp/rss/yonh-c_int.xml" "http://www3.nhk.or.jp/rss/news/cat0.xml" "http://rss.dailynews.yahoo.co.jp/fc/local/rss.xml" "http://rss.dailynews.yahoo.co.jp/fc/economy/rss.xml" "http://rss.dailynews.yahoo.co.jp/fc/domestic/rss.xml" "http://headlines.yahoo.co.jp/rss/wsj-c_int.xml" "http://headlines.yahoo.co.jp/rss/chosun-c_int.xml" "http://headlines.yahoo.co.jp/rss/ftaiwan-c_int.xml" "http://www.nytimes.com/services/xml/rss/nyt/World.xml" "http://getnews.jp/feed" "http://rss.dailynews.yahoo.co.jp/fc/computer/rss.xml" "http://sankei.jp.msn.com/rss/news/flash.xml" "http://headlines.yahoo.co.jp/rss/san-c_int.xml" "http://feeds.reuters.com/reuters/JPTopNews" "http://itpro.nikkeibp.co.jp/rss/news.rdf" "http://headlines.yahoo.co.jp/rss/scn-c_int.xml" "http://headlines.yahoo.co.jp/rss/hankyoreh-c_int.xml" "http://www.atmarkit.co.jp/rss/rss091.xml" "http://www.lifehacker.jp/index.xml")))
 '(vc-handled-backends nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
