; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-

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
;; agendaのスタートを日曜日にする。
(setq org-agenda-start-on-weekday 0)
;; captureテンプレート
(setq org-capture-templates
      '(
	("+" "Add Log Item" entry (clock (concat org-directory "daily-journal.org")) "** %?\n   %i\n  %A\n  Entered on %U\n")
        ("a" "Agenda" entry (file+weektree+prompt (concat org-directory "daily-journal.org")) "* TODO %?\n  SCHEDULED: %T\n %i\n")
	("e" "Entry Log" entry (file+weektree (concat org-directory "daily-journal.org"))
	 "* %?  :%^{redmine?}:\n   %i\n  Entered on %U\n" :clock-in t :clock-keep t)
	("i" "Interrupt Log" entry (file+weektree (concat org-directory "daily-journal.org"))
	 "* %? :interrupt:\n   %i\n  Entered on %U\n" :clock-in t :clock-resume t)
	("l" "Log" entry (file+weektree (concat org-directory "daily-journal.org")) "* %?\n   %i\n  Entered on %U\n")
	("m" "Memo" entry (file+headline nil "Memos") "** %?\n   %i\n  Entered on %U\n")
	("M" "Memo(with file link)" entry (file+headline nil "Memos") "** %?\n   %i\n   %A\n  Entered on %U\n")
	("o" "with obstruction tag" entry (file+headline (concat org-directory "daily-journal.org") "Inbox")
	 "** TODO %? :%^{redmine?}:obstruction:\n SCHEDULED: %^{Schedule?}T\n   %i\n  Entered on %U\n")
	("p" "project" entry (file+headline (concat org-directory "daily-journal.org") "Projects")
	 "** %? :%^{redmine?}:\n SCHEDULED: %^{Schedule?}T\n   %i\n  Entered on %U\n")
	("r" "Rest Log Item" entry (clock (concat org-directory "daily-journal.org")) "** %? :rest:\n  Entered on %U\n" :clock-in t :clock-resume t)
	("t" "todo task" entry (file+headline (concat org-directory "daily-journal.org") "Inbox")
	 "** TODO %? %(format-time-string \":%%%Y%m%d%H%M:\")\n  DEADLINE: %^{Deadline?}T\n   %i\n  Entered on %U\n")
	("v" "private task" entry (file+headline (concat org-directory "daily-journal.org") "Private") "** TODO %?\n   %i\n  Entered on %U\n")
	;; org-captureで予定を格納する。
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

;; agenda表示のカスタマイズ。
(setq org-agenda-custom-commands
      '(("c" "Current Week Action List" tags-todo "WhenDo=\"this-week\"" ((org-agenda-prefix-format " %6e ")))
	("n" "Next Week Action List" tags-todo "WhenDo=\"next-week\"" ((org-agenda-prefix-format " %6e ")))
	("x" "Unscheduled TODO" tags-todo "WhenDo=\"\"" ((org-agenda-prefix-format " %6e "))))) ; スケジュールされてないagendaを表示する。

;; 計時設定
(setq org-clock-persist t)		; emacs外で作業前提。
(setq org-clock-idle-time 15)		; 15分以上経過で空き時間の確認。
;; クロックテーブルのデフォルト値
;; (setq org-clocktable-defaults '(:maxlevel 4 :scope subtree :tags . "#odw"))
;; clock table
(setq org-time-clocksum-format
      '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))

;; 良く使用するプロパティの追加
(setq org-global-properties
      '(("WhenDo_ALL" . "this-week next-week a-couple-weeks this-month next-month someday")
	("WhenDo")
	("TotalEffort")
	("Place")
	("Members")
	("Presenter")
	("Telephone")
	("Price")))

;; カラムビューで表示する項目
;; Column の書式は以下.
;; [http://orgmode.org/manual/Column-attributes.html#Column-attributes
(setq org-columns-default-format
      "%50ITEM(Task) %2PRIORITY(TB) %10WhenDo %18DEADLINE %18SCHEDULED %5TotalEffort(Total Effort){:} %5Effort(Effort){:} %10CLOCKSUM_T(Clock)")
(setq org-agenda-columns-add-appointments-to-effort-sum t)
(setq org-highest-priority ?A)
(setq org-lowest-priority ?D)
(setq org-default-priority ?C)

;; 全見積時間
(define-key org-mode-map (kbd "C-c C-x M-e") (lambda ()(interactive)(org-set-property "TotalEffort" nil)))
;; いつやるか?
(define-key org-mode-map (kbd "C-c C-x w") (lambda ()(interactive)(org-set-property "WhenDo" nil)))

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
    (Org-capture nil "c")))

;; Tagリスト
(setq org-tag-alist
      '(("#odw" . ?#)
	("books" . ?b)
	("code" . ?c)
	("dicom" . ?d)
	("emacs" . ?e)
	("git" . ?g)
	("evinsite" . ?i)
	("remark" . ?m)
	("obstruction" . ?o)
	("redmine" . ?r)
	("tips" . ?t)
	("windows" . ?w)
	))
(setq org-tag-faces
      '(("#[0-9]+" . (:foreground "#00FFFF"))
	("H#[0-9]+" . (:foreground "#00FFFF"))
	("#odw" . (:foreground "#00FFFF"))
	("rest" . (:foreground "#F00000"))
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
;; agendaファイルへの転送設定
(setq org-refile-targets
      '((nil :maxlevel . 3)
        ;; ("tasks.org" :level . 1)
	("daily-journal.org" :maxlevel . 3)))
;; ;; inbox リストを表示
;; (defun my-sparse-inbox-tree ()
;;   (interactive)
;;   (org-tags-view nil "inbox"))
;; (global-set-key (kbd "C-c <insert>") 'my-sparse-inbox-tree)
;; ;; next リストを表示
;; (defun my-sparse-next-tree ()
;;   (interactive)
;;   (org-tags-view nil "next"))
;; (global-set-key (kbd "C-c v") 'my-sparse-next-tree)
;; リストの項目を TAB で選択
(org-defkey org-agenda-mode-map [(tab)]
	    '(lambda () (interactive)
	       (org-agenda-goto)
	       (with-current-buffer "*Org Agenda*"
		 (org-agenda-quit))))
;; ;; inbox,nextタグを簡単に付与する
;; (defun my-toggle-inbox-tag ()
;;   (interactive)
;;   (my-toggle-tag "inbox"))
;; (defun my-toggle-next-tag ()
;;   (interactive)
;;   (my-toggle-tag "next"))
;; ;; inboxタグをトグルする
;; (defun my-toggle-tag (my-toggle-tag)
;;   (when (eq major-mode 'org-mode)
;;     (save-excursion
;;       (save-restriction
;;         (unless (org-at-heading-p)
;;           (outline-previous-heading))
;;         (if (string-match (concat ":" my-toggle-tag ":") (org-get-tags-string))
;;             (org-toggle-tag my-toggle-tag 'off)
;;           (org-toggle-tag my-toggle-tag 'on))
;;         (org-reveal)))))
;; (define-key org-mode-map (kbd "<C-insert>") 'my-toggle-inbox-tag)
;; (define-key org-mode-map (kbd "<M-insert>") 'my-toggle-next-tag)


;; 見出し間を移動
(define-key org-mode-map (kbd "M-n") 'org-forward-heading-same-level)
(define-key org-mode-map (kbd "M-p") 'org-backward-heading-same-level)
(define-key org-mode-map (kbd "M-u") 'outline-up-heading)

;; ショートカットキー
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-c`" 'org-capture-log)
(global-set-key "\C-cm" 'org-capture-memo)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cr" 'org-capture-code-reading)
(global-set-key "\C-c\C-x\C-j" 'org-clock-goto)
(global-set-key "\C-c\C-x\C-e" 'org-clock-modify-effort-estimate)

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

;; latex
(require 'ox)
(setq org-latex-create-formula-image-program 'dvipng) 
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))

;; calfw連携。
;; 予定専用orgファイルを開く。
(defun show-org-buffer (file)
  "Show an org-file on the current buffer"
  (interactive)
  (if (get-buffer file)
      (let ((buffer (get-buffer file)))
	(switch-to-buffer buffer)
	(message "%s" file))
    (find-file (concat org-directory file))))
(defun my-show-org-today-buffer (file)
  "Show an org-file today's index on the current buffer."
  (interactive)
  (if (get-buffer file)
      (let ((buffer (get-buffer file))
	    (index (format-time-string "%Y-%m-%d %A")))
	(switch-to-buffer buffer)
	(goto-char 0)
	(search-forward index nil t)
	;; (message "%s:%s" file index))
        (find-file (concat org-directory file)))))
(global-set-key (kbd "C-?")
		'(lambda ()
		   (interactive)
		   (my-show-org-today-buffer "daily-journal.org")))
;; create ical file
;; (require 'org-icalendar)
(defun my-org-export-icalendar ()
  (interactive)
  (org-export-icalendar nil (concat org-directory "daily-journal.org")))
(define-key org-mode-map (kbd "C-c 1") 'my-org-export-icalendar)
;; iCal の説明文
(setq org-icalendar-combined-description "OrgModeのスケジュール出力")
;; カレンダーに適切なタイムゾーンを設定する(google 用には nil が必要)
(setq org-icalendar-timezone "Asia/Tokyo")
;; DONE になった TODO は出力対象から除外する
(setq org-icalendar-include-todo t)
;; (通常は，<>--<> で区間付き予定をつくる．非改行入力で日付がNoteに入らない)
(setq org-icalendar-use-scheduled '(event-if-todo))
;; DL 付きで終日予定にする：締め切り日(スタンプで時間を指定しないこと)
(setq org-icalendar-use-deadline '(event-if-todo))

;; MobileOrg
(setq org-mobile-directory "~/Dropbox/アプリ/MobileOrg/")
(setq org-mobile-files
      (list "~/Dropbox/org/notes.org"
            ;; "~/Dropbox/org/tasks.org"
            "~/Dropbox/org/daily-journal.org"
            "~/Dropbox/org/iphone.org"
            ))
(setq org-mobile-inbox-for-pull "~/Dropbox/org/iphone.org")
;; (org-mobile-pull)			; 起動時に読み取り -> init.el

;; (set-face-foreground 'face "color")
;; (set-face-background 'face "color")
;; (set-face-underline-p 'face t)
;; (set-face-bold-p 'face t)
;; (set-face-italic-p 'face nil)
;; ------------------------------------------------------------------------
