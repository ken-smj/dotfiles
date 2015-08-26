# .bashrc

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
fi

##############
### Basics ###
##############

# Don't wait for job termination notification
set -o notify

# Enables UTF-8 in Putty.
# See http://www.earth.li/~huggie/blog/tech/mobile/putty-utf-8-trick.html
echo -ne '\e%G\e[?47h\e%G\e[?47l'
export LS_COLORS="no=00:fi=00:di=01;36:ln=01;34"

#source /usr/share/git/git-prompt.sh
#export TERM=msys
#PS1='[\[\033[32m\]\u@\h\[\033[00m\]:\[\033[33m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]]\n\$ '
PS1='[\[\033[32m\]\u@\h\[\033[00m\]:\[\033[33m\]\w\[\033[31m\]\[\033[00m\]]\n\$ '

export LINES=45
export COLS=125
############
### PATH ###
############

# Remove '/c/*' from PATH if running under Msys to avoid possible 
# interference from programs already installed on system. Removal 
# with awk is copied from http://stackoverflow.com/a/370192.
if [ $(uname -o) == 'Msys' ]; then
    export PATH=`echo ${PATH} | awk -v RS=: -v ORS=: '/c\// {next} {print}' | sed 's/:*$//'`
fi

export PATH=${PATH}:${emacs_dir}/bin:${HOME}/.emacs.d/libexec/w32:${HOME}/.emacs.d/libexec/w32/glo62Bwb/bin:/c/Program\ Files/Java/jre7/bin

export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:/usr/local/lib/pkgconfig

export LESSHISTFILE=-

###############
### Aliases ###
###############
alias more='less -r'
#alias rm='rm -i'
alias ls='ls -aF --color=auto'
alias emacs='emacs -nw'
