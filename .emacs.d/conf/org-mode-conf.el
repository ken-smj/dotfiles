; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ org mode
(require 'org-install)
;; 見出しの余分な*を消す
(setq org-hide-leading-stars t)
;; 画面端で改行する
(setq org-startup-truncated nil)
;; 見出しを畳まない
(setq org-startup-folded nil)
;; returnでリンクを飛ぶ
(setq org-return-follows-link t)
;; org-modeのルートディレクトリ
(setq org-directory "~/common/org/")
;; org-modeのデフォルトの書き込み先
(setq org-default-notes-file (concat org-directory "notes.org"))
;; org-modeのテンプレート
(setq org-capture-templates
      '(
	("m" "Memo" entry (file+headline nil "Memos") "** %?\n   %T")
	("M" "Memo(with file link)" entry (file+headline nil "Memos") "** %?\n   %a\n   %T")
	("t" "Todo" entry (file+headline nil "Inbox") "**TODO  %?\n   %i\n   %a\n   %t")
	("b" "Bug" entry (file+headline nil "Inbox") "** TODO %?   :bug:\n   %i\n   %a\n   %t")
	("l" "Log" entry (file+headline nil "Log") "** %? :log:\n   %i\n   %a\n   %t")
	))
;; agendaを使う
;; (setq org-agenda-files (list org-directory))

;; org-capture-memo
(defun org-capture-memo (n)
  (interactive "p")
  (case n
    (4 (org-capture nil "M"))
    (t (org-capture nil "m"))))

;; code-reading
(defvar org-code-reading-software-name nil)
;; ~/memo/code-reading.org に記録する
(defvar org-code-reading-file "code-reading.org")
(defun org-code-reading-read-software-name ()
  (set (make-local-variable 'org-code-reading-software-name)
       (read-string "Code Reading Software: "
                    (or org-code-reading-software-name
                        (file-name-nondirectory
                         (buffer-file-name))))))
(defun org-code-reading-get-prefix (lang)
  (let ((sname (org-code-reading-read-software-name))
        (fname (file-name-nondirectory
		(buffer-file-name))))
    (concat "[" lang "]"
	    "[" sname "]"
	    (if (not (string= sname fname)) (concat "[" fname "]")))))
(defun org-capture-code-reading ()
  (interactive)
  (let* ((prefix (org-code-reading-get-prefix (substring (symbol-name major-mode) 0 -5)))
         (org-capture-templates
          '(("c" "Code Reading" entry (file+headline (concat org-directory org-code-reading-file) "Code Readings")
	     "** %(identity prefix) %?\n   %a\n   %T")
            )))
    (org-capture nil "c")))

;; Doingリスト
(setq org-tag-faces
      '(("Doing" :foreground "#FF0000")))
;; アジェンダ作成の対象
(setq org-agenda-files (list org-directory))
(setq org-agenda-include-diary t)
;; Doing リストを表示
(defun my-sparse-doing-tree ()
  (interactive)
  (org-tags-view nil "Doing"))
(define-key org-mode-map (kbd "C-c d") 'my-sparse-doing-tree)
;; リストの項目を TAB で選択
(org-defkey org-agenda-mode-map [(tab)]
	    '(lambda () (interactive)
	       (org-agenda-goto)
	       (with-current-buffer "*Org Agenda*"
		 (org-agenda-quit))))
;; Doingタグ付きの入力用テンプレート
(add-to-list 'org-capture-templates
	     '("d" "Doingタグ付きのタスクをInboxに投げる" entry
	       (file+headline nil "Inbox")
	       "** TODO %? :Doing:\n"))
;; Doingタグを簡単に付与する
(defvar my-doing-tag "Doing")
;; Doingタグをトグルする
(defun my-toggle-doing-tag ()
  (interactive)
  (when (eq major-mode 'org-mode)
    (save-excursion
      (save-restriction
        (unless (org-at-heading-p)
          (outline-previous-heading))
        (if (string-match (concat ":" my-doing-tag ":") (org-get-tags-string))
            (org-toggle-tag my-doing-tag 'off)
          (org-toggle-tag my-doing-tag 'on))
        (org-reveal)))))
(global-set-key (kbd "<insert>") 'my-toggle-doing-tag)

;; ショートカットキー
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cm" 'org-capture-memo)
(global-set-key "\C-co" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cr" 'org-capture-code-reading)
;; ------------------------------------------------------------------------
