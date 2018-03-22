; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ magit
(when (eq system-type 'windows-nt)
  (custom-set-variables '(magit-git-executable "~/AppData/Local/Programs/Git/bin/git.exe")))
(require 'magit)
;; (with-eval-after-load 'info
;;   (info-initialize)
;;   (add-to-list 'Info-directory-list
;;                "~/.emacs.d/site-lisp/magit/Documentation/"))
;; ------------------------------------------------------------------------
