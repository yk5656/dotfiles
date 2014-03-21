#!/bin/bash

ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc

mkdir $HOME/.vim
mkdir $HOME/.vim/colors
cd $HOME/.vim/colors
wget http://www.vim.org/scripts/download_script.php?src_id=9750  -O morokai.vim
wget http://www.vim.org/scripts/download_script.php?src_id=17225 -O jellybeans.vim
wget http://www.vim.org/scripts/download_script.php?src_id=19720 -O hybrid.vim

