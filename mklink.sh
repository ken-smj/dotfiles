#!/bin/sh
cd ~
mklinks=".emacs.d .bash_profile .gitconfig .inputrc .mew.el .minttyrc .vimrc"
for i in $mklinks
do
    echo check $i...
    # if [ -d $i ] ; then
    # 	echo $i is derectory. => abort.
    # 	exit 1
    # fi
    # if [ -h $i ] ; then
    # 	echo $i is symbolic link. => deleted.
    # 	unlink $i
    # fi
    ln -s dotfiles/$i $i
done
exit 0
