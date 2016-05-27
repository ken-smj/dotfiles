;;; super-smart-find.el --- an extension of smart-find.el
;; Copyright (c) 1995-2000 Katsumi Yamaoka <yamaoka@jpl.org>
;; (smart-find.el: Copyright (c) 1990 by Wayne Mesard.)

;; [2001/02/01] hira (khi@users.sourceforge.jp) �������¤�ǡ�
;; ��¤�� smart-find.el �ˤ��碌�ơ�������¤��(��¤�ս�ϡ�hira�פ򸡺�)

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
;;     �������˺�������ե������ find-file �����Ȥ��⡢coding system
;;       �����ꤵ��Ƥ����顢���������ꤹ��褦�ˤ�����
;;
;; v1.85  2000.01.31
;;     ���ؿ� find-coding-system �ΰ����� symbol �ʳ����ͤ�Ϳ���ʤ���
;;       ���ˤ�����XEmacs 21.2.27+ �к���
;;
;; v1.84    99.04.07
;;     �����Ǥ� visit ���Ƥ��� file �� buffer �ˡ�coding-system �����
;;       ����Ʊ�� file �� insert ���褦�Ȥ����Ȥ��˵�����Х�������
;;
;; v1.83    99.02.02
;;     �����Ǥ� visit ���Ƥ��� file �Ǥ� file �� modtime ���������ä�
;;       �� user-coding-system ���䤦��
;;
;; v1.82    99.01.22
;;     �����Ǥ� visit ���Ƥ��� file ���Ф��Ƥ� user-coding-system ��
;;       ���ʤ��褦�ˤ�����
;;
;; v1.81    98.12.17
;;     ��super-smart-find-file-other-frame �� arg ��̵�뤹��Х���
;;       ��������
;;
;; v1.80    98.06.15
;;     ���Ƥ����ܤ���Τ���Ŧ�ˤ�ꡢXEmacs �Ǻǽ�Υ����� self-insert
;;       command �Ȥ���ǧ������ʤ��Х�����������
;;
;; v1.79    98.06.12
;;     �����ܤ��� <czkmt@remus.dti.ne.jp> �Τ���Ŧ�ˤ�ꡢXEmacs ��
;;       [backspace] �� C-h ���̤Υ����Ȥ��ư����褦�ˤ�����
;;
;; v1.78    98.04.10
;;     ���ե�����̾�����ϻ��� cursor �� minibuffer �˰ܤ��Τ�˺��Ƥ�
;;       ���Τ�ľ������(����⾮�ؤ���Τ���Ŧ)
;;
;; v1.77    98.04.10
;;     ��XEmacs �ʳ��� Emacsen �ˤ����ơ�lookup-key() ���֤� integer
;;       ��̵�뤹��褦�ˤ�����
;;
;; v1.76    98.04.10
;;     ��enbug �˼��� enbug ������(^^;;)
;;
;; v1.75    98.04.10
;;     ��XEmacs �Ǻǽ�� event key �ǵ��륨�顼�����(enbug ����)
;;
;; v1.74    98.04.09
;;     ��Mule 2.3 �� XEmacs �Ǻǽ�� M-p �ʤɤ� event �ǵ��륨�顼��
;;       ����
;;
;; v1.73    98.04.07
;;     ��Emacs 20.2 �Ǻǽ�� M-p �ʤɤ� event �ǵ��륨�顼�����
;;       (���ؤ��� <kose@wizard.tamra.co.jp> �Τ���Ŧ�ˤ��)
;;
;; v1.72    97.12.08
;;     ��XEmacs �Ǻǽ�� C-g ��̵�뤵��Ƥ��ޤ��Х�������
;;
;; v1.71    97.07.24
;;     ��find-file �ʤɤ��裲���� USER-CODING-SYSTEM ������դ��뤫��
;;       ������Ƚ�̤� universal-coding-system-argument() ��̵ͭ�ǹԤ�
;;       �褦�ˤ�����
;;
;; v1.70    97.07.18
;;     ��Emacs 20.0.9 ���б����裲���� USER-CODING-SYSTEM ������դ�
;;       �ʤ� find-file, find-file-other-frame, find-file-other-window,
;;       insert-file, write-file �Ǥ�Ȥ���褦�ˤ�����
;;
;; v1.63    97.04.28
;;     ��command-history �˼¥��ޥ�� (super-smart-find-file -> find-file)
;;       ����Ͽ��
;;     ��SEMI-0.75 �� mime-edit-insert-file ���б���
;;
;; v1.62    97.02.19
;;     ��XEmacs 20.1 ���б���
;;
;; v1.61    96.12.25
;;     ��tm7.99 �� mime-editor/insert-file ���б���
;;       tm-edit.el �β�¤�����ס�
;;
;; (�ֳ�)   96.12.24
;;     ��tm7.98 �� mime-editor/insert-file ���б���
;;       tm-edit.el �β�¤��ɬ�ס�
;;
;; v1.60    96.12.10
;;     ��Coding system �λ�����б���(C-u C-x C-f)
;;     ��tm7.95 �� mime-editor/insert-file ���б���
;;
;; v1.50    96.07.30
;;     ��-nw �� Sony NEWS �� key pad ���б���
;;     ��tm7.74 �� mime-editor/insert-file ���б���
;;       (ñ���Ѥ�äƤ��ʤ����Ȥ��ǧ�������� ^^;;)
;;
;; v1.40    96.03.15
;;     ������� <jun@fs.fujitsu.co.jp> �Τ��󶡤ˤ�ꡢ¸�ߤ��ʤ�
;;       �ǥ��쥯�ȥ�� smart-find-file-path ����������ؿ���
;;       super-smart-find-file-path-check ���ɲá�
;;       �ޤ����ѿ� super-smart-find-do-file-path-check �� Non-nil ��
;;       ���Ƥ����ȡ�super-smart-find �� load �����Ȥ��˼¹Ԥ��롣
;;     ��file-name-history �� real-name ����Ͽ�� (19.29 �ʾ��ͭ��)
;;     ��tm7.48 �� mime-editor/insert-file ���б���
;;       (ñ�˥��ԡ��������� ^^;;)
;;
;; v1.31    96.01.05
;;     ��tm7.39 �� mime-editor/insert-file ���б���
;;
;; v1.30    95.10.30
;;     ��tm �� mime-editor/insert-file ���б���
;;
;; v1.20    95.06.07
;;     �����״֤��� <KHB10110@niftyserve.or.jp> �Τ���Ŧ�ˤ�ꡢ
;;       �ѿ� super-smart-find-self-insert-command-list ���ߤ���
;;       nil ���ä��� apropos �� *-self-insert-command ��ư��С�
;;       ���Τ� *-self-insert-command �Υꥹ�Ȥ��ä����ˤϤ����
;;       ���Ȥ���褦���ѹ���
;;     ������ minibuffer-setup-hook ���ͤ�����ʤ��褦���ѹ���
;;
;; v1.10    95.05.12
;;     ������� <jun@fs.fujitsu.co.jp> �Τ�����ˤ�ꡢ
;;       canna-self-insert-command ���ɲá�
;;     ���ؿ� super-smart-find-load-file ���ɲá�
;;     ���ؿ� super-smart-find-mime-insert-file ���ɲá�
;;       (tm-ML �����ʤ�����Ƥ�ԤȤ��Ƥϡ����������Ȥ��ͤ� :-)
;;
;; v1.00    95.05.09

;;; DESCRIPTION
;;
;;     �������ޤ����� super- ��̾�򴧤��뤳�Υץ����ϡ�Mule 2.x,
;;     Emacs 20.x �ޤ��� XEmacs 20.x ��ǡ����餫�������ꤵ�줿ʣ����
;;     �ǥ��쥯�ȥ�β���¸�ߤ���ե�����򡢥ǥ��쥯�ȥ�̾�λ����ɬ
;;     �פȤ����� completion ��ǽ��ʻ�Ѥ����ɤ߹��ळ�Ȥ��Ǥ���褦��
;;     ���뤿��Ρ�find-file �Ϥδؿ��� smart-find �ε�ǽ���ղä��뤿
;;     ��Υץ����Ǥ���
;;     �����Ȥ�����ˤ� smart-find.el ��ɬ�פǤ���
;;
;;     Emacs ver.18 �Ǥ�ʤ���ʤ�˻Ȥ��ޤ���������������꤬����
;;     �ޤ���

;;; HOW TO USE
;;
;;     ���Υե������ smart-find.el �� load-path �Υǥ��쥯�ȥ�β���
;;     ���ԡ����� byte-compile-file ���Ʋ������������� ~/.emacs ��
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
;;     �Ƚ񤤤Ƥ������Ȥˤ�äơ�find-file, file-other-window, �����
;;     find-file-other-frame �ʤɡ����줾��Υ��ޥ�ɤ����̤�Ȥ���
;;     �Ȥ��Ǥ��뤳�Ȥ˲ä��ơ��ǽ�� `=' �򥿥��פ��뤳�Ȥˤ�ä�
;;     smart-find �ε�ǽ���ڤ괹���ޤ���(Emacs ver.18 �Ǥ� add-hook
;;     ��������뤫���̤���ˡ�����ꤷ�Ʋ�������)
;;
;;     tm �ǤϤʤ� SEMI ��ȤäƤ�����Ϥ��Τ褦�˽񤯤Ȥ��ޤ��Ԥ�
;;     �ޤ���
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
;;     smart-find �ǥե�����򥵡�������ѥ��� smart-find-file-path
;;     �Ȥ����ѿ�������Ǥ��ޤ��Τǡ����ʤ������ˤ˥�����������ե���
;;     ����֤��Ƥ���ǥ��쥯�ȥ�� ~/.emacs �����
;
;(setq smart-find-file-path
;      '(
;	"~"
;	"~/elisp"
;	"/usr/local/mule/site-lisp"
;	"/usr/local/mule/lisp"
;	))
;
;;     �ʤɤȽ񤤤Ƥ������ɤ��Ǥ��礦��
;;
;;     ���Υץ����Ϻǽ�˲����줿������������ self-insert-command
;;     ���ɤ�����Ƚ��򤷤Ƥ��ޤ����ǥե���ȤǤ� apropos ��Ȥä�¸
;;     �ߤ��뤹�٤Ƥ� self-insert-command �򸡽Ф���褦�ˤʤäƤ���
;;     ���������餫����狼�äƤ�����ˤ�
;
;(setq super-smart-find-self-insert-command-list
;      '(canna-self-insert-command
;	egg-self-insert-command
;	self-insert-command
;	tcode-self-insert-command-maybe))
;
;;     �ʤɤ����ꤷ�Ƥ������Ȥˤ�äơ�apropos ��¹Ԥ��뤿����٤��
;;     ���򤹤뤳�Ȥ��Ǥ��ޤ���

(defvar super-smart-find-switch-strings (list "=")
  "* smart-find-file �ε�ǽ���ڤ괹���뤿���ʸ�����ޤ���ʸ���Υꥹ�ȡ�")

(defvar super-smart-find-self-insert-command-list nil
  "* ���Τ� self-insert-command �Υꥹ�ȡ�nil �Ǥ� apropos �Ǹ�������")

(defvar super-smart-find-do-file-path-check t
  "* Non-nil �� super-smart-find �� load ����¸�ߤ��ʤ��ǥ��쥯�ȥ������
���ΤȤ� smart-find-file-path ���ͤ��Ѳ����롣")

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
	  ;; - smart-find �θƤӽФ��˥�󥯥å����
	  ;; - ¸�ߤ��ʤ��ե�����̾�ʤ顢��������
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

;; ����� <jun@fs.fujitsu.co.jp> ���󶡡�
(defun super-smart-find-file-path-check ()
  "�ʤ��ǥ��쥯�ȥ�ϡ��ѥ����������"
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
