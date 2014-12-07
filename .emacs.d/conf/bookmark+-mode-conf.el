; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ bookmarks
;;
;; C-x r m      : mark on bookmark
;; C-x r l      : list of bookmarks
;; C-x r b      : jump to bookmark
;;
;;    ****** NOTE ******
;;
;;      On 2010-06-18, I changed the prefix used by package Bookmark+
;;      from `bookmarkp-' to `bmkp-'.  THIS IS AN INCOMPATIBLE CHANGE.
;;      I apologize for the inconvenience, but the new prefix is
;;      preferable for a number of reasons, including easier
;;      distinction from standard `bookmark.el' names.
;;
;;      This change means that YOU MUST MANUALLY REPLACE ALL
;;      OCCURRENCES of `bookmarkp-' by `bmkp-' in the following
;;      places, if you used Bookmark+ prior to this change:
;;
;;      1. In your init file (`~/.emacs') or your `custom-file', if
;;         you have one.  This is needed if you customized any
;;         Bookmark+ features.
;;
;;      2. In your default bookmark file, `bookmark-default-file'
;;         (`.emacs.bmk'), and in any other bookmark files you might
;;         have.
;;
;;      3. In your `*Bookmark List*' state file,
;;         `bmkp-bmenu-state-file' (`~/.emacs-bmk-bmenu-state.el').
;;
;;      4. In your `*Bookmark List*' commands file,
;;         `bmkp-bmenu-commands-file' (`~/.emacs-bmk-bmenu-commands.el'),
;;         if you have one.
;;
;;      You can do this editing in a virgin Emacs session (`emacs
;;      -Q'), that is, without loading Bookmark+.
;;
;;      Alternatively, you can do this editing in an Emacs session
;;      where Bookmark+ has been loaded, but in that case you must
;;      TURN OFF AUTOMATIC SAVING of both your default bookmark file
;;      and your `*Bookmark List*' state file.  Otherwise, when you
;;      quit Emacs your manually edits will be overwritten.
;;
;;      To turn off this automatic saving, you can use `M-~' and `M-l'
;;      in buffer `*Bookmark List*' (commands
;;      `bmkp-toggle-saving-bookmark-file' and
;;      `bmkp-toggle-saving-menu-list-state' - they are also in the
;;      `Bookmark+' menu).
;;
;;
;;      Again, sorry for this inconvenience.
;;
;;    ******************
(recentf-mode 1)
(setq recentf-max-menu-items 20)
(setq recentf-max-saved-items 100)
(require 'bookmark+)
(setq bookmark-default-file "~/.emacs.d/tmp/.emacs.bmk")
(setq bmkp-bmenu-state-file "~/.emacs.d/tmp/.emacs-bmk-bmenu-state.el")
(setq bmkp-bmenu-commands-file "~/.emacs-bmk-bmenu-commands.el")
(setq bookmark-save-flag 1)
(progn
  (setq bookmark-sort-flag nil)
  (defun bookmark-arrange-latest-top ()
    (let ((latest (bookmark-get-bookmark bookmark)))
      (setq bookmark-alist (cons latest (delq latest bookmark-alist))))
    (bookmark-save))
  (add-hook 'bookmark-after-jump-hook 'bookmark-arrage-latest-top))
;; ------------------------------------------------------------------------
