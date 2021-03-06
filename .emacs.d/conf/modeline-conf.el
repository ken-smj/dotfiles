; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ modeline
;; 行番号の表示
(line-number-mode t)
;; 列番号の表示
(column-number-mode nil)
;; buffer名を非表示
;; (setq mode-line-buffer-identification nil)   ;; <= うまくいかない。
;; 時刻の表示 sky-color-clock入れたのでやめ。
;; (require 'time)
;; (setq display-time-day-and-date t)
;; (setq display-time-24hr-format t)
;; (setq display-time-string-forms
;;       '(dayname "," monthname "." day " at " 24-hours ":" minutes " "))
;; (display-time-mode t)
;; cp932エンコード時の表示を「P」とする
(coding-system-put 'cp932 :mnemonic ?P)
(coding-system-put 'cp932-dos :mnemonic ?P)
(coding-system-put 'cp932-unix :mnemonic ?P)
(coding-system-put 'cp932-mac :mnemonic ?P)
;; ------------------------------------------------------------------------
