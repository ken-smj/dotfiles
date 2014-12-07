; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ migemo mode
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs" "-i" "\a"))
(when (eq system-type 'windows-nt)
    (setq migemo-dictionary (expand-file-name "~/.emacs.d/libexec/w32/cmigemo-default-win64/dict/utf-8/migemo-dict")))
(when (eq system-type 'darwin)
    (setq migemo-dictionary (expand-file-name "~/.emacs.d/libexec/darwin/share/migemo/utf-8/migemo-dict")))
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-use-pattern-alist t)
(setq migemo-use-frequent-pattern-alist t)
(setq migemo-pattern-alist-length 1000)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)
;; ------------------------------------------------------------------------
