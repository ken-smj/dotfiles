#!/bin/sh

pacman -Syu
pacman -S base
pacman -S base-devel
pacman -S mingw-w64-x86_64
pacman -S git subversion mingw-w64-x86_64-imagemagick mingw-w64-x86_64-ruby mingw-w64-x86_64-pkgconf
