#!/bin/bash

#SETUP vim enviroment
mkdir -p ~/.vim/bundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
cp vim/vimrc ~/.vimrc
vim +BundleInstall +qall
