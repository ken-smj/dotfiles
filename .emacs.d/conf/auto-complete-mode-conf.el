; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ auto-complete mode
(require 'auto-complete)
(require 'auto-complete-config)    ; 必須ではないですが一応
(defvar my-ac-sources
  '(ac-source-yasnippet
    ac-source-abbrev
    ac-source-dictionary
    ac-source-words-in-same-mode-buffers))
(global-auto-complete-mode t)
(setq ac-use-menu-map t)
;; ------------------------------------------------------------------------
