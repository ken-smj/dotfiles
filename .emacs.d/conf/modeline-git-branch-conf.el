; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ modeline-git-branch
;; http://qiita.com/acple@github/items/3709174ab24c5d82423a
(when (require 'modeline-git-branch nil t)
  ;; vcを起動しないようにする
  (custom-set-variables
   '(vc-handled-backends nil))
  ;; 不要なhookを外す
  (remove-hook 'find-file-hook 'vc-find-file-hook)
  (remove-hook 'kill-buffer-hook 'vc-kill-buffer-hook)
  (modeline-git-branch-mode 1))
;; ------------------------------------------------------------------------
