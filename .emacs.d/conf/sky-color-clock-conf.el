; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ sky-color-clock
(require 'netrc)
(require 'sky-color-clock)
(sky-color-clock-initialize 35.69) ; 東京の緯度で初期化
(let ((key (netrc-machine (netrc-parse "~/Dropbox/.netrc") "owm")))
  (sky-color-clock-initialize-openweathermap-client
   (netrc-get key "account") (netrc-get key "login")))
;; デフォルトの mode-line-format の先頭に sky-color-clock を追加
(setq sky-color-clock-format "%a,%b.%d at %H:%M")
(setq sky-color-clock-enable-emoji-icon t)
(setq sky-color-clock-enable-temperature-indicator t)
(push '(:eval (sky-color-clock)) (default-value 'mode-line-format))
;; (add-to-list 'mode-line-format '(:eval (sky-color-clock)))  ;; <= うまくいかない
;; ------------------------------------------------------------------------
