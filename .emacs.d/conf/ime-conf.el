; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ ime

(when (eq system-type 'windows-nt)
  (global-unset-key "\M-`")		; free default IME Key
  ;; 標準IMEの設定
  (setq default-input-method "W32-IME")

  ;; IME状態のモードライン表示
  (setq-default w32-ime-mode-line-state-indicator "[--]")
  (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))

  ;; IMEの初期化
  (w32-ime-initialize)

  ;; IME OFF時の初期カーソルカラー
  (set-cursor-color "yellow")

  ;; IME ON/OFF時のカーソルカラー
  (add-hook 'input-method-activate-hook
	    (lambda() (set-cursor-color "green")))
  (add-hook 'input-method-inactivate-hook
	    (lambda() (set-cursor-color "yellow")))

  ;; バッファ切り替え時にIME状態を引き継ぐ
  (setq w32-ime-buffer-switch-p nil))
;; ------------------------------------------------------------------------
