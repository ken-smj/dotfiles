; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ org2blog
;; echo "machine smj account http://yourname.wordpress.com/xmlrpc.php login username password yourpassword" > ~/.netrc 
(require 'netrc) ;; or nothing if already in the load-path
(require 'metaweblog)
(require 'org2blog-autoloads)
(let ((blog (netrc-machine (netrc-parse "~/Dropbox/.netrc") "smj")))
  (setq org2blog/wp-blog-alist
	(list (list "smj"
	      :url (netrc-get blog "account")
	      :username (netrc-get blog "login")
	      :password nil))))
(let ((blog (netrc-machine (netrc-parse "~/Dropbox/.netrc") "gmworks")))
  (add-to-list 'org2blog/wp-blog-alist
	(list (list "gmworks"
	      :url (netrc-get blog "account")
	      :username (netrc-get blog "login")
	      :password nil))))
;; (setq org2blog/wp-buffer-template
;;       "-----------------------
;; #+TITLE: %s
;; #+DATE: %s
;; -----------------------\n")
;; (defun my-format-function (format-string)
;;   (format format-string
;;           org2blog/wp-default-title
;;           (format-time-string "%d-%m-%Y" (current-time)))))
;; (setq org2blog/wp-buffer-format-function 'my-format-function)
;; ------------------------------------------------------------------------
