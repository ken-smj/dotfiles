; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ exec path
;; より下に記述した物が PATH の先頭に追加されます
(require 'cl)
(setenv "PATH" "")
(let ((my-exec-list) (dir))
  (progn
    (when (eq system-type 'windows-nt)
      (setq my-exec-list
	    (list
	     (expand-file-name "~/local/msys64/mingw64/bin")
	     (expand-file-name "~/local/msys64/usr/bin")
	     (expand-file-name "~/.emacs.d/plugins/mew-6.6/bin")
	     (expand-file-name "~/.emacs.d/libexec/w32")
	     (expand-file-name "~/.emacs.d/libexec/w32/gzip-1.3.12-1-bin/bin/")
	     (expand-file-name "~/.emacs.d/libexec/w32/glo62Bwb/bin/")
	     (expand-file-name "~/.emacs.d/libexec/w32/w3m-0.5.3-mingw32/")
	     (expand-file-name "~/.emacs.d/libexec/w32/Aspell/bin")
	     (expand-file-name "~/.emacs.d/libexec/w32/cmigemo-default-win64"))))
    (when (eq system-type 'darwin)
      (setq my-exec-list
	    (list
	     "/usr/local/bin"
	     (expand-file-name "~/.emacs.d/libexec/darwin/bin"))))
    (when (eq system-type 'gnu/linux)
      (setq my-exec-list
	    (list
	     "/usr/local/bin"
	     (expand-file-name "~/.emacs.d/libexec/debian/bin"))))
    (dolist (dir my-exec-list)
      ;; PATH と exec-path に同じ物を追加します
      (when (and dir (file-exists-p dir) (not (member dir exec-path)))
	(setq exec-path (append (list dir) exec-path))
	(setenv "PATH" (concat
			(if (string= (substring dir 0 3) "c:/")
			    (setf (substring dir 0 3) "/c/")
			  dir)
			":" (getenv "PATH")))))))
;; ------------------------------------------------------------------------
