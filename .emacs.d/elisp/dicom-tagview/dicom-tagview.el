;;; dicom-tagview.el --- Major mode for viewing DICOM tag.  -*- coding: utf-8-unix ; lexical-binding: t -*-

;; Copyright (C) 2018 Ken-ichiro Shimojyo

;; Author:     Paul Pogonyshev <pogonyshev@gmail.com>
;; Maintainer: Paul Pogonyshev <pogonyshev@gmail.com>
;; Version:    0.9
;; Keywords:   files, tools
;; Homepage:   https://github.com/doublep/logview
;; Package-Requires: ((emacs "24.4") (datetime "0.3"))

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see http://www.gnu.org/licenses.


;;; Commentary:

;; Logview mode provides syntax highlighting, filtering and other
;; features for various log files.  The main target are files similar
;; to ones generated by Log4j, Logback and other Java logging
;; libraries, but there is really nothing Java-specific in the mode
;; and it should work just fine with any log that follows similar
;; structure, probably after some configuration.


;;; Code:

(require 'hexl)

;;;###autoload
(defun dicom-tagview-open-buffer ()
  "Convert a binary buffer to hexl format.
This discards the buffer's undo information."
  (interactive)
  (and (consp buffer-undo-list)
       (or (y-or-n-p "Converting to hexl format discards undo info; ok? ")
	   (error "Aborted"))
       (setq buffer-undo-list nil))
  ;; Don't decode text in the ASCII part of `hexl' program output.
  (let ((coding-system-for-read 'raw-text)
	(coding-system-for-write buffer-file-coding-system)
	(buffer-undo-list t))
    (apply 'call-process-region (point-min) (point-max)
	   (expand-file-name hexl-program exec-directory)
	   t t nil
           ;; Manually encode the args, otherwise they're encoded using
           ;; coding-system-for-write (i.e. buffer-file-coding-system) which
           ;; may not be what we want (e.g. utf-16 on a non-utf-16 system).
           (mapcar (lambda (s)
                     (if (not (multibyte-string-p s)) s
                       (encode-coding-string s locale-coding-system)))
                   (split-string (hexl-options))))
    (if (> (point) (hexl-address-to-marker hexl-max-address))
	(hexl-goto-address hexl-max-address))))

(defvar dicom-tagview-mode-map
  (let ((map (make-keymap)))
    (define-key map "dcm" 'dicom-tagview-open-buffer)
    map))

(defun dicom-tagview-mode ()
  "The DICOM file tag viewer."
  (interactive)
  (setq major-mode 'dicom-tagview-mode)
  (setq mode-name "DCM")
  (use-local-map dicom-tagview-mode-map))
    
