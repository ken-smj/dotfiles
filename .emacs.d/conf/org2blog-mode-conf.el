; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ org2blog
;; echo "machine smj default http://yourname.wordpress.com/xmlrpc.php login username password yourpassword" > ~/.netrc 
(require 'netrc) ;; or nothing if already in the load-path
(require 'metaweblog)
(require 'org2blog-autoloads)
(let (blog)
  (progn (setq blog  (netrc-machine (netrc-parse "~/.netrc") "smj"))
	 (setq org2blog/wp-blog-alist
	       '(("smjblog"
		  :url (netrc-get blog "login")
		  :username (netrc-get blog "password")
		  :password nil)))))
;; ------------------------------------------------------------------------
