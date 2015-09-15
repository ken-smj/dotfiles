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
(setq org-directory "~/Dropbox/org/")
;; org-modeのデフォルトの書き込み先
(setq org-default-notes-file (concat org-directory "notes.org"))
;; org-modeのテンプレート
(setq org-capture-templates
      '(
        ("a" "Agenda" entry (file+datetree (concat org-directory "agenda.org")) "* TODO %^{Title} [/] :doing:\n SCHEDULED: %T\n - [ ] %?\n %i\n")
	("m" "Memo" entry (file+headline nil "Memos") "** %?\n   %i\n   %U\n")
	("M" "Memo(with file link)" entry (file+headline nil "Memos") "** %?\n   %i\n   %a\n   %U\n")
        ("l" "Log" entry (file+datetree (concat org-directory "journal.org") "Log") "* %?\nEntered on %U\n   %i\n  %a\n")
	("d" "with doing tag" entry (file+headline (concat org-directory "tasks.org") "Inbox") "** TODO %? :doing:\n   %i\n   %T\n")
	("o" "with obstruction tag" entry (file+headline (concat org-directory "tasks.org") "Inbox") "** TODO %? :obstruction:\n   %i\n   %T\n")
	))
;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s!)" "WAIT(w@/!)" "PENDING(p@/!)" "|" "DONE(d!)" "DELEGATED(g@/!)" "CANCELED(c@/!)" "SOMEDAY(o!)")))
;; TODO表示色
(setq org-todo-keyword-faces
      '(("TODO" . "red") ("STARTED" . "green")
	("WAIT" . "yellow") ("PENDING" . org-warning)
	("CANCELED" . (:foreground "cyan" :weight bold))))
;; TODOの進捗をすべての階層の結果で表示
(setq org-hierarchical-todo-statistics nil)
(defun org-summary-todo (n-done n-not-done)
  "すべてのサブツリーが終了するとDONE に切り替え、その他の場合は、TODO にする。"
  (let (org-log-done org-log-states) ; 記録「logging」を終了
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
;; DONEの時刻を記録
(setq org-log-done 'time)
;; org-capture-memo
(defun org-capture-memo (n)
  (interactive "p")
  (case n
    (4 (org-capture nil "M"))
    (t (org-capture nil "m"))))
;; スケジュールされてないagendaを表示する。
(setq org-agenda-custom-commands
      '(("x" "Unscheduled TODO" tags-todo "-SCHEDULED>=\"<now>\"" nil)))
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

;; Tagリスト
(setq org-tag-alist
      '(("doing" . ?d)
	("obstruction" . ?o)
	("bug" . ?b)
	("tips" . ?t)
	("remark" . ?m)
	("windows" . ?w)
	("evinsite" . ?e)
	("redmine" . ?r)
	("books" . ?k)
	))
(setq org-tag-faces
      '(("doing" :foreground "#00FF00")
	("bug" :foreground "#FF0000")
	("obstruction" :foreground "#FF0000")
	))
;; アジェンダ作成の対象
(setq org-agenda-files (list org-directory
			     (concat org-directory "current/")))
(setq org-agenda-include-diary t)
;; doing リストを表示
(defun my-sparse-doing-tree ()
  (interactive)
  (org-tags-view nil "doing"))
(global-set-key (kbd "C-c v") 'my-sparse-doing-tree)
;; 障害リストを表示
(defun my-sparse-obstruction-tree ()
  (interactive)
  (org-tags-view nil "obstruction"))
(global-set-key (kbd "C-c o") 'my-sparse-obstruction-tree)
;; リストの項目を TAB で選択
(org-defkey org-agenda-mode-map [(tab)]
	    '(lambda () (interactive)
	       (org-agenda-goto)
	       (with-current-buffer "*Org Agenda*"
		 (org-agenda-quit))))
;; doingタグを簡単に付与する
(defvar my-doing-tag "doing")
;; doingタグをトグルする
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
(define-key org-mode-map (kbd "<C-insert>") 'my-toggle-doing-tag)

;; ショートカットキー
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cm" 'org-capture-memo)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cr" 'org-capture-code-reading)
;; ------------------------------------------------------------------------
