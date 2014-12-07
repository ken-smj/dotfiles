; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ cursor
;; カーソル点滅表示
(blink-cursor-mode t)
;; ;; カーソル行をハイライト
;; (require 'highlight-current-line)
;; (highlight-current-line-whole-line-on t)
;; ;; switch highlighting on
;; (highlight-current-line-on t)
;; ;; Ignore no buffer
;; (setq highlight-current-line-ignore-regexp nil) ; or set to ""
;; ;; alternate way to ignore no buffers
;; (fmakunbound 'highlight-current-line-ignore-function)
;; ;; Ignore more buffers
;; (setq highlight-current-line-ignore-regexp
;;       (concat "Dilberts-Buffer\\|"
;; 	      highlight-current-line-ignore-regexp))
;; ;; (defface my-highlite-current-line-face
;; ;;   '((t (:background "black" :underline "midnight blue")))
;; ;;   "Face used to highlight current line.")
;; ;; (setq highlight-current-line-face 'my-highlite-current-line-face)
;; (set-face-background 'highlight-current-line-face "gray10")
;; (set-face-underline-p 'highlight-current-line-face "midnight blue")
;; ;; スクロール時のカーソル位置の維持
;;    (setq scroll-preserve-screen-position nil)
;;    ;; スクロール行数（一行ごとのスクロール）
;;    (setq vertical-centering-font-regexp ".*")
;;    (setq scroll-conservatively 35)
;;    (setq scroll-margin 0)
;;    (setq scroll-step 1)
;;    ;; 画面スクロール時の重複行数
;;    (setq next-screen-context-lines 1)
;; ------------------------------------------------------------------------
