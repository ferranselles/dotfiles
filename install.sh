#!/bin/bash

#SETUP vim enviroment
mkdir -p ~/.vim/bundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
cp vim/vimrc ~/.vimrc
vim +BundleInstall +qall

#SETUP tmux
su - root -c "easy_install psutil"
git clone git://github.com/zaiste/tmuxified.git ~/.tmuxified
ln -sfn ~/.tmuxified ~/.tmux
ln -sfn ~/.tmuxified/tmux.conf ~/.tmux.conf
ln -sfn ~/.tmuxified/scripts/basic-cpu-and-memory.tmux ~/bin/basic-cpu-and-memory.tmux
