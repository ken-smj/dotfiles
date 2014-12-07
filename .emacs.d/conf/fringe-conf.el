; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ fringe
;; バッファ中の行番号表示
(require 'linum)
(global-linum-mode t)
;; 行番号のフォーマット
(set-face-attribute 'linum nil :foreground "gray30" :height 0.8)
;;(set-face-attribute 'linum nil :height 0.8)
(setq linum-format "%5d")
;; ------------------------------------------------------------------------
