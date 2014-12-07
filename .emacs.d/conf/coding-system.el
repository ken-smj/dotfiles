; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ coding system

;; 日本語入力のための設定
(when (eq system-type 'windows-nt)
  (set-keyboard-coding-system 'cp932)
  (prefer-coding-system 'cp932-dos)
  (set-file-name-coding-system 'cp932)
  (setq default-process-coding-system '(cp932 . cp932)))
(when (eq system-type 'darwin)
  (set-language-environment 'Japanese)
  (prefer-coding-system 'utf-8)
  ;; swap meta-key bitween command and option key.
  (setq ns-command-modifier (quote meta))
  (setq ns-alternate-modifier (quote super)))
;; ------------------------------------------------------------------------
