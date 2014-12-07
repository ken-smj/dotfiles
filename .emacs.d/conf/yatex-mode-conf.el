; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ yatex
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(setq YaTeX-user-completion-table "~/.yatexrc")
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;;;; YaTeX (野鳥)
;; yatex-mode を起動させる設定
;(setq auto-mode-alist 
;      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
;(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;; LaTeX コマンド、プレビューワ、プリンタなどの設定
;(setq tex-command "eplatex"
;      dvi2-command "dviout -1 -Set=!m"
;      dviprint-command-format "dvips %s | lpr"
;      YaTeX-kanji-code 1   ; (1 SJIS, 2 JIS, 3 EUC) JIS(junet-unix)だとOS依存せずにコンパイルできる
;      YaTeX-latex-message-code 'sjis  ; 改行に ^M がつかないようにする
;      section-name "documentclass"
;      makeindex-command "mendex"
;      YaTeX-use-AMS-LaTeX t   ; AMS-LaTeXを使う
;      YaTeX-use-LaTeX2e t     ; LaTeX2eを使う
;      YaTeX-use-font-lock t   ; 色付け
;      )
;; 自動改行を無効
(add-hook 'yatex-mode-hook'(lambda ()(setq auto-fill-function nil)))
;; yahtml
;;(setq auto-mode-alist
;;	(cons (cons "\\.html$" 'yahtml-mode) auto-mode-alist))
;;(autoload 'yahtml-mode "yahtml" "Yet Another HTML mode" t)
;; (setq yahtml-www-browser "netscape")
;; ; お気に入りのブラウザを書いて下さい。netscapeが便利です。
;; (setq yahtml-path-url-alist
;;       '(("/home/yuuji/public_html" . "http://www.mynet/~yuuji")
;; 	("/home/staff/yuuji/html" . "http://www.othernet/~yuuji")))
;; ; UNIXの絶対パスと対応するURLのリストを書いて下さい。
;; ------------------------------------------------------------------------
