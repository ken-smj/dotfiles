; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ moccur
(require 'color-moccur)
(require 'moccur-edit)
;; color-moccurの設定
;; ;;M-oにoccur-by-moccurを割り当て
;; (define-key global-map (kbd "M-o") 'occur-by-moccur)
;;スペース区切りでAND検索
(setq moccur-split-word t)
;;ディレクトリ検索するときの除外ファイル
(setq dmoccur-exclusion-mask
      (append '("/Win32/.+" "/x64/.+" "/bin.*/.+" "GRTAGS$" "GPATH$" "GTAGS$" "\\.xls.*$" "\\.ilk$" "\\.ncb$"
		"\\.pch$" "\\.pdb$" "\\.aps$")
	      dmoccur-exclusion-mask))
;; ;;Migemoを利用できる環境であればMigemoを使う
;; (when (and (executable-find "/usr/local/bin/cmigemo") ;;このパスも、自分の環境に合わせて変更してください
;;      (require 'migemo nil t))
;; (setq moccur-use-migemo t)))
;; ------------------------------------------------------------------------
