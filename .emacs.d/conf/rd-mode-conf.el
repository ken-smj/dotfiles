; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ RD (Ruby Document Format) Mode
(require 'rd-mode)
(require 'rd-mode-plus)
(setq auto-mode-alist (append '(("\\.rd\\'" . rd-mode))
			      auto-mode-alist))
;; Face control for Howm+rd-mode+rd-mode.el
;; http://howm.sourceforge.jp/cgi-bin/hiki/hiki.cgi?RdModePlusSample
(defface rd-heading1-face
  '((((class color) (background light))
     (:foreground "RoyalBlue" :background "black"
      :underline t :weight bold :height 1.6 :family "lucida"))
    (t
     (:foreground "RoyalBlue" :background "black"
      :underline t :weight bold :height 1.6 :family "lucida")))
  "Face for level-1 headings in howm mode")

(defface rd-heading2-face
  '((((class color) (background light))
     (:foreground "RoyalBlue" :background "black"
      :weight bold :height 1.5 :family "lucida"))
    (t
     (:foreground "RoyalBlue" :background "black"
      :weight bold :height 1.5 :family "lucida")))
  "Face for level-2 headings in howm mode")

(defface rd-heading3-face
  '((((class color) (background light))
     (:foreground "RoyalBlue"
      :underline t :weight bold :height 1.4 :family "lucida"))
    (t
     (:foreground "RoyalBlue"
      :underline t :weight bold :height 1.4 :family "lucida")))
  "Face for level-3 headings in howm mode")

(defface rd-heading4-face
  '((((class color) (background light))
     (:foreground "RoyalBlue"
      :weight bold :height 1.2 :family "lucida"))
    (t
     (:foreground "RoyalBlue"
      :weight bold :height 1.2 :family "lucida")))
  "Face for level-4 headings in howm mode")

(defface rd-heading5-face
  '((((class color) (background light))
     (:foreground "RoyalBlue"
      :weight bold :height 1.2 :family "lucida"))
    (t
     (:foreground "RoyalBlue"
      :weight bold :height 1.2 :family "lucida")))
  "Face for level-5 headings in howm mode")

(defface rd-heading6-face
  '((((class color) (background light))
     (:foreground "RoyalBlue"
      :height 1.1 :family "lucida"))
    (t
     (:foreground "RoyalBlue"
      :height 1.1 :family "lucida")))
  "Face for level-6 headings in howm mode")

;; rdtool 0.6.16 以降に含まれる rd-mode.el を使う場合は以下の 6 行を生かす。
;; 事情は良くわかりません。(^^) (2004-12-08 追記)
;;(setq rd-heading1-face 'rd-heading1-face)
;;(setq rd-heading2-face 'rd-heading2-face)
;;(setq rd-heading3-face 'rd-heading3-face)
;;(setq rd-heading4-face 'rd-heading4-face)
;;(setq rd-heading5-face 'rd-heading5-face)
;;(setq rd-heading6-face 'rd-heading6-face)

;; rdtool 0.6.16 以降に含まれる rd-mode.el を使う場合は以下は不要。
;; ただし、"+ ", "++ " の定義が抜けてしまうので、必要な人は rd-model.el の該当箇所を
;; 修正してください。(2004-12-08 追記)
;; Derived from that of rd-mode.el
(setq rd-font-lock-keywords
  (list
   '("^= .*$"
     0 'rd-heading1-face)
   '("^== .*$"
     0 'rd-heading2-face)
   '("^=== .*$"
     0 'rd-heading3-face)
   '("^==== .*$"
     0 'rd-heading4-face)
   '("^+ .*$"
     0 'rd-heading5-face)
;;   '("^++ .*$"
   '("^+\\+ .*$"
     0 'rd-heading6-face)
   '("((\\*[^*]*\\*+\\([^)*][^%]*\\*+\\)*))"    ; ((* ... *))
     0 font-lock-function-name-face)
   '("((%[^%]*%+\\([^)%][^%]*%+\\)*))"      ; ((% ... %))
     0 font-lock-function-name-face)
   '("((|[^|]*|+\\([^)|][^|]*|+\\)*))"      ; ((| ... |))
     0 font-lock-function-name-face)
   '("(('[^']*'+\\([^)'][^']*'+\\)*))"      ; ((' ... '))
     0 font-lock-function-name-face)
   '("((:[^:]*:+\\([^):][^:]*:+\\)*))"      ; ((: ... :))
     0 font-lock-function-name-face)
   '("((-[^-]*-+\\([^)-][^-]*-+\\)*))"      ; ((- ... -))
     0 font-lock-function-name-face)
   '("((<[^>]*>+\\([^)>][^>]*>+\\)*))"      ; ((< ... >))
     0 font-lock-function-name-face)
   '("(({[^}]*}+\\([^)}][^}]*}+\\)*))"      ; (({ ... }))
     0 font-lock-function-name-face)
   '("^:.*$"
     0 font-lock-reference-face)
   ))

;; ;; [ユーザ事例2] pukiwiki-mode チックな見出しにしたい
;; ;; [ユーザ事例１] の見栄えを変えて pukiwiki-mode チックにしたものです。ヘッ
;; ;; ダ行全体のバックグランドが色変わりして十分目立つのでフォントサイズは地
;; ;; の文と同じです。
;; ;;;---------------------------------------------------------
;; ;;; pukiwiki-mode like header styles
;; ;;; 2006-02-06
;; ;;;---------------------------------------------------------
;; ;;; =, ==, ===
;; (defface rd-heading1-face
;;   '((((class color) (background light))
;;      (:foreground "Black"
;;                   :background "SlateGray1"
;;                   :box (:line-width 2 :color "grey75" :style released-button)
;;                   :weight bold :height 1.4))
;;     (t
;;      (:foreground "gray85" :background "gray13" ;; "LightGray"
;;                   :box (:line-width 3 :color "blue" :style released-button)
;;                   :weight bold :height 1.4)))
;;   "Face for level-1 headings in pukiwiki mode")
;; (setq rd-heading1-face 'rd-heading1-face)

;; (defface rd-heading2-face
;;   '((((class color) (background light))
;;      (:foreground "Black"
;;                   :background "SlateGray1"
;;                   :weight bold :height 1.2))
;;     (t
;;      (:foreground "gray85"
;;                   :background "gray13"
;;                   :weight bold :height 1.2)))
;;   "Face for level-2 headings in pukiwiki mode")
;; (setq rd-heading2-face 'rd-heading2-face)

;; (defface rd-heading3-face
;;   '((((class color) (background light))
;;      (:foreground "Black"
;;                   :background "SlateGray1"
;;                   :height 1.1))
;;     (t
;;      (:foreground "gray90"              ;"LightGoldenrod"
;;                   :underline nil :weight bold :height 1.1)))
;;   "Face for level-3 headings in pukiwiki mode")
;; (setq rd-heading3-face 'rd-heading3-face)

;; ;;; ==== and longers
;; (defface rd-heading4-face
;;   '((((class color) (background light))
;;      (:foreground "Black"
;;                   :background "SlateGray1"
;;                   :height 1.1))
;;     (t
;;      (:foreground "gray90"              ;"LightGoldenrod"
;;                   :underline nil :weight bold :height 1.1)))
;;   "Face for level-3 headings in pukiwiki mode")
;; (setq rd-heading4-face 'rd-heading4-face)

;; ;;; +, ++
;; (defface rd-heading5-face
;;   '((((class color) (background light))
;;      (:foreground "RoyalBlue"
;;       :weight bold :height 1.1 :family "lucida"))
;;     (t
;;      (:foreground "RoyalBlue"
;;       :weight bold :height 1.1 :family "lucida")))
;;   "Face for level-5 headings in howm mode")
;; (setq rd-heading5-face 'rd-heading5-face)

;; (defface rd-heading6-face
;;   '((((class color) (background light))
;;      (:foreground "RoyalBlue"
;;       :height 1.1 :family "lucida"))
;;     (t
;;      (:foreground "RoyalBlue"
;;       :height 1.1 :family "lucida")))
;;   "Face for level-6 headings in howm mode")
;; (setq rd-heading6-face 'rd-heading6-face)
;; ------------------------------------------------------------------------
