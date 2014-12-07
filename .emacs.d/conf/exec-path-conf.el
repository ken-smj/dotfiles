; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ exec path
(add-to-list 'exec-path "~/.emacs.d/libexec")
(when (eq system-type 'windows-nt)
  (when (string= system-name "SHIMOJOKENICHIR")
    (add-to-list 'exec-path "~/local/msys64/usr/bin"))
  (when (string= system-name "RED")
    (add-to-list 'exec-path "~/../../local/msys64/usr/bin"))
  (add-to-list 'exec-path "~/.emacs.d/libexec/w32")
  (add-to-list 'exec-path "~/.emacs.d/libexec/w32/gzip-1.3.12-1-bin/bin/")
  (add-to-list 'exec-path "~/.emacs.d/libexec/w32/glo62Bwb/bin/")
  (add-to-list 'exec-path "~/.emacs.d/libexec/w32/w3m-0.5.3-mingw32/")
  (add-to-list 'exec-path "~/.emacs.d/libexec/w32/Aspell/bin")
  (add-to-list 'exec-path "~/.emacs.d/libexec/w32/cmigemo-default-win64"))
(when (eq system-type 'darwin)
  (add-to-list 'exec-path "/usr/local/bin")
  (add-to-list 'exec-path "~/.emacs.d/libexec/darwin/bin"))
(when (eq system-type 'gnu/linux)
  (add-to-list 'exec-path "/usr/local/bin")
  (add-to-list 'exec-path "~/.emacs.d/libexec/debian"))
;; ------------------------------------------------------------------------
