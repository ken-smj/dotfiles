; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ backup
;; 変更ファイルのバックアップ
(setq make-backup-files nil)
;; 変更ファイルの番号つきバックアップ
(setq version-control nil)
;; 編集中ファイルのバックアップ
(setq auto-save-list-file-name nil)
(setq auto-save-list-file-prefix nil)
;; 編集中ファイルのバックアップ先
(setq auto-save-file-name-transforms
      `((".*" , temporary-file-directory t)))
;; 編集中ファイルのバックアップ間隔（秒）
(setq auto-save-timeout 0.5)
;; 編集中ファイルのバックアップ間隔（打鍵）
(setq auto-save-interval 100)
;; バックアップ世代数
(setq kept-old-versions 1)
(setq kept-new-versions 2)
;; 上書き時の警告表示
;; (setq trim-versions-without-asking nil)
;; 古いバックアップファイルの削除
(setq delete-old-versions t)
;; ------------------------------------------------------------------------
