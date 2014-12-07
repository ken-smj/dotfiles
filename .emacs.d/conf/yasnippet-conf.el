; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;;; @ yasnippet
(when (require 'yasnippet nil t)
  (setq yas-snippet-dirs
	'("~/.emacs.d/lib/yasnippet-snippets/c++-mode/"
	  "~/.emacs.d/lib/yasnippet-snippets/snippet-mode/"
	  ))
  (yas-global-mode 1)

  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks"))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   ))
;; ------------------------------------------------------------------------
