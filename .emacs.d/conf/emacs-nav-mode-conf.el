; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ emacs-nav
(require 'nav)
(setq nav-split-window-direction 'vertical) ;; 分割したフレームを垂直に並べる
(global-set-key "\C-x\C-d" 'nav-toggle)     ;; C-x C-d で nav をトグル
;(defun nav-mode-hl-hook ()
;  (local-set-key (kbd "<right>") 'nav-open-file-under-cursor)
;  (local-set-key (kbd "<left>")  'nav-go-up-one-dir)
;  )
;(add-hook 'nav-mode-hook 'nav-mode-hl-hook)
;(add-hook 'emacs-startup-hook
;          (lambda ()
;            (nav-toggle-hidden-files)
;            ))
;; ------------------------------------------------------------------------
