; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ ChengeLog memo
;; changelog-modeで, ChangeLogメモファイルを開く関数
;(defun memo ()
;  (interactive)
;  (add-change-log-entry
;   nil
;   (expand-file-name "~/.mylog/ChangeLog")))
;; C-x Mで, ChangeLogメモファイルを開く
;(define-key ctl-x-map "M" 'memo)

;;
;; New clmemo
;; http://at-aka.blogspot.jp/p/change-log.html
;; http://0xcc.net/unimag/1/
(require 'clmemo)
(define-key ctl-x-map "M" 'clmemo)
(setq clmemo-file-name "~/Dropbox/howm/Log")
(setq add-log-mailing-address user-full-name)
(setq add-log-full-name user-mail-address)

;;
;; blgrep (clgrep.el)
;;
(add-hook 'clmemo-mode-hook
   '(lambda ()
      (define-key clmemo-mode-map "\C-c\C-g" 'clgrep)
      (define-key clmemo-mode-map "\C-c," 'quasi-howm)))
;; ;; 補完されるタイトルのリスト
;; (setq clmemo-title-list
;;       '("memo" "todo" "bookmarks" "programing" "install" "reference" "idea" "code" "tips"))
;; 常に入れておきたいタイトルのリスト
(defvar clmemo-title-list
  '("memo" "idea" "code" "link" "todo" "tips")
  "*List of entries.
Set your favourite entry of ChangeLog MEMO.")
;; 最近の記事からヘッダを拾い出す
(when (file-exists-p clmemo-file-name)
  (with-temp-buffer
    ;; 行頭から5000文字を拾い出す
    (insert-file-contents clmemo-file-name
                          nil 0 5000)
    (let ((entry nil) (subentry nil))
      (goto-char (point-min))
      (while (re-search-forward
              "^\t\\*[ ]+\\([^:\n]+\\):" nil t)
        (setq entry
              (buffer-substring-no-properties
               (match-beginning 1)
               (match-end 1)))
        (when (string-match "(" entry)
          (setq subentry
                (substring
                 entry
                 (+ (string-match "(" entry) 1)
                 (- (length entry) 1)))
          (setq entry
                (substring entry
                           0
                           (string-match "(" entry)))
          (if (or (member subentry clmemo-title-list)
                  (not entry))
              ()
            (setq clmemo-title-list
                  (cons subentry clmemo-title-list))
            (setq subentry nil)))
        (if (or (member entry clmemo-title-list)
                (not entry))
            ()
          (setq clmemo-title-list
                (cons entry clmemo-title-list))
          (setq entry nil))))))
(defadvice clmemo-completing-read
    (after set-entry activate)
  (let ((entry ad-return-value))
    (if (or (member entry clmemo-title-list)
            (not entry))
        ()
      (if (string-match "+" entry)
          (setq entry
                (substring
                 entry
                 0
                 (string-match "+" entry))))
      (setq clmemo-title-list
            (cons entry clmemo-title-list)))))
(add-hook 'change-log-mode-hook
	  '(lambda ()
	     (define-key change-log-mode-map "\C-c\C-g" 'blg-changelog)
	     (define-key change-log-mode-map "\C-c\C-i" 'blg-changelog-item-heading)
	     (define-key change-log-mode-map "\C-c\C-d" 'blg-changelog-date)))
(add-hook 'outline-mode-hook
	  '(lambda ()
	     (define-key outline-mode-map "\C-c\C-g" 'blg-outline)
	     (define-key outline-mode-map "\C-c1" 'blg-outline-line)))
(add-hook 'outline-minor-mode-hook
	  '(lambda ()
	     (define-key outline-minor-mode-map "\C-c\C-g" 'blg-outline)
	     (define-key outline-minor-mode-map "\C-c1" 'blg-outline-line)))
(require 'blg-autoloads)
;; ------------------------------------------------------------------------
