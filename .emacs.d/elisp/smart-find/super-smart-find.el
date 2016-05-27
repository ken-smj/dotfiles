;;; super-smart-find.el --- an extension of smart-find.el
;; Copyright (c) 1995-2000 Katsumi Yamaoka <yamaoka@jpl.org>
;; (smart-find.el: Copyright (c) 1990 by Wayne Mesard.)

;; [2001/02/01] hira (khi@users.sourceforge.jp) 非公式改造版。
;; 改造版 smart-find.el にあわせて、微小改造。(改造箇所は「hira」を検索)

(defconst super-smart-find-version "1.8"
  "Version numbers of this version of super-smart-find.el")
(defconst super-smart-find-patch-level "6"
  "Patch level of this version of super-smart-find.el")

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; HISTORY
;;
;; v1.86  2000.04.07
;;     ・新規に作成するファイルを find-file したときも、coding system
;;       が指定されていたら、正しく設定するようにした。
;;
;; v1.85  2000.01.31
;;     ・関数 find-coding-system の引数に symbol 以外の値を与えないよ
;;       うにした。XEmacs 21.2.27+ 対策。
;;
;; v1.84    99.04.07
;;     ・すでに visit している file の buffer に、coding-system を指定
;;       して同じ file を insert しようとしたときに起きるバグを修正。
;;
;; v1.83    99.02.02
;;     ・すでに visit している file でも file の modtime が新しかった
;;       ら user-coding-system を問う。
;;
;; v1.82    99.01.22
;;     ・すでに visit している file に対しては user-coding-system を
;;       問わないようにした。
;;
;; v1.81    98.12.17
;;     ・super-smart-find-file-other-frame が arg を無視するバグを修
;;       正した。
;;
;; v1.80    98.06.15
;;     ・再び塚本さんのご指摘により、XEmacs で最初のキーが self-insert
;;       command として認識されないバグを修正した。
;;
;; v1.79    98.06.12
;;     ・塚本さん <czkmt@remus.dti.ne.jp> のご指摘により、XEmacs で
;;       [backspace] と C-h を別のキーとして扱うようにした。
;;
;; v1.78    98.04.10
;;     ・ファイル名の入力時に cursor を minibuffer に移すのを忘れてい
;;       たので直した。(これも小関さんのご指摘)
;;
;; v1.77    98.04.10
;;     ・XEmacs 以外の Emacsen において、lookup-key() が返す integer
;;       を無視するようにした。
;;
;; v1.76    98.04.10
;;     ・enbug に次ぐ enbug を修正。(^^;;)
;;
;; v1.75    98.04.10
;;     ・XEmacs で最初の event key で起るエラーを回避。(enbug 修正)
;;
;; v1.74    98.04.09
;;     ・Mule 2.3 と XEmacs で最初の M-p などの event で起るエラーを
;;       回避。
;;
;; v1.73    98.04.07
;;     ・Emacs 20.2 で最初の M-p などの event で起るエラーを回避。
;;       (小関さん <kose@wizard.tamra.co.jp> のご指摘により)
;;
;; v1.72    97.12.08
;;     ・XEmacs で最初の C-g が無視されてしまうバグを修正。
;;
;; v1.71    97.07.24
;;     ・find-file などが第２引数 USER-CODING-SYSTEM を受け付けるかど
;;       うかの判別を universal-coding-system-argument() の有無で行う
;;       ようにした。
;;
;; v1.70    97.07.18
;;     ・Emacs 20.0.9 に対応。第２引数 USER-CODING-SYSTEM を受け付け
;;       ない find-file, find-file-other-frame, find-file-other-window,
;;       insert-file, write-file でも使えるようにした。
;;
;; v1.63    97.04.28
;;     ・command-history に実コマンド (super-smart-find-file -> find-file)
;;       を登録。
;;     ・SEMI-0.75 の mime-edit-insert-file に対応。
;;
;; v1.62    97.02.19
;;     ・XEmacs 20.1 に対応。
;;
;; v1.61    96.12.25
;;     ・tm7.99 の mime-editor/insert-file に対応。
;;       tm-edit.el の改造は不要。
;;
;; (番外)   96.12.24
;;     ・tm7.98 の mime-editor/insert-file に対応。
;;       tm-edit.el の改造が必要。
;;
;; v1.60    96.12.10
;;     ・Coding system の指定に対応。(C-u C-x C-f)
;;     ・tm7.95 の mime-editor/insert-file に対応。
;;
;; v1.50    96.07.30
;;     ・-nw で Sony NEWS の key pad に対応。
;;     ・tm7.74 の mime-editor/insert-file に対応。
;;       (単に変わっていないことを確認しただけ ^^;;)
;;
;; v1.40    96.03.15
;;     ・塩野さん <jun@fs.fujitsu.co.jp> のご提供により、存在しない
;;       ディレクトリを smart-find-file-path から削除する関数、
;;       super-smart-find-file-path-check を追加。
;;       また、変数 super-smart-find-do-file-path-check を Non-nil に
;;       しておくと、super-smart-find を load したときに実行する。
;;     ・file-name-history に real-name を登録。 (19.29 以上で有効)
;;     ・tm7.48 の mime-editor/insert-file に対応。
;;       (単にコピーしただけ ^^;;)
;;
;; v1.31    96.01.05
;;     ・tm7.39 の mime-editor/insert-file に対応。
;;
;; v1.30    95.10.30
;;     ・tm の mime-editor/insert-file に対応。
;;
;; v1.20    95.06.07
;;     ・佐久間さん <KHB10110@niftyserve.or.jp> のご指摘により、
;;       変数 super-smart-find-self-insert-command-list を新設し、
;;       nil だったら apropos で *-self-insert-command を自動抽出、
;;       既知の *-self-insert-command のリストだった場合にはそれを
;;       参照するように変更。
;;     ・元の minibuffer-setup-hook の値を壊さないように変更。
;;
;; v1.10    95.05.12
;;     ・塩野さん <jun@fs.fujitsu.co.jp> のご提言により、
;;       canna-self-insert-command を追加。
;;     ・関数 super-smart-find-load-file を追加。
;;     ・関数 super-smart-find-mime-insert-file を追加。
;;       (tm-ML の末席を汚してる者としては、これは入れとかねば :-)
;;
;; v1.00    95.05.09

;;; DESCRIPTION
;;
;;     おこがましくも super- の名を冠するこのプログラムは、Mule 2.x,
;;     Emacs 20.x または XEmacs 20.x 上で、あらかじめ設定された複数の
;;     ディレクトリの下に存在するファイルを、ディレクトリ名の指定を必
;;     要とせずに completion 機能を併用して読み込むことができるように
;;     するための、find-file 系の関数に smart-find の機能を付加するた
;;     めのプログラムです。
;;     これを使うためには smart-find.el が必要です。
;;
;;     Emacs ver.18 でも曲がりなりに使えますが、いろいろと問題があり
;;     ます。

;;; HOW TO USE
;;
;;     このファイルと smart-find.el を load-path のディレクトリの下に
;;     コピーして byte-compile-file して下さい。そして ~/.emacs に
;
;(require 'super-smart-find)
;(define-key global-map "\C-x\C-f" 'super-smart-find-file)
;(define-key global-map "\C-x4f"   'super-smart-find-file-other-window)
;(define-key global-map "\C-xi"    'super-smart-find-insert-file)
;(define-key global-map "\C-x\C-w" 'super-smart-find-write-file)
;(define-key global-map "\C-x5f"   'super-smart-find-file-other-frame)
;(define-key global-map "\C-x4l"   'super-smart-find-load-file)
;(add-hook 'mime/editor-mode-hook
;	  '(lambda ()
;	     (define-key (current-local-map)
;	       "\C-c\C-x\C-i" 'super-smart-find-mime-editor/insert-file)
;	     (if (string-match "^19\\." emacs-version)
;		 (define-key (current-local-map) [menu-bar mime-edit file]
;		   '("Insert File" . super-smart-find-mime-editor/insert-file))
;	       )) t)
;
;;     と書いておくことによって、find-file, file-other-window, および
;;     find-file-other-frame など、それぞれのコマンドを従来通り使うこ
;;     とができることに加えて、最初に `=' をタイプすることによって
;;     smart-find の機能に切り換わります。(Emacs ver.18 では add-hook
;;     を定義するか、別の方法で設定して下さい。)
;;
;;     tm ではなく SEMI を使っている場合はこのように書くとうまく行き
;;     ます。
;;
;(add-hook 'mime-edit-load-hook
;	  (lambda ()
;	    (define-key mime-edit-mode-map "\C-c\C-x\C-i"
;	      'super-smart-find-mime-edit-insert-file)
;	    (put-alist
;	     'file
;	     '("Insert File" super-smart-find-mime-edit-insert-file)
;	     mime-edit-menu-list)
;	    ) t)
;;
;;     smart-find でファイルをサーチするパスは smart-find-file-path
;;     という変数で設定できますので、あなたが頻繁にアクセスするファイ
;;     ルを置いてあるディレクトリを ~/.emacs の中に
;
;(setq smart-find-file-path
;      '(
;	"~"
;	"~/elisp"
;	"/usr/local/mule/site-lisp"
;	"/usr/local/mule/lisp"
;	))
;
;;     などと書いておくと良いでしょう。
;;
;;     このプログラムは最初に押されたキーが何かの self-insert-command
;;     かどうかの判定をしています。デフォルトでは apropos を使って存
;;     在するすべての self-insert-command を検出するようになっていま
;;     すが、あらかじめわかっている場合には
;
;(setq super-smart-find-self-insert-command-list
;      '(canna-self-insert-command
;	egg-self-insert-command
;	self-insert-command
;	tcode-self-insert-command-maybe))
;
;;     などと設定しておくことによって、apropos を実行するための遅れを
;;     回避することができます。

(defvar super-smart-find-switch-strings (list "=")
  "* smart-find-file の機能に切り換えるための文字、または文字のリスト。")

(defvar super-smart-find-self-insert-command-list nil
  "* 既知の self-insert-command のリスト。nil では apropos で検索する")

(defvar super-smart-find-do-file-path-check t
  "* Non-nil で super-smart-find の load 時、存在しないディレクトリを削除。
このとき smart-find-file-path の値が変化する。")

(defconst super-smart-find-real-command-alist
  '((super-smart-find-mime-editor/insert-file-internal
     . mime-editor/insert-file)
    (super-smart-find-mime-edit-insert-file-internal
     . mime-edit-insert-file)))

(let ((dont-bind-my-keys t))
  (load-library "smart-find"))
(message "")

(or (fboundp 'member)
    (defun member (elt list)
      "Return non-nil if ELT is an element of LIST.
Comparison done with EQUAL.
The value is actually the tail of LIST whose car is ELT."
      (while (and list (not (equal elt (car list))))
	(setq list (cdr list)))
      list))

(or (fboundp 'add-hook)
    (defun add-hook (hook function &optional append)
      "Add to the value of HOOK the function FUNCTION.
FUNCTION is not added if already present.
FUNCTION is added (if necessary) at the beginning of the hook list
unless the optional argument APPEND is non-nil, in which case
FUNCTION is added at the end.
HOOK should be a symbol, and FUNCTION may be any valid function.  If
HOOK is void, it is first set to nil.  If HOOK's value is a single
function, it is changed to a list of functions."
      (or (boundp hook) (set hook nil))
      ;; If the hook value is a single function, turn it into a list.
      (let ((old (symbol-value hook)))
	(if (or (not (listp old)) (eq (car old) 'lambda))
	    (set hook (list old))))
      (or (if (consp function)
	      ;; Clever way to tell whether a given lambda-expression
	      ;; is equal to anything in the hook.
	      (let ((tail (assoc (cdr function) (symbol-value hook))))
		(equal function tail))
	    (memq function (symbol-value hook)))
	  (set hook
	       (if append
		   (nconc (symbol-value hook) (list function))
		 (cons function (symbol-value hook)))))))

(or (fboundp 'remove-hook)
    (defun remove-hook (hook-var function)
      "Remove a function from a hook, if it is present.
First argument HOOK-VAR (a symbol) is the name of a hook, second
 argument FUNCTION is the function to remove (compared with `eq')."
      (let (val)
	(cond ((not (boundp hook-var))
	       nil)
	      ((eq function (setq val (symbol-value hook-var)))
	       (setq hook-var nil))
	      ((consp val)
	       ;; don't side-effect the list
	       (set hook-var (delq function (copy-sequence val))))))))

(defconst super-smart-find-second-arg-acceptable-p
  (not (fboundp 'universal-coding-system-argument)))

(defun read-char-ignore-errors ()
  (let ((cursor-in-echo-area t)
	(inhibit-quit t))
    (read-char)))

(defun call-interactively-ignore-errors (func)
  (condition-case ()
      (call-interactively func)
    (error nil)))

(defun super-smart-find-read-file-name (prompt func)
  (fset 'super-smart-find-minibuffer-setup-hook
	(function (lambda ()
		    (remove-hook 'minibuffer-setup-hook
				 'super-smart-find-minibuffer-setup-hook)
		    (if (stringp func)
			(insert func)
		      (call-interactively-ignore-errors func)))))
  (add-hook 'minibuffer-setup-hook
	    'super-smart-find-minibuffer-setup-hook t)
  (read-file-name prompt))

(defun super-smart-find-file-internal
  (user-coding-system prompt cmd &optional dired-cmd)
  (let ((ddir (if (string-match (concat "^" (expand-file-name "~"))
				default-directory)
		  (concat "~" (substring default-directory (match-end 0)))
		default-directory))
	(owindow (get-buffer-window (current-buffer)))
	char-1 mods char-2 char-3
	events key smart func quit func-x fname empty)
    (message "%s%s" prompt ddir)
    (if (featurep 'xemacs)
	(setq char-1 (let ((cursor-in-echo-area t)
			   (inhibit-quit t))
		       (next-command-event))
	      mods (event-modifiers char-1)
	      char-1 (event-key char-1)
	      events (vector (append
			      mods
			      (list (if (characterp char-1)
					(intern (char-to-string char-1))
				      char-1))))
	      key (events-to-keys events))
      (setq key (let ((cursor-in-echo-area t)
		      (inhibit-quit t))
		  (read-key-sequence nil))
	    events key
	    char-1 0))
    (if (member key super-smart-find-switch-strings)
	(progn
; 	  (completing-read (concat "Smart " prompt)
; 			   'smart-find-file-internal nil t nil)
; 	  (setq fname smart-find-file-match)
	  ;; hira [2001/01/31]
	  ;; - smart-find の呼び出しにワンクッション
	  ;; - 存在しないファイル名なら、新規作成
	  (setq fname
		(smart-find-file-read-file-name (concat "Smart " prompt)
						default-directory nil nil nil))
	  (and (boundp 'file-name-history)
	       (setq file-name-history
		     (cons fname file-name-history)))
	  (setq smart t))
      (and char-1
	   (progn
	     (select-window (minibuffer-window))
	     (if (commandp
		  (setq func (lookup-key minibuffer-local-completion-map
					 events)))
		 ()
	       (if (commandp
		    (setq func (lookup-key minibuffer-local-map events)))
		   ()
		 (setq func (key-binding events))))
	     (select-window owindow)))
      (cond
       ((memq func '(abort-recursive-edit minibuffer-keyboard-quit))
	(setq quit t))
       ((memq func
	      (or super-smart-find-self-insert-command-list
		  (if (>= (string-to-int emacs-version) 19)
		      (apropos-internal "self-insert-command" 'commandp)
		    (let ((conf (current-window-configuration)))
		      (prog1
			  (apropos "self-insert-command" 'commandp)
			(kill-buffer (get-buffer "*Help*"))
			(set-window-configuration conf)
			)))))
	(setq fname
	      (if (>= (string-to-int emacs-version) 19)
		  (super-smart-find-read-file-name prompt key)
		(read-file-name prompt (concat ddir key)))))
       ((commandp func)
	(if (eq func 'exit-minibuffer)
	    (setq empty t)
	  (setq fname (super-smart-find-read-file-name prompt func))))
       ((keymapp func)
	(setq func-x func)
	(message "%s%s" prompt ddir)
	(setq char-2 (read-char-ignore-errors))
	(cond
	 ((and (not (eq window-system 'x))
	       (eq char-1 ?\e) (eq char-2 ?\O))
	  (setq char-3 (read-char-ignore-errors))
	  (cond ((eq char-3 ?A)
		 (setq func
		       (or (and (commandp 'previous-history-element)
				'previous-history-element)
			   'previous-line)))
		((eq char-3 ?B)
		 (setq func
		       (or (and (commandp 'next-history-element)
				'next-history-element)
			   'next-line)))
		((eq char-3 ?C) (setq func 'forward-char))
		((eq char-3 ?D) (setq func 'backward-char))
		((eq char-3 ?I) (setq func 'minibuffer-complete))
		((eq char-3 ?M) (setq func 'exit-minibuffer))
		((and (>= char-3 ?j) (<= char-3 ?y))
		 (setq last-command-event (- char-3 64))
		 (setq func t))
		(t (setq func nil)))
	  (if (eq func 'exit-minibuffer)
	      (setq empty t)
	    (setq fname
		  (if func
		      (if (commandp func)
			  (super-smart-find-read-file-name prompt func)
			(super-smart-find-read-file-name
			 prompt (char-to-string (- char-3 64))))
		    (read-file-name prompt)))))
	 ((listp func)
	  (setq func (and char-2 (cdr (assoc char-2 (cdr func)))))
	  (setq fname
		(if (or (memq func '(previous-history-element
				     next-history-element))
			(eq func-x 'help-command))
		    (super-smart-find-read-file-name prompt func)
		  (read-file-name prompt))))
	 (t
	  (select-window (minibuffer-window))
	  (setq func (key-binding (concat key (char-to-string char-2))))
	  (select-window owindow)
	  (if (or (memq func '(previous-history-element
			       next-history-element))
		  (eq func-x 'help-command))
	      (setq fname
		    (super-smart-find-read-file-name prompt func))
	    (setq func-x func)
	    (message "%s%s" prompt ddir)
	    (setq char-3 (read-char-ignore-errors))
	    (and char-3
		 (progn
		   (select-window (minibuffer-window))
		   (setq func (key-binding (concat key
						   (char-to-string char-2)
						   (char-to-string char-3))))
		   (select-window owindow)))
	    (setq fname
		  (if (or (memq func '(previous-history-element
				       next-history-element))
			  (eq func-x 'help-command))
		      (super-smart-find-read-file-name prompt func)
		    (read-file-name prompt)))))))
       (t (setq fname (read-file-name prompt)))))
    (if quit
	(message "Quit")
      (and cmd
	   (let ((real-cmd
		  (or (cdr (assq cmd super-smart-find-real-command-alist))
		      cmd)))
	     (and (boundp 'command-history)
		  (setq command-history
			(cons (list real-cmd fname) command-history)))
	     ))
      (if empty
	  (cond ((memq cmd '(insert-file write-file load-file))
		 (if (buffer-file-name)
		     (funcall
		      cmd (concat default-directory
				  (file-name-nondirectory (buffer-file-name))))
		   (funcall cmd ddir)))
		((eq cmd 'super-smart-find-mime-editor/insert-file-internal)
		 (error
		  (concat "Opening input file: file is a directory, " ddir)))
		(t (funcall dired-cmd ddir)))

	(and user-coding-system
	     (not (or (coding-system-p user-coding-system)
		      (and (symbolp user-coding-system)
			   (fboundp 'find-coding-system)
			   (find-coding-system user-coding-system))))
	     (or (eq 'insert-file cmd)
		 (and (memq cmd '(find-file find-file-other-frame
					    find-file-other-window write-file))
		      (not (and (get-file-buffer fname)
				(verify-visited-file-modtime
				 (get-file-buffer fname))))))
	     (setq user-coding-system (read-coding-system "Coding-system: ")))
	(cond ((eq cmd 'write-file)
	       (if smart
		   (if (y-or-n-p (concat prompt fname " "))
		       (if super-smart-find-second-arg-acceptable-p
			   (write-file fname user-coding-system)
			 (if user-coding-system
			     (let ((coding-system-for-write
				    user-coding-system))
			       (write-file fname))
			   (write-file fname)))
		     (error ""))
		 (if super-smart-find-second-arg-acceptable-p
		     (write-file fname user-coding-system)
		   (if user-coding-system
		       (let ((coding-system-for-write user-coding-system))
			 (write-file fname))
		     (write-file fname)))))
	      ((eq cmd 'load-file)
	       (and smart (message "Loading file %s..." fname))
	       (load-file fname)
	       (and smart (message "Loading file %s...done" fname)))
	      (t
	       (and smart (message "Reading file %s..." fname))
	       (let ((find-file-hooks find-file-hooks))
		 (if user-coding-system
		     (cond
		      ((fboundp 'set-buffer-file-coding-system)
		       (add-hook
			'find-file-hooks
			(` (lambda ()
			     (if (zerop (buffer-size))
				 (set-buffer-file-coding-system
				  (quote (, user-coding-system))))))))
		      ((fboundp 'set-file-coding-system)
		       (add-hook
			'find-file-hooks
			(` (lambda ()
			     (if (zerop (buffer-size))
				 (set-file-coding-system
				  (quote (, user-coding-system))))))))))
		 (if super-smart-find-second-arg-acceptable-p
		     (funcall cmd fname user-coding-system)
		   (if user-coding-system
		       (let ((coding-system-for-read user-coding-system))
			 (funcall cmd fname))
		     (funcall cmd fname))))
	       (and smart (message "Reading file %s...done" fname))))))))

(defun super-smart-find-file (&optional user-coding-system)
  (interactive "P")
  (super-smart-find-file-internal
   user-coding-system "Find file: " 'find-file 'dired))

(defun super-smart-find-file-other-window (&optional user-coding-system)
  (interactive "P")
  (super-smart-find-file-internal
   user-coding-system "Find file in other window: "
   'find-file-other-window 'dired-other-window))

(defun super-smart-find-insert-file (&optional user-coding-system)
  (interactive "P")
  (super-smart-find-file-internal
   user-coding-system "Insert file: " 'insert-file))

(defun super-smart-find-write-file (&optional user-coding-system)
  (interactive "P")
  (super-smart-find-file-internal
   user-coding-system "Write file: " 'write-file))

(defun super-smart-find-file-other-frame (&optional user-coding-system)
  (interactive "P")
  (super-smart-find-file-internal
   user-coding-system "Find file in other frame: "
   'find-file-other-frame 'dired-other-frame))

(defun super-smart-find-load-file ()
  (interactive)
  (super-smart-find-file-internal nil "Load file: " 'load-file))

(defun super-smart-find-mime-editor/insert-file-internal (file &rest dummies)
  ; Insert a message from a file.
  (mime-editor/insert-file file 'verbose))

(defun super-smart-find-mime-editor/insert-file ()
  (interactive)
  (super-smart-find-file-internal
   nil "Insert file as MIME message: "
   'super-smart-find-mime-editor/insert-file-internal))

(defun super-smart-find-mime-edit-insert-file-internal (file &rest dummies)
  ; Insert a message from a file.
  (mime-edit-insert-file file 'verbose))

(defun super-smart-find-mime-edit-insert-file ()
  (interactive)
  (super-smart-find-file-internal
   nil "Insert file as MIME message: "
   'super-smart-find-mime-edit-insert-file-internal))

;; 塩野さん <jun@fs.fujitsu.co.jp> ご提供。
(defun super-smart-find-file-path-check ()
  "ないディレクトリは、パスから取り除く"
  (let ((path smart-find-file-path)
	(new-path nil))
    (while path
      (if (file-exists-p (concat (car path) "/"))
	  (setq new-path (cons (car path) new-path)))
      (setq path (cdr path)))
    (setq smart-find-file-path (reverse new-path))))

(and super-smart-find-do-file-path-check (super-smart-find-file-path-check))

(provide 'super-smart-find)

(run-hooks 'super-smart-find-load-hook)

; super-smart-find.el ends here
