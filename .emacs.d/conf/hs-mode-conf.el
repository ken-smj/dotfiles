; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @hideshow
(when (require 'hideshow)
  ;; C coding style
  (add-hook 'c-mode-hook
	    '(lambda ()
	       (hs-minor-mode 1)))
  ;; C++ coding style
  (add-hook 'c++-mode-hook
	    '(lambda ()
	       (hs-minor-mode 1)))
  ;; Scheme coding style
  (add-hook 'scheme-mode-hook
	    '(lambda ()
	       (hs-minor-mode 1)))
  ;; Elisp coding style
  (add-hook 'emacs-lisp-mode-hook
	    '(lambda ()
	       (hs-minor-mode 1)))
  ;; Lisp coding style
  (add-hook 'lisp-mode-hook
	    '(lambda ()
	       (hs-minor-mode 1)))
  ;; Python coding style
  (add-hook 'python-mode-hook
	    '(lambda ()
	       (hs-minor-mode 1)))
  (define-key hs-minor-mode-map (kbd "\C-ca") 'hs-hide-all)
  (define-key hs-minor-mode-map (kbd "\C-cv") 'hs-show-all)
  (define-key hs-minor-mode-map (kbd "\C-ct") 'hs-toggle-hiding))
;; ------------------------------------------------------------------------
