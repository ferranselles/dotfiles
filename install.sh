#!/bin/bash

#SETUP vim enviroment
mkdir -p ~/.vim/bundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
cp vim/vimrc ~/.vimrc
vim +BundleInstall +qall

#SETUP tmux
#if centos62 we need to install easy_install for python
#rpm -Uhv http://ftp.rediris.es/mirror/fedora-epel/6/i386/epel-release-6-5.noarch.rpm
#yum install python-devel python-pip

su - root -c "easy_install psutil"
git clone git://github.com/zaiste/tmuxified.git ~/.tmuxified
ln -sfn ~/.tmuxified ~/.tmux
ln -sfn ~/.tmuxified/tmux.conf ~/.tmux.conf
mkdir -p ~/bin
ln -sfn ~/.tmuxified/scripts/basic-cpu-and-memory.tmux ~/bin/basic-cpu-and-memory.tmux
