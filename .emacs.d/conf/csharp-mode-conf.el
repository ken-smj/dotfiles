; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ C# mode
(require 'csharp-mode)
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))
(defun my-csharp-mode-hook ()
  ;; enable the stuff you want for C# here
  (electric-pair-mode 1))
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)
;; ------------------------------------------------------------------------
