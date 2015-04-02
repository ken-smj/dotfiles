; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; $ auto-async-byte-compile
(define-minor-mode auto-async-byte-compile-mode
"With no argument, toggles the mode.
With a numeric argument, turn mode on iff ARG is positive."
  nil "" nil
  (if auto-async-byte-compile-mode
      (add-hook 'after-save-hook 'auto-async-byte-compile nil 'local)
    (remove-hook 'after-save-hook 'auto-async-byte-compile 'local)))

(defun auto-async-byte-compile ()
  (interactive)
  (and buffer-file-name
       (string-match "\\.el$" buffer-file-name)
       (executable-interpret (format "byte-compile.rb %s" buffer-file-name))))
(add-hook 'emacs-lisp-mode-hook 'auto-async-byte-compile)
;; ------------------------------------------------------------------------
