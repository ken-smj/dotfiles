; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ minbuf 履歴 と セッションの保存。
(require 'filecache)
;; ファイル名だけでbufferを開く
(file-cache-add-directory-list
 (list "~" ;; ディレクトリを追加
       "~/.emacs.d/conf/"
       "~/Dropbox/org/"
       ;; "/DEVELOP/"
       ;; "/DEVELOP/working.r.3.1.1.current.svn.project/EVInsite/EVImage/"
       ;; "/DEVELOP/working.r.3.1.1.current.svn.project/EVInsite/EVClient/"
       ;; "/DEVELOP/working.r.3.1.1.current.svn.project/EVlib/include/client/"
       ;; "/DEVELOP/working.r.3.1.1.current.svn.project/EVlib/include/client/data/"
       ;; "/DEVELOP/working.r.3.1.1.current.svn.project/EVlib/include/client/image/"
       ;; "/DEVELOP/working.r.3.1.1.current.svn.project/EVlib/include/util/"
       ;; "/DEVELOP/working.r.3.1.1.current.svn.project/EVlib/include/dcm/"
       ))
(file-cache-add-file-list
 (list "~/.emacs.d/init.el" ;; ファイルを追加
       ))
(define-key minibuffer-local-completion-map "\C-c\C-i"
  'file-cache-minibuffer-complete)
(require 'minibuf-isearch)
(require 'session)
(setq history-length 200) ;; そもそものミニバッファ履歴リストの最大長
(setq session-initialize '(de-saveplace session keys menus places)
      session-globals-include '((kill-ring 50)             ;; kill-ring の保存件数
                                (session-file-alist 50 t)  ;; カーソル位置を保存する件数
                                (file-name-history 200)))  ;; ファイルを開いた履歴を保存する件数
(add-hook 'after-init-hook 'session-initialize)
(setq session-undo-check -1)
;; ------------------------------------------------------------------------
