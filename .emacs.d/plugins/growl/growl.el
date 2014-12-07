;;; growl.el --- Emacs interface to Growl via growlnotify

;; Copyright (C) 2005  Edward O'Connor

;; Author: Edward O'Connor <ted@evdb.com>
;; Keywords: convenience
;; Version: 1.0.0

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; http://edward.oconnor.cx/elisp/growl.el

;;; Code:

(unless (executable-find "growlnotify")
  (error "growl.el requires that you install the `growlnotify' program."))

(defsubst growl-ensure-quoted-string (arg)
  (shell-quote-argument
   (cond ((null arg) "")
         ((stringp arg) arg)
         (t (format "%s" arg)))))

(defun growl (growl-message &optional growl-subject growl-sticky)
  "Notify the user of something via Growl."
  (shell-command
   (concat "growlnotify /a:Emacs /n:Emacs"
           (if growl-sticky " /s:true")
           (if growl-subject
               (concat " /t:" (growl-ensure-quoted-string growl-subject)))
	   " " (growl-ensure-quoted-string growl-message)
	   ))
   (get-buffer-create "*growl output*")
   growl-message)

(provide 'growl)
;;; growl.el ends here
