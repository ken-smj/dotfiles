; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ scroll
;; バッファの先頭までスクロールアップ
(defadvice scroll-up (around scroll-up-around)
  (interactive)
  (let* ( (start_num (+ 1 (count-lines (point-min) (point))) ) )
    (goto-char (point-max))
    (let* ( (end_num (+ 1 (count-lines (point-min) (point))) ) )
      (goto-line start_num )
      (let* ( (limit_num (- (- end_num start_num) (window-height)) ))
	(if (< (- (- end_num start_num) (window-height)) 0)
	    (goto-char (point-max))
	  ad-do-it)))))
(ad-activate 'scroll-up)
;; バッファの最後までスクロールダウン
(defadvice scroll-down (around scroll-down-around)
  (interactive)
  (let* ( (start_num (+ 1 (count-lines (point-min) (point)))) )
    (if (< start_num (window-height))
	(goto-char (point-min))
      ad-do-it)))
(ad-activate 'scroll-down)
;; ------------------------------------------------------------------------
