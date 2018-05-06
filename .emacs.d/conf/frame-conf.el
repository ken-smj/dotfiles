; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ frame
(require 'server)
;; フレームタイトルの設定
(setq frame-title-format "%f")
(if (server-running-p)
    (progn
      ;; windows psp
      (when (or (string= system-name "SHIMOJOKENICHIR")
		(string= system-name "GAZOU3G-PC"))
	(add-hook 'before-make-frame-hook
          #'(lambda ()
	      (add-to-list default-frame-alist '(alpha . 85))
	      (add-to-list default-frame-alist '(border-color . "gray"))
	      (add-to-list default-frame-alist '(mouse-color . "white"))
	      (add-to-list default-frame-alist '(width . 156))
	      (add-to-list default-frame-alist '(height . 58))
	      (add-to-list default-frame-alist '(top .  0))
	      (add-to-list default-frame-alist '(left . 0))
	      (add-to-list default-frame-alist '(line-spacing . 0)))))
      ;; windows vostro
      (when (string= system-name "VOSTRO")
	(add-hook 'before-make-frame-hook
          #'(lambda ()
	      (add-to-list default-frame-alist '(alpha . 85))
	      (add-to-list default-frame-alist '(border-color . "gray"))
	      (add-to-list default-frame-alist '(mouse-color . "white"))
	      (add-to-list default-frame-alist '(width . 156))	; windows vostro
	      (add-to-list default-frame-alist '(height . 60))
	      (add-to-list default-frame-alist '(top . 10))
	      (add-to-list default-frame-alist '(left . 300))
	      (add-to-list default-frame-alist '(line-spacing . 0)))))
      ;; osx
      (when (string= system-name "silver.local")
	(add-hook 'before-make-frame-hook
		  #'(lambda ()
		      (add-to-list default-frame-alist '(alpha . 85))
		      (add-to-list default-frame-alist '(border-color . "gray"))
		      (add-to-list default-frame-alist '(mouse-color . "white"))
		      (add-to-list default-frame-alist '(width . 156))	; mac mini
		      (add-to-list default-frame-alist '(height . 63))
		      (add-to-list default-frame-alist '(top . 10))
		      (add-to-list default-frame-alist '(left . 300))
		      (add-to-list default-frame-alist '(line-spacing . 0))))))
  ;; else
  ;; windows psp
  (when (or (string= system-name "SHIMOJOKENICHIR")
	    (string= system-name "GAZOU3G-PC"))
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
  ;; windows RED
  (when (string= system-name "RED")
    (setq default-frame-alist
	  (append (list '(alpha . 85)
			'(border-color . "gray")
			'(mouse-color . "white")
			'(width . 156)	; windows RED
			'(height . 60)
			'(top . 10)
			'(left . 300)
			'(line-spacing . 0))
		  default-frame-alist)))
  ;; windows vostro
  (when (string= system-name "VOSTRO")
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
		  default-frame-alist))))
;; ------------------------------------------------------------------------
