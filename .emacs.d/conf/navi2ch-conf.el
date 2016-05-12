; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ navi2ch
(require 'navi2ch)
(setq navi2ch-net-http-proxy "localhost:8080")
;; navi2ch proxy
(cond
 ((or (eq window-system 'w32) (eq window-system 'ns) (eq window-system 'mac))
  (add-hook 'navi2ch-before-startup-hook
            (lambda()
              (save-window-excursion
                (async-shell-command "~/.emacs.d/libexec/scripts/2chproxy.pl")
 		)
              ))
  (add-hook 'navi2ch-exit-hook
	    (lambda()
              (save-window-excursion
		(async-shell-command "~/.emacs.d/libexec/scripts/2chproxy.pl --kill")
		)
	      )))
 ((eq system-type 'gnu/linux)
  (add-hook 'navi2ch-before-startup-hook
            (lambda()
              (save-window-excursion
		(async-shell-command "~/.emacs.d/libexec/scripts/2chproxy.pl")
		)
              ))
  (add-hook 'navi2ch-exit-hook
	    (lambda()
              (save-window-excursion
		(async-shell-command "~/.emacs.d/libexec/scripts/2chproxy.pl --kill")
		)
	      )))
 )
;; ------------------------------------------------------------------------
