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
;; (setq org-capture-templates
;;       '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
;; 	 "* TODO %?\n  %i\n  %a")
;;         ("j" "Journal" entry (file+datetree "~/org/journal.org")
;; 	 "* %?\nEntered on %U\n  %i\n  %a")))
(setq org-capture-templates
      '(
	("+" "Add Log Item" entry (clock (concat org-directory "daily-journal.org")) "** %?\n   %i\n  %A\n  Entered on %U\n")
        ;; ("a" "Agenda" entry (file+datetree (concat org-directory "agenda.org")) "* TODO %^{Title} [/] :doing:\n SCHEDULED: %T\n - [ ] %?\n %i\n")
        ;; ("a" "Agenda" entry (file+datetree (concat org-directory "agenda.org")) "* TODO %? :inbox:\n SCHEDULED: %T\n %i\n")
	("e" "Entry Log" entry (file+datetree (concat org-directory "daily-journal.org"))
	 "* %?  :%^{redmine?}:\n   %i\n  %A\n  Entered on %U\n" :clock-in t :clock-keep t)
	("i" "Interrupt Log" entry (file+datetree (concat org-directory "daily-journal.org"))
	 "* %?\n   %i\n  %A\n  Entered on %U\n" :clock-in t :clock-resume t)
	("l" "Log" entry (file+datetree (concat org-directory "daily-journal.org")) "* %?\n   %i\n  %A\n  Entered on %U\n")
	("m" "Memo" entry (file+headline nil "Memos") "** %? :inbox:\n   %i\n  Entered on %U\n")
	("M" "Memo(with file link)" entry (file+headline nil "Memos") "** %? :inbox:\n   %i\n   %A\n  Entered on %U\n")
	("o" "with obstruction tag" entry (file+headline (concat org-directory "tasks.org") "Inbox")
	 "** TODO %? :%^{redmine?}:inbox:obstruction:\n   %i\n SCHEDULED: %^{Schedule?}T\n  Entered on %U\n")
	("p" "project" entry (file+headline (concat org-directory "tasks.org") "Projects")
	 "** %? :%^{redmine?}:inbox:\n   %i\n SCHEDULED: %^{Schedule?}T\n  Entered on %U\n")
	("t" "todo task" entry (file+headline (concat org-directory "tasks.org") "Inbox")
	 "** TODO %? :inbox:\n   %i\n  DEADLINE: %^{Deadline?}T\n  Entered on %U\n")
	))
;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s!)" "WAIT(w@/!)" "PENDING(p@/!)"
		  "|" "DONE(d!)" "DELEGATED(g@/!)" "ANSWERED(a@/!)" "CANCELED(c@/!)" "SOMEDAY(o!)")))
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
;; 詳細が未決定のプロジェクト
(setq org-stuck-projects
      ;; org-stuck-projects
      ;; ("+LEVEL=2/-DONE" ("TODO" "NEXT" "NEXTACTION") nil "")
      '("+Inbox|+TODO/-DONE-DELEGATED" ("next" "TODO") nil "\\<SCHEDULED:\\>"))
;; org-capture-memo
(defun org-capture-memo (n)
  (interactive "p")
  (case n
    (4 (org-capture nil "M"))
    (t (org-capture nil "m"))))
;; org-capture-log
(defun org-capture-log ()
  (interactive)
  (org-capture nil "l"))
;; スケジュールされてないagendaを表示する。
(setq org-agenda-custom-commands
      '(("x" "Unscheduled TODO" tags-todo "-SCHEDULED>=\"<now>\"" nil)))
;; 計時設定
(setq org-clock-persist t)		; emacs外で作業前提。
(setq org-clock-idle-time 15)		; 15分以上経過で空き時間の確認。
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
      '(("#odw" . ?#)
	("obstruction" . ?o)
	("bug" . ?b)
	("tips" . ?t)
	("remark" . ?m)
	("windows" . ?w)
	("evinsite" . ?e)
	("redmine" . ?r)
	("books" . ?k)
	("next-3.4" . ?1)
	("next-3.3" . ?2)
	("mainte-3.3" . ?3)
	("mainte-3.2" . ?4)
	("mainte-3.1" . ?5)
	("obstruct-3.3" . ?6)
	("obstruct-3.2" . ?7)
	("obstruct-3.1" . ?8)
	))
(setq org-tag-faces
      '(("#[0-9]+" . (:foreground "#00FFFF"))
	("H#[0-9]+" . (:foreground "#00FFFF"))
	("#odw" . (:foreground "#00FFFF"))
	("inbox" . (:foreground "#FFFF00"))
	("doing" . (:foreground "#00F0FF"))
	("next" . (:foreground "#00FF00"))
	("log" . (:foreground "#FFFF00"))
	("bug" . (:foreground "#FF0000"))
	("obstruction" . (:foreground "#FF0000"))
	))
;; アジェンダ作成の対象
(setq org-agenda-files (list org-directory
			     (concat org-directory "current/")))
(setq org-agenda-include-diary t)
;; inbox リストを表示
(defun my-sparse-inbox-tree ()
  (interactive)
  (org-tags-view nil "inbox"))
(global-set-key (kbd "C-c <insert>") 'my-sparse-inbox-tree)
;; next リストを表示
(defun my-sparse-next-tree ()
  (interactive)
  (org-tags-view nil "next"))
(global-set-key (kbd "C-c v") 'my-sparse-next-tree)
;; リストの項目を TAB で選択
(org-defkey org-agenda-mode-map [(tab)]
	    '(lambda () (interactive)
	       (org-agenda-goto)
	       (with-current-buffer "*Org Agenda*"
		 (org-agenda-quit))))
;; inbox,nextタグを簡単に付与する
(defun my-toggle-inbox-tag ()
  (interactive)
  (my-toggle-tag "inbox"))
(defun my-toggle-next-tag ()
  (interactive)
  (my-toggle-tag "next"))
;; inboxタグをトグルする
(defun my-toggle-tag (my-toggle-tag)
  (when (eq major-mode 'org-mode)
    (save-excursion
      (save-restriction
        (unless (org-at-heading-p)
          (outline-previous-heading))
        (if (string-match (concat ":" my-toggle-tag ":") (org-get-tags-string))
            (org-toggle-tag my-toggle-tag 'off)
          (org-toggle-tag my-toggle-tag 'on))
        (org-reveal)))))
(define-key org-mode-map (kbd "<C-insert>") 'my-toggle-inbox-tag)
(define-key org-mode-map (kbd "<M-insert>") 'my-toggle-next-tag)

;; ショートカットキー
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-c`" 'org-capture-log)
(global-set-key "\C-cm" 'org-capture-memo)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cr" 'org-capture-code-reading)

;; face
(set-face-foreground 'org-date "orange")
(set-face-underline-p 'org-date t)
(set-face-foreground 'outline-1 "aquamarine")
(set-face-foreground 'outline-2 "deep sky blue")
(set-face-foreground 'outline-3 "pale green")
(set-face-foreground 'outline-4 "pale goldenrod")
(set-face-foreground 'outline-5 "light steel blue")
(set-face-foreground 'outline-6 "dodger blue")
(set-face-foreground 'outline-7 "medium turquoise")
(set-face-foreground 'outline-8 "cornflower blue")

;; (set-face-foreground 'face "color")
;; (set-face-background 'face "color")
;; (set-face-underline-p 'face t)
;; (set-face-bold-p 'face t)
;; (set-face-italic-p 'face nil)
;; ------------------------------------------------------------------------
