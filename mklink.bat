REM dotfiles link
REM require administrator
RMDIR .emacs.d
DEL .bash_profile
DEL .gitconfig
DEL .inputrc
DEL .mew.el
DEL .minttyrc
DEL .vimrc
MKLINK /D .emacs.d %HOME%\dotfiles\.emacs.d
MKLINK .bash_profile %HOME%\dotfiles\.bash_profile
MKLINK .gitconfig %HOME%\dotfiles\.gitconfig
MKLINK .inputrc %HOME%\dotfiles\.inputrc
MKLINK .mew.el %HOME%\dotfiles\.mew.el
MKLINK .minttyrc %HOME%\dotfiles\.minttyrc
MKLINK .vimrc %HOME%\dotfiles\.vimrc
