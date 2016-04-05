; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ 基本設定
(custom-set-faces
 '(default ((t
             (:background "black" :foreground "light gray")
             )))
 '(cursor ((((class color)
             (background dark))
            (:background "yellow"))
           (((class color)
             (background light))
            (:background "yellow"))
           (t ())
           )))
(setq next-line-add-newlines nil)
(setq-default scroll-step 1)
(line-number-mode t)
(global-set-key "\C-ck" 'kill-rectangle)
(global-set-key "\C-cy" 'yank-rectangle)
(global-set-key "\C-h"  'backward-delete-char)
(global-set-key "\C-o"  'other-window)
(global-set-key (kbd "M-w") 'kill-ring-save)
(global-set-key "\C-cd"  'calendar)
(menu-bar-mode -1)
(tool-bar-mode -1)
(set-scroll-bar-mode nil)
(global-set-key [f10] 'tmm-menubar)
;; 画像ファイルを表示
(auto-image-file-mode t)
;; for ChangeLog.
(setq add-log-full-name (getenv "USER_FULL_NAME"))
(setq add-log-mailing-address (getenv "USER_MAIL_ADDRESS"))
(setq auto-mode-alist
      (append
       '(("\\$changelog\\$\\.txt" . change-log-mode))
	 auto-mode-alist))

;; for conf
(require 'generic-x)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(vc-handled-backends nil))
(put 'downcase-region 'disabled nil)
;; ------------------------------------------------------------------------
;; @ default setting
;; ;; 起動メッセージの非表示
;; (setq inhibit-startup-message nil)
;; ;; スタートアップ時のエコー領域メッセージの非表示
;; (setq inhibit-startup-echo-area-message nil)
;; ------------------------------------------------------------------------
;; ;; @ dynamic library
;; (when (eq system-type 'windows-nt)
;;   (setq image-library-alist
;; 	'((xpm "libXpm-noX4.dll")
;; 	  (png "libpng16-16.dll")
;; 	  (jpeg "libjpeg-8.dll")
;; 	  (tiff "libtiff-5.dll")
;; 	  (gif "libgif-7.dll")
;; 	  (svg "librsvg-2-2.dll")
;; 	  (gdk-pixbuf "libgdk_pixbuf-2.0-0.dll")
;; 	  (glib "libglib-2.0-0.dll")
;; 	  (gobject "libgobject-2.0-0.dll")
;; 	  (zlib "zlib1.dll")))
;;   (add-to-list 'dynamic-library-alist
;; 	       '(libxml2 "libxml2-2.dll" "libxml2.dll")))
;; ------------------------------------------------------------------------
;; @ windows for 32bit or 64bit
;; http://d.hatena.ne.jp/pogin/20120227/1330342298
(defvar run-windows
  (or (equal system-type 'windows-nt)
      (equal system-type 'ms-dos)))
(if run-windows
    (if (file-exists-p "C:/Program Files (x86)")
        (defvar run-windows-x64 t)
      (defvar run-windows-x64 nil)))
;; ------------------------------------------------------------------------
