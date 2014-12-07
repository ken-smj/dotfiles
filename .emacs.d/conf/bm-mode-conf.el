; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ line highlight and jump
(require 'bm)
(setq bm-highlight-style 'bm-highlight-only-line)
(global-set-key (kbd "\C-ch") 'bm-toggle)
(global-set-key (kbd "\C-cn") 'bm-next)
(global-set-key (kbd "\C-cp") 'bm-previous)
;; ------------------------------------------------------------------------
