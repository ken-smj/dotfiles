; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ ibuffer
(require 'ibuffer)
;; (global-set-key (kbd "C-x B") 'ibuffer)
(setq ibuffer-default-sorting-mode 'recency)
(setq ibuffer-formats
      '((mark modified read-only " " (name 30 30)
              " " (size 6 -1) " " (mode 16 16) " " filename)
        (mark " " (name 30 -1) " " filename)))
;; (setq ibuffer-never-show-regexps '("*\\*" "messages"))
;; ------------------------------------------------------------------------
