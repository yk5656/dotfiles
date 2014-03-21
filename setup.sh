#!/bin/bash

DOT_FILES=( .zshrc .tmux.conf .vimrc )

for file in ${DOT_FILES[@]}
do
  ln -s $HOME/dotfiles/$file $HOME/$file
done

mkdir $HOME/.vim
mkdir $HOME/.vim/colors
cd $HOME/.vim/colors
wget http://www.vim.org/scripts/download_script.php?src_id=9750
wget http://www.vim.org/scripts/download_script.php?src_id=17225
wget http://www.vim.org/scripts/download_script.php?src_id=19720

