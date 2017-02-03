; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ org2opml,opml2org
(defun opml2org ()
  (interactive)
  (let* ((script "~/.emacs.d/libexec/scripts/opml2org.rb") ;script file
         (input-dir "~/Dropbox/Outliner/") ;input
         (output-file "~/Dropbox/Outliner/outliner.org") ;output
         (command (concat "ruby -Ku " script " " input-dir " " output-file))) 
    (shell-command command)
    (if (not (eq (get-buffer "outliner.org") nil)) ;もし、ファイルが開かれていれば
        (find-file-noselect output-file) ;ファイルを開き直すか聞く
      ())
    ))
(defun org2opml ()
  (interactive)
  (let* ((script "~/.emacs.d/libexec/scripts/org2opml.rb") ;script file
         (outliner-dir "~/Dropbox/Outliner/") ;input
         (org-file "~/Dropbox/org/tasks.org") ;output
         (command (concat "ruby -Ku " script " " org-file " " outliner-dir))) 
    (shell-command command)
    ))
;; (opml2org)				; 起動時に読込み。
;; ------------------------------------------------------------------------
