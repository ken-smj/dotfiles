#!/bin/sh

pacman -Syu --noconfirm
pacman -S --noconfirm base
pacman -S --noconfirm base-devel
pacman -S --noconfirm mingw-w64-x86_64
pacman -S --noconfirm git subversion mingw-w64-x86_64-imagemagick mingw-w64-x86_64-ruby mingw-w64-x86_64-pkgconf lftp
echo "C:\Users          /home" >> /etc/fstab
gem update --system
gem install gemcutter
gem install ruby_gntp
gem install rubyzip
gem install RubyInline
gem install ocra
