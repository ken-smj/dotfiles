; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ adoc mode
(require 'adoc-mode)
(setq auto-mode-alist
      (append '(("\\.adoc$" . adoc-mode)
		("\\.asciidoc$" . adoc-mode))
	      auto-mode-alist))
;; ------------------------------------------------------------------------
