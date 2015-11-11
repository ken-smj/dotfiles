#!/bin/sh
echo "C:\Users          /home" >> /etc/fstab
pacman -Syu --noconfirm
pacman -S --noconfirm base
pacman -S --noconfirm base-devel
pacman -S --noconfirm mingw-w64-x86_64
pacman -S --noconfirm git subversion mingw-w64-x86_64-imagemagick mingw-w64-x86_64-ruby lftp mingw-w64-x86_64-ag
gem update --system
gem install gemcutter
gem install ruby_gntp
gem install rubyzip
gem install RubyInline
gem install ocra
