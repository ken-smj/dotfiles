; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ 基本設定
(setq next-line-add-newlines nil)
(setq-default scroll-step 1)
(line-number-mode t)
(global-set-key "\C-ck" 'kill-rectangle)
(global-set-key "\C-cy" 'yank-rectangle)
(global-set-key "\C-h"  'backward-delete-char)
(global-set-key (kbd "M-w") 'kill-ring-save)
(global-set-key "\C-cd"  'calendar)
(menu-bar-mode -1)
(tool-bar-mode -1)
(set-scroll-bar-mode nil)
(global-set-key [f10] 'tmm-menubar)
;; 画像ファイルを表示
(auto-image-file-mode t)
;; for ChangeLog.
(setq user-full-name (getenv "USER_FULL_NAME"))
(setq user-mail-address (getenv "USER_MAIL_ADDRESS"))
;; for conf
(require 'generic-x)
;; ------------------------------------------------------------------------
;; @ default setting
;; ;; 起動メッセージの非表示
;; (setq inhibit-startup-message nil)
;; ;; スタートアップ時のエコー領域メッセージの非表示
;; (setq inhibit-startup-echo-area-message nil)
;; ------------------------------------------------------------------------
;; @ image-library
(when (eq system-type 'windows-nt)
  (setq image-library-alist
	'((xpm "libXpm-noX4.dll")
	  (png "libpng16-16.dll")
	  (jpeg "libjpeg-8.dll")
	  (tiff "libtiff-5.dll")
	  (gif "libgif-7.dll")
	  (svg "librsvg-2-2.dll")
	  (gdk-pixbuf "libgdk_pixbuf-2.0-0.dll")
	  (glib "libglib-2.0-0.dll")
	  (gobject "libgobject-2.0-0.dll")
	  (zlib "zlib1.dll"))))
;; ------------------------------------------------------------------------
