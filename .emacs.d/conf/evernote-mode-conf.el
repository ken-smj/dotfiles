; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ evernote-mode
(require 'netrc)
(require 'evernote-mode)
(let (note)
  (progn (setq note (netrc-machine (netrc-parse "~/Dropbox/.netrc") "note"))
	 (setq evernote-username (netrc-get note "login")) ; optional: you can use this username as default.
	 ;; (setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8")) ; optional
	 (global-set-key "\C-cec" 'evernote-create-note)
	 (global-set-key "\C-ceo" 'evernote-open-note)
	 (global-set-key "\C-ces" 'evernote-search-notes)
	 (global-set-key "\C-ceS" 'evernote-do-saved-search)
	 (global-set-key "\C-cew" 'evernote-write-note)
	 (global-set-key "\C-cep" 'evernote-post-region)
	 (global-set-key "\C-ceb" 'evernote-browser)))
;; ------------------------------------------------------------------------
