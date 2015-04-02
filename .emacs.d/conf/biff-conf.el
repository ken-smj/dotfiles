; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ biff
(require 'netrc)
(require 'biff)
(let ((blog) (parse (netrc-parse "~/common/.netrc")))
  (progn (setq blog  (netrc-machine  parse "gmw"))
	 (add-to-list 'biff-account-alist
		      (list "gmw"
			     (cons 'server (netrc-get blog "account")) (cons 'user (netrc-get blog "login")) (cons 'proto 'apop)))
	 (setq blog  (netrc-machine  parse "psp"))
	 (add-to-list 'biff-account-alist
		      (list "psp"
			    (cons 'server (netrc-get blog "account")) (cons 'user (netrc-get blog "login")) (cons 'proto 'pop)))))
(setq biff-autoraise nil)
(biff-background-all) ;(if you want to check all server)
;; ------------------------------------------------------------------------
