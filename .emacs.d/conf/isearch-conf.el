; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ isearch
(defun isearch-forward-with-heading ()
  "Search the word your cursor looking at."
  (interactive)
  (command-execute 'forward-word)
  (command-execute 'backward-word)
  (command-execute 'isearch-forward))

(global-set-key "\C-s" 'isearch-forward-with-heading)
;; ------------------------------------------------------------------------
