; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ expand-region
(require 'expand-region)
(global-set-key (kbd "C->") 'er/expand-region)
(global-set-key (kbd "C-<") 'er/contract-region)
;; ------------------------------------------------------------------------
