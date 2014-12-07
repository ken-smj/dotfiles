; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ calender
;;diary-file を howm のディレクトリに置く
(setq diary-file
      (expand-file-name "Diary" howm-directory))
(require 'calendar)
;; キーの設定
(define-key calendar-mode-map "f" 'calendar-forward-day)
(define-key calendar-mode-map "n" 'calendar-forward-day)
(define-key calendar-mode-map "b" 'calendar-backward-day)
;; 装飾表示。
(add-hook 'diary-display-hook 'fancy-diary-display)
;; 日誌記録がない祝祭日も表示する。
(setq diary-list-include-blanks t)
;; アラーム
(setq appt-audible t)
(setq appt-display-mode-line t)
(setq appt-display-format 'window)
(setq appt-display-duration 180)
(appt-activate)
;; 祝日をマークする
(setq calendar-mark-holidays-flag t)
(setq number-of-diary-entries 31)
(setq mark-holidays-in-calendar t)
(setq calendar-mark-diary-entries-flag t)
;; (install-elisp "http://www.meadowy.org/meadow/netinstall/export/799/branches/3.00/pkginfo/japanese-holidays/japanese-holidays.el")
(require 'japanese-holidays)
(setq calendar-holidays
      (append japanese-holidays holiday-local-holidays holiday-other-holidays))
(setq mark-holidays-in-calendar t) ; 祝日をカレンダーに表示
;; 今日をマークする
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)
;; 日曜日をマークにする
(setq calendar-weekend-marker 'diary)
(add-hook 'today-visible-calendar-hook 'japanese-holiday-mark-weekend)
(add-hook 'today-invisible-calendar-hook 'japanese-holiday-mark-weekend)
;;緯度，経度設定　（日の出，日の入り時刻用）
(setq calendar-latitude 35.7)		; 東大和
(setq calendar-longitude 139.4)
(when (string= system-name "SHIMOJOKENICHIR")
  (setq calendar-latitude 35.7)		; 西麻布
  (setq calendar-longitude 139.7))
(setq calendar-location-name "Tokyo, JAPAN")
(setq calendar-time-zone +540)
(setq calendar-standard-time-zone-name "JST")
(setq calendar-daylight-time-zone-name "JST")
;; M-x calendar しといて M-x howm-from-calendar
;;         → その日付を検索
(defun howm-from-calendar ()
  (interactive)
  (require 'howm-mode)
  (let* ((mdy (calendar-cursor-to-date t))
         (m (car mdy))
         (d (second mdy))
         (y (third mdy))
         (key (format-time-string
               howm-date-format
               (encode-time 0 0 0 d m y))))
    (howm-keyword-search key)))
;;カレンダーの上で D を押すと grep
(add-hook 'initial-calendar-window-hook
          '(lambda ()
             (local-set-key
              "D" 'howm-from-calendar)))
;;howm のメニューで d でカレンダー
(add-hook 'howm-menu-hook
          '(lambda ()
             (local-set-key "d" 'calendar)))
(put 'upcase-region 'disabled nil)
;; ------------------------------------------------------------------------
;; @ calfw
(require 'calfw-cal)
(require 'calfw-ical)
(require 'calfw-howm)
(require 'calfw-org)
(defun my-open-calendar ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source "Green")  ; orgmode source
    (cfw:howm-create-source "Blue")  ; howm source
    (cfw:cal-create-source "Orange") ; diary source
    ;; (cfw:ical-create-source "Moon" "~/moon.ics" "Gray")  ; ICS source1
    ;; (cfw:ical-create-source "gcal" "https://..../basic.ics" "IndianRed") ; google calendar ICS
    )))
(global-set-key "\C-t"  'my-open-calendar)
;; ------------------------------------------------------------------------
