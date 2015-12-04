; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ eww mode
(require 'eww)
(defvar eww-disable-colorize t)
(defun shr-colorize-region–disable (orig start end fg &optional bg &rest _)
  (unless eww-disable-colorize
    (funcall orig start end fg)))
(advice-add 'shr-colorize-region :around 'shr-colorize-region–disable)
(advice-add 'eww-colorize-region :around 'shr-colorize-region–disable)

(defun eww-disable-color ()
  "eww で文字色を反映させない"
  (interactive)
  (setq-local eww-disable-colorize t)
  (eww-reload))
(defun eww-enable-color ()
  "eww で文字色を反映させる"
  (interactive)
  (setq-local eww-disable-colorize nil)
  (eww-reload))

(setq eww-search-prefix "http://www.google.co.jp/search?q=")
(defun eww-search (term)
  (interactive "sSearch terms: ")
  (setq eww-hl-search-word term)
  (eww-browse-url (concat eww-search-prefix term)))

(add-hook 'eww-after-render-hook (lambda ()
				    (highlight-regexp eww-hl-search-word)
				    (setq eww-hl-search-word nil)))
(defun eww-disable-images ()
  "eww で画像表示させない"
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image-alt)
  (eww-reload))
(defun eww-enable-images ()
  "eww で画像表示させる"
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image)
  (eww-reload))
(defun shr-put-image-alt (spec alt &optional flags)
  (insert alt))
;; はじめから非表示
(defun eww-mode-hook–disable-image ()
  (setq-local shr-put-image-function 'shr-put-image-alt))
(add-hook 'eww-mode-hook 'eww-mode-hook–disable-image)

;; 現在開いているファイルのパスを保存. dired を開いているときはディレクトリパスを保存. 
(defun my/get-curernt-path ()
  (if (equal major-mode 'dired-mode)
      default-directory
    (buffer-file-name)))

(defun my/copy-current-path ()
  (interactive)
  (let ((fPath (my/get-curernt-path)))
    (when fPath
      (message "stored path: %s" fPath)
      (kill-new (file-truename fPath)))))

(global-set-key (kbd "C-c 0") 'my/copy-current-path)

;; org-mode のヘビーユーザなので, url を org-link で扱いたい. org-link に変換した上で保存.
(defun my/copy-current-org-link-path ()
  (interactive)
  (let* ((fPath (my/get-curernt-path))
	 (fName (file-relative-name fPath)))
    (my/copy-org-link fPath fName)))

(defun my/copy-org-link (my/current-path my/current-title)
  (let ((orgPath
	 (format "[[%s][%s]]" my/current-path my/current-title)))
    (message "stored org-link: %s" orgPath)
    (kill-new orgPath)))

(global-set-key (kbd "C-x @ @") 'my/copy-current-org-link-path)

;; eww-copy-page-url (w) で現在の URL をクリップボードにコピーできる.
(defun eww-copy-page-org-link ()
  (interactive)
  (my/copy-org-link (eww-current-url) (eww-current-title)))
(define-key eww-mode-map (kbd "0") 'eww-copy-page-org-link)
;; ------------------------------------------------------------------------
