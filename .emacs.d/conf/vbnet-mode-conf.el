; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ vbnet mode
;; vbnet-mode 読み込み
(require 'vbnet-mode)
(set-face-foreground 'vbnet-funcall-face "medium spring green")
(set-face-background 'vbnet-funcall-face "black")
(set-face-underline-p 'vbnet-funcall-face nil)
(add-to-list 'auto-mode-alist '("\\.vbs$" . vbnet-mode)) ; .vbsに関連付け
;; auto-complete の対象にする
(add-to-list 'ac-modes 'vbnet-mode)
;; ;; summarye の一覧対象にする
;; (add-to-list 'se/mode-delimiter-alist
;; 	     '((vbnet-mode)
;; 	       (("function" "^[ 	]*.*[ 	]*\\([Ss]ub\\|[Ff]unction\\)[ 	]+\\(.*(.*)\\)")
;; 		("class" "^[ 	]*[Cc]lass\\(.*\\)")
;; 		("variable" "^[ 	]*[Dd]im[ 	]+\\(.*\\)"))
;; 	       (lambda (beg end category)
;; 		 (if (equal "function" category)
;; 		 (se/matched-pattern 2)
;; 		 (se/matched-pattern 0))
;; 		 )))
(defun my-vbnet-mode-fn ()
  "My hook for VB.NET mode"
  (interactive)
  (turn-on-font-lock)
  (turn-on-auto-revert-mode)
  (setq indent-tabs-mode nil)
  (setq vbnet-mode-indent 8)
  (setq vbnet-want-imenu t)
  ;; (require 'flymake)
  ;; (flymake-mode 1)
  )
(add-hook 'vbnet-mode-hook 'my-vbnet-mode-fn)
;; ------------------------------------------------------------------------
