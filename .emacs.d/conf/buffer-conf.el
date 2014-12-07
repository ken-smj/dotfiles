; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ buffer
;; バッファ画面外文字の切り詰め表示
(setq truncate-lines nil)
;; ウィンドウ縦分割時のバッファ画面外文字の切り詰め表示
(setq truncate-partial-width-windows t)
;; 同一バッファ名にディレクトリ付与
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")
;; ------------------------------------------------------------------------
