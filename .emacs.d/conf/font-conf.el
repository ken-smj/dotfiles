; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ font
(when (eq system-type 'windows-nt)
  ;; 標準フォントの設定
  (set-face-attribute 'default nil
		      :family "MeiryoKe_Gothic"
		      :height 115)
  (set-fontset-font nil 'japanese-jisx0208
		    (font-spec :family "MeiryoKe_Gothic"))
  ;; (setq face-font-rescale-alist
  ;; 	'((".*Inconsolata*" . 1.0)
  ;; 	  (".*MeiryoKe_Gothic*" . 1.2)))
  )
(when (eq system-type 'darwin)
  ;; 標準フォントの設定
  (set-face-attribute 'default nil
		      :family "Menlo"
		      :height 140)
  (set-fontset-font nil 'japanese-jisx0208
		    (font-spec :family "Hiragino Kaku Gothic ProN"))
  (setq face-font-rescale-alist
	'((".*Menlo.*" . 1.0)
	  ("Hiragino.*" . 1.2)))
  )
;; ------------------------------------------------------------------------
