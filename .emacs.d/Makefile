EMACS = emacs

all:
	${EMACS} -batch --eval '(byte-recompile-directory "~/.emacs.d/conf/" 0)'
	${EMACS} -batch --eval '(byte-recompile-directory "~/.emacs.d/elisp/" 0)'
	${EMACS} -batch --eval '(byte-recompile-directory "~/.emacs.d/plugin/" 0)'
