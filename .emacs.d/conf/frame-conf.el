; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ frame
;; フレームタイトルの設定
(setq frame-title-format "%f")
;; windows psp
(when (string= (upcase system-name) "GAZOU3G-PC")
  (setq default-frame-alist
	(append (list '(alpha . 85)
		      '(border-color . "gray")
		      '(mouse-color . "white")
		      '(width . 156)
		      '(height . 58)
		      '(top .  0)
		      '(left . 0)
		      '(line-spacing . 0))
		default-frame-alist)))
;; windows vostro
(when (or (string= (upcase system-name) "PN001380")
	  (string= (upcase system-name) "VOSTRO"))
  (setq default-frame-alist
	(append (list '(alpha . 85)
		      '(border-color . "gray")
		      '(mouse-color . "white")
		      '(width . 156)	; windows vostro
		      '(height . 60)
		      '(top . 10)
		      '(left . 300)
		      '(line-spacing . 0))
		default-frame-alist)))
;; osx
(when (string= system-name "silver.local")
  (setq default-frame-alist
	(append (list '(alpha . 85)
		      '(border-color . "gray")
		      '(mouse-color . "white")
		      '(width . 156)	; mac mini
		      '(height . 63)
		      '(top . 10)
		      '(left . 300)
		      '(line-spacing . 0))
		default-frame-alist)))
;; ------------------------------------------------------------------------
