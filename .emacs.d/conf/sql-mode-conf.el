; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ sql-mode
;; http://www.emacswiki.org/cgi-bin/wiki.pl?SqlMode
(when (require 'sql nil t)
  (autoload 'sql-mode "sql" "SQL Edit mode" t)
  (autoload 'sql-oracle "sql" "SQL Edit mode" t)
  (autoload 'sql-ms "sql" "SQL Edit mode" t)
  (autoload 'master-mode "master" "Master mode minor mode." t)
  (add-to-list 'process-coding-system-alist '("sqlcmd" . cp850-dos)))
;; ;; デフォルトのデータベースの設定
;; (setq sql-user "user")
;; (setq sql-password "passwd")
;; (setq sql-server "192.168.xxx.xxx\\MSSQL2012")
;; (setq sql-database "ServerName")
;; C-c C-c : 'sql-send-paragraph
;; C-c C-r : 'sql-send-region
;; C-c C-s : 'sql-send-string
;; C-c C-b : 'sql-send-buffer
(add-hook 'sql-interactive-mode-hook
          #'(lambda ()
              (interactive)
              (set-buffer-process-coding-system 'sjis-unix 'sjis-unix )
              (setq show-trailing-whitespace nil)))
;; starting SQL mode loading sql-indent / sql-complete
(eval-after-load "sql"
  '(progn
     (load-library "sql-indent")
     (load-library "sql-complete")
     (load-library "sql-transform")))
(setq auto-mode-alist
      (cons '("\\.sql$" . sql-mode) auto-mode-alist))
;(sql-set-product-feature
; 'ms :font-lock 'sql-mode-ms-font-lock-keywords)
(defcustom sql-ms-program "sqlcmd"
  "Command to start sqlcmd by SQL Server."
  :type 'file
  :group 'SQL)
(sql-set-product-feature
 'ms :sql-program 'sql-ms-program)
(sql-set-product-feature
 'ms :sqli-prompt-regexp "^[0-9]*>")
(sql-set-product-feature
 'ms :sqli-prompt-length 5)
(defcustom sql-ms-login-params
  '(user password server database)
  "Login parameters to needed to connect to mssql."
  :type '(repeat (choice
                  (const user)
                  (const password)
                  (const server)
                  (const database)))
  :group 'SQL)
(defcustom sql-ms-options '("-U" "-P" "-S" "-d")
  "List of additional options for `sql-ms-program'."
  :type '(repeat string)
  :group 'SQL)
(defun sql-connect-ms ()
  "Connect ti SQL Server DB in a comint buffer."
  ;; Do something with `sql-user', `sql-password',
  ;; `sql-database', and `sql-server'.
  (let ((f #'(lambda (op val)
               (unless (string= "" val)
                 (setq sql-ms-options
                       (append (list op val) sql-ms-options)))))
        (params `(("-U" . ,sql-user)("-P" . ,sql-password)
                  ("-S" . ,sql-server)("-d" . ,sql-database))))
    (dolist (pair params)
      (funcall f (car pair)(cdr pair)))
    (sql-connect-1 sql-ms-program sql-ms-options)))
;(sql-set-product-feature
; 'ms :sqli-login 'sql-ms-login-params)
(sql-set-product-feature
 'ms :sqli-connect 'sql-connect-ms)
(defun run-mssql ()
  "Run mssql by SQL Server as an inferior process."
  (interactive)
  (sql-product-interactive 'ms))
;; ------------------------------------------------------------------------
