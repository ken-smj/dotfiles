; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ Aspell
(setq-default ispell-program-name "aspell")
(with-eval-after-load "ispell"
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
;; ------------------------------------------------------------------------
