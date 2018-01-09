; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-

;; ------------------------------------------------------------------------
;; @doxymacs
(require 'doxymacs)
(add-hook 'c-mode-common-hook 'doxymacs-mode)
(setq doxymacs-doxygen-style "Qt")
(custom-set-variables
 '(user-full-name (getenv "USER_FULL_NAME"))
 '(user-mail-address (getenv "USER_MAIL_ADDRESS"))
 )
;; ------------------------------------------------------------------------
