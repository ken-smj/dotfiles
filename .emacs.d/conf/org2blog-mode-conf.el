; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ org2blog
;; echo "machine smj account http://yourname.wordpress.com/xmlrpc.php login username password yourpassword" > ~/.netrc 
(require 'netrc) ;; or nothing if already in the load-path
(require 'metaweblog)
(require 'org2blog-autoloads)
(let ((blog (netrc-machine (netrc-parse "~/common/.netrc") "smj")))
  (setq org2blog/wp-blog-alist
	(list (list "wordpress"
	      :url (netrc-get blog "account")
	      :username (netrc-get blog "login")
	      :password nil))))
;; ------------------------------------------------------------------------
