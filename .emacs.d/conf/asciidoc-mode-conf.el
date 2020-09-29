; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ asciidoc mode
(require 'asciidoc-mode)
(setq auto-mode-alist
      (append '(("\\.adoc$" . asciidoc-mode)
		("\\.asciidoc$" . asciidoc-mode))
	      auto-mode-alist))
;; ------------------------------------------------------------------------
