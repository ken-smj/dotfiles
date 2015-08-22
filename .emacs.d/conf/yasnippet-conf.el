; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;;; @ yasnippet
(when (require 'yasnippet nil t)
  (setq yas-snippet-dirs
	'("~/.emacs.d/lib/my-snippets"
	  "~/.emacs.d/lib/yasnippet-snippets/c++-mode"
	  "~/.emacs.d/lib/yasnippet-snippets/snippet-mode"
	  ))
  (yas-global-mode 1)
  ;; 単語展開キーバインド (ver8.0から明記しないと機能しない)
  ;; (setqだとtermなどで干渉問題ありでした)
  ;; もちろんTAB以外でもOK 例えば "C-;"とか
  (custom-set-variables '(yas-trigger-key "C-'"))

  ;; 既存スニペットを挿入する
  (define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
  ;; 新規スニペットを作成するバッファを用意する
  (define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
  ;; 既存スニペットを閲覧・編集する
  (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)
  ;; (custom-set-variables
  ;;  ;; custom-set-variables was added by Custom.
  ;;  ;; If you edit it by hand, you could mess it up, so be careful.
  ;;  ;; Your init file should contain only one such instance.
  ;;  ;; If there is more than one, they won't work right.
  ;;  '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks"))
  ;; (custom-set-faces
  ;;  ;; custom-set-faces was added by Custom.
  ;;  ;; If you edit it by hand, you could mess it up, so be careful.
  ;;  ;; Your init file should contain only one such instance.
  ;;  ;; If there is more than one, they won't work right.
  ;;  ))
  )
;; ------------------------------------------------------------------------
