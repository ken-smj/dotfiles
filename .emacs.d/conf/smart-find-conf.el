; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ super-smart-find
;; C-xC-fの置き換え
;; http://howm.osdn.jp/a/smart-find/
(require 'super-smart-find)
(setq smart-find-file-path
      '(
	"~"
	"~/.emacs.d"
	"~/.emacs.d/conf"
	"~/Dropbox/org"
	))
(when (string= system-name "SHIMOJOKENICHIR")
  (add-to-list 'smart-find-file-path "e:/DEVELOP")
  (add-to-list 'smart-find-file-path "e:/DEVELOP/working.r.3.x.current.svn.project/EVlib/include")
  (add-to-list 'smart-find-file-path "e:/DEVELOP/working.r.3.x.current.svn.project/EVInsite")
  (add-to-list 'smart-find-file-path "e:/DEVELOP/working.r.3.x.current.svn.project/EVInsite/EVImage")
  (add-to-list 'smart-find-file-path "e:/DEVELOP/working.r.3.x.current.svn.project/EVInsite/EVClient")
  )
(when (or (string= system-name "RED") (string= system-name "VOSTRO"))
  (add-to-list 'smart-find-file-path "c:/DEVELOP")
  (add-to-list 'smart-find-file-path "c:/DEVELOP/working.r.3.x.current.git.project/EVlib/include")
  (add-to-list 'smart-find-file-path "c:/DEVELOP/working.r.3.x.current.git.project/EVInsite")
  (add-to-list 'smart-find-file-path "c:/DEVELOP/working.r.3.x.current.git.project/EVInsite/EVImage")
  (add-to-list 'smart-find-file-path "c:/DEVELOP/working.r.3.x.current.git.project/EVInsite/EVClient")
  )
(when (string= system-name "silver.local")
  (add-to-list 'smart-find-file-path "~/src")
  (add-to-list 'smart-find-file-path "~/src/working.r.3.x.current.git.project/EVlib/include")
  (add-to-list 'smart-find-file-path "~/src/working.r.3.x.current.git.project/EVInsite")
  (add-to-list 'smart-find-file-path "~/src/working.r.3.x.current.git.project/EVInsite/EVImage")
  (add-to-list 'smart-find-file-path "~/src/working.r.3.x.current.git.project/EVInsite/EVClient")
  )
;; (define-key global-map "\C-x\C-f" 'super-smart-find-file)
(define-key global-map "\C-x4f"   'super-smart-find-file-other-window)
(define-key global-map "\C-xi"    'super-smart-find-insert-file)
(define-key global-map "\C-x\C-w" 'super-smart-find-write-file)
(define-key global-map "\C-x5f"   'super-smart-find-file-other-frame)
(define-key global-map "\C-x4l"   'super-smart-find-load-file)
(add-hook 'mime/editor-mode-hook
	  '(lambda ()
	     (define-key (current-local-map)
	       "\C-c\C-x\C-i" 'super-smart-find-mime-editor/insert-file)
	     (if (string-match "^19\\." emacs-version)
		 (define-key (current-local-map) [menu-bar mime-edit file]
		   '("Insert File" . super-smart-find-mime-editor/insert-file))
	       )) t)
(defun my-super-smart-find-file ()
  (interactive)
  (setq unread-command-events
        (append (listify-key-sequence (car super-smart-find-switch-strings))
                unread-command-events))
  (call-interactively 'super-smart-find-file))
(global-set-key "\C-x\C-f" 'my-super-smart-find-file)
;; ------------------------------------------------------------------------
