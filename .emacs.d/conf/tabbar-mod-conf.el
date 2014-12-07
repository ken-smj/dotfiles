; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ tabbar
(require 'cl)
(require 'tabbar)
;; タブのグループ化の例
;;(defun my-tabbar-buffer-groups (buffer)
;;  (with-current-buffer (get-buffer buffer)
;;    (cond
;;     ((string-match "^\\*.*" (buffer-name)) , ("Emacs Buffer"))
;;     ((eq major-mode 'dired-mode)
;;      '("Dired"))
;;     (t (list "User Buffer")))))
;;(setq tabbar-buffer-groups-function 'my-tabbar-buffer-groups)
;;
;; タブをグループ化しない例
;;(defun tabbar-buffer-groups-all (buffer)
;;(list "All"))
;;(setq tabbar-buffer-groups-function 'tabbar-buffer-groups-all)
;;
;; "*"で始まるバッファをタブとして表示しない例
;;(defun my-tabbar-buffer-list ()
;;  (remove-if
;;   (lambda (buffer)
;;     (find (aref (buffer-name buffer) 0) "*"))
;;   (buffer-list)))
;;(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)
;;
;; タブ上でマウスホイールを使わない
(tabbar-mwheel-mode nil)
;; グループを使わない
;; (setq tabbar-buffer-groups-function nil)
;; 左側のボタンを消す
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))
(global-set-key [(control right)] 'tabbar-forward-tab)
(global-set-key [(control left)] 'tabbar-backward-tab)
(global-set-key [(control up)] 'tabbar-forward-group)
(global-set-key [(control down)] 'tabbar-backward-group)
;; tabbarを有効にする
(tabbar-mode)
;; 色設定
(set-face-attribute ; バー自体の色
  'tabbar-default nil
   :background "gray"
   :family "Inconsolata"
   :height 1.0)
(set-face-attribute ; アクティブなタブ
  'tabbar-selected nil
   :background "navy"
   :foreground "gray"
   :weight 'bold
   :box nil)
(set-face-attribute ; 非アクティブなタブ
  'tabbar-unselected nil
   :background "gray"
   :foreground "black"
   :box nil)
(require 'cl)
   (require 'tabbar)
   ;; scratch buffer 以外をまとめてタブに表示する
   (setq tabbar-buffer-groups-function
         (lambda (b) (list "All Buffers")))
   (setq tabbar-buffer-list-function
         (lambda ()
           (remove-if
            (lambda(buffer)
              (unless (string-match (buffer-name buffer) "\\(*scratch*\\|*Apropos*\\|*shell*\\|*eshell*\\|*Customize\\)")
                (find (aref (buffer-name buffer) 0) " *"))
              )
            (buffer-list))))
;; ボタンをシンプルにする
(setq tabbar-home-button-enabled "")
(setq tabbar-scroll-right-button-enabled "")
(setq tabbar-scroll-left-button-enabled "")
(setq tabbar-scroll-right-button-disabled "")
(setq tabbar-scroll-left-button-disabled "")
;; Ctrl-Tab, Ctrl-Shift-Tab でタブを切り替える
(dolist (func '(tabbar-mode tabbar-forward-tab tabbar-forward-group tabbar-backward-tab tabbar-backward-group))
  (autoload func "tabbar" "Tabs at the top of buffers and easy control-tab navigation"))
(defmacro defun-prefix-alt (name on-no-prefix on-prefix &optional do-always)
  `(defun ,name (arg)
     (interactive "P")
     ,do-always
     (if (equal nil arg)
	 ,on-no-prefix
       ,on-prefix)))
(defun-prefix-alt shk-tabbar-next (tabbar-forward-tab) (tabbar-forward-group) (tabbar-mode 1))
(defun-prefix-alt shk-tabbar-prev (tabbar-backward-tab) (tabbar-backward-group) (tabbar-mode 1))
(global-set-key [(control tab)] 'shk-tabbar-next)
(global-set-key [(control shift tab)] 'shk-tabbar-prev)
;; ------------------------------------------------------------------------
