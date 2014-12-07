; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @HOWM
;; http://howm.sourceforge.jp/index-j.html
;;
;; quasi-howm (first edit: [2004-09-28])
;; http://at-aka.blogspot.jp/2005/06/changelog-howm-quasi-howm.html
;; 
(defvar howm-view-title-header "#")  ; this should be evaluated in advance to handle markdown
(require 'howm)
(setq howm-menu-lang 'ja)
(setq howm-directory "~/GoogleDrive/howm/")
(setq howm-file-name-format "%Y-%m/%Y%m%d-%H%M%S.howm")
(setq howm-keyword-file "~/GoogleDrive/howm/.howm-keys")
(setq howm-history-file "~/GoogleDrive/howm/.howm-history")
;; rd-mode.el が読み込まれているという前提で
;; (setq howm-view-contents-font-lock-keywords rd-font-lock-keywords)
;; (setq howm-template "= %title%cursor\n%date %file\n")
;; (setq howm-template-date-format "[%a,%b.%d,%Y %H:%M:%S %z")
;; (setq howm-template-file-format ">>> %s")
;; title でかくする。
;; (setq howm-view-title-regexp "^=\\( +\\(.*\\)\\|\\)\n") 
;; (setq howm-view-title-regexp-pos 2) 
;; (set-face-background 'howm-mode-title-face "yellow") 
;; リンクを TAB で辿る
(eval-after-load "howm-mode"
  '(progn
     (define-key howm-mode-map [tab] 'action-lock-goto-next-link)
     (define-key howm-mode-map [(meta tab)] 'action-lock-goto-previous-link)))
; file associations
(eval-after-load "markdown-mode"
  '(progn
     (defun markdown-text-mode ()
       (gfm-mode)             ; major
       (outline-minor-mode))  ; minor
     (add-to-list 'auto-mode-alist '("\\.howm$" . markdown-text-mode))
     (modify-coding-system-alist 'file "\\.howm\\'" 'utf-8-unix)))
(add-hook 'outline-minor-mode-hook
	  '(lambda ()
	     (local-set-key "\C-c\C-o" outline-mode-prefix-map)))
;; 「最近のメモ」一覧時にタイトル表示
(setq howm-list-recent-title t)
;; 全メモ一覧時にタイトル表示
(setq howm-list-all-title t)
;; メニューを 2 時間キャッシュ
(setq howm-menu-expiry-hours 2)
;; ;; howm の時は auto-fill で
;; (add-hook 'howm-mode-on-hook 'auto-fill-mode)
;; RET でファイルを開く際, 一覧バッファを消す
;; C-u RET なら残る
(setq howm-view-summary-persistent nil)
;; メニューの予定表の表示範囲
;; 10 日前から
(setq howm-menu-schedule-days-before 10)
;; 3 日後まで
(setq howm-menu-schedule-days 3)
;; (setq howm-view-grep-parse-line
;;       "^\\(\\([a-zA-Z]:/\\)?[^:]*\\.howm\\):\\([0-9]*\\):\\(.*\\)$")
;; ;; 検索しないファイルの正規表現
;; (setq
;;  howm-excluded-file-regexp
;;  "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")
;; いちいち消すのも面倒なので
;; 内容が 0 ならファイルごと削除する
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'delete-file-if-no-contents after-save-hook)))
(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (string-match "\\.howm" (buffer-file-name (current-buffer)))
         (= (point-min) (point-max)))
    (delete-file
     (buffer-file-name (current-buffer)))))
;; http://howm.sourceforge.jp/cgi-bin/hiki/hiki.cgi?SaveAndKillBuffer
;; C-cC-c で保存してバッファをキルする
(defun my-save-and-kill-buffer ()
  (interactive)
  (when (and
         (buffer-file-name)
         (string-match "\\.howm"
                       (buffer-file-name)))
    (save-buffer)
    (kill-buffer nil)))
    ;; (howm-menu-refresh)))
(eval-after-load "howm"
  '(progn
     (define-key howm-mode-map
       "\C-c\C-c" 'my-save-and-kill-buffer)))
(eval-after-load "calendar"
  '(progn
     (define-key calendar-mode-map
       "\C-m" 'my-insert-day)
     (defun my-insert-day ()
       (interactive)
       (let ((day nil)
             (calendar-date-display-form
         '("[" year "-" (format "%02d" (string-to-int month))
           "-" (format "%02d" (string-to-int day)) "]")))
         (setq day (calendar-date-string
                    (calendar-cursor-to-date t)))
         (exit-calendar)
         (insert day)))))
;; clmemoとの連携
(defun quasi-howm ()
  (interactive)
  (let ((file (format "%s%s.howm" quasi-howm-dir
        (format-time-string quasi-howm-file-name-format))))
    (unless (file-exists-p (file-name-directory file))
      (make-directory (file-name-directory file) t))
    (when (equal (buffer-file-name) (expand-file-name clmemo-file-name))
      (unless (save-excursion (backward-char 1) (looking-at "^\t"))
 (or (looking-at "^") (insert "\n"))
 (insert "\t"))
      (insert (format "(howm: %s)" (file-name-nondirectory file))))
    (find-file file))
  (insert "= ")
  (save-excursion
    (insert "\n" (format-time-string "[%Y-%m-%d %H:%M]\n"))))

(defun clmemo-tag-howm-open-file ()
  (interactive)
  (let ((file (buffer-substring-no-properties
        (progn (beginning-of-line) (search-forward "(howm: "))
        (1- (search-forward ")")))))
    (setq file (concat
  (substring file 0 4) "-"
  (substring file 4 6) "/"
  file))
    (find-file (concat quasi-howm-dir file))))

(add-hook 'clmemo-mode-hook
   '(lambda ()
      (define-key clmemo-mode-map "\C-c," 'quasi-howm)))
(setq clmemo-tag-list
      (cons '("howm" clmemo-tag-howm-open-file) clmemo-tag-list))

(setq quasi-howm-dir howm-directory)
(setq quasi-howm-file-name-format "%Y-%m/%Y%m%d-%H%M%S")
;; ------------------------------------------------------------------------
