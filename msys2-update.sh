#!/bin/sh
# msys2 setup script.
# auther ken@smj.to

home="D:\\home"
modules="base base-devel mingw-w64-x86_64 mingw-w64-x86_64-toolchain development git subversion \
       mingw-w64-x86_64-imagemagick mingw-w64-x86_64-ruby lftp mingw-w64-x86_64-ag mingw-w64-x86_64-libxml2 mingw-w64-x86_64-librsvg \
       mingw-w64-x86_64-python2-setuptools mingw-w64-x86_64-python2-pip"
gems="gemcutter ruby_gntp rubyzip RubyInline ocra oga"

echo "This is msys2 setup scripts. version 2015.12.03."
echo "Do you want to initialize? [yes / no]"
read answer
case "$answer" in
	yes)
	    pacman -Syu --noconfirm
	    for i in $modules; do
		pacman -S --noconfirm $i
	    done
	    ;;
	*)
	    echo "initializing was canceled."
esac
echo "checking mount $home on /home ..."
mount=`cat /etc/fstab | grep /home | sed -e 's/^\([^#]\+\)\s\+\/home/\1/'`
if [ -n "$mount" ]; then
    echo "mount $mount on /home."
else
    echo "/home dose not set. do you wont set $home on /home ? [yes / no]"
    read answer
    case "$answer" in
	yes)
	    echo "$home          /home" >> /etc/fstab
	    ;;
	*)
	    ;;
    esac
fi
echo "Do you want to initialize Ruby gems? [yes / no]"
read answer
case "$answer" in
	yes)
	    gem update --system
	    for i in $gems; do
		gem install $i
	    done
	    ;;
esac
echo "Finished."
