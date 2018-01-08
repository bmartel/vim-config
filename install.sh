#!/bin/sh
set -e

if [ -e $HOME/.vimrc ] || [ -e $HOME/.vim ]; then
  today=$(date +%F)
  echo "=== Vim files detected, backing old ones up if not symlinked"

  if [ -L $HOME/.vimrc ]; then
    echo "... Ignoring symlinked vimrc"
  else
    if [ -e $HOME/.vimrc ]; then
      mv $HOME/.vimrc $HOME/vimrc_$today
    fi
  fi

  if [ -L $HOME/.vim ]; then
    echo "... Ignoring symlinked vim folder"
  else
    if [ -L $HOME/.vim ]; then
      mkdir $HOME/vim_$today
      cp -R $HOME/.vim $HOME/vim_$today/
      rm -rf $HOME/.vim
    fi
  fi
fi

echo "=== Installing Vim config files"

if [ -e $HOME/.vim/bundle/Vundle.vim ]; then
  echo "=== Vundle already found...skipping"
else
  echo "=== Checking out Vundle"
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

echo "=== Linking vim directories"
if [ -L $HOME/.vimrc ]; then
    echo "...Ignoring symlinked vimrc"
else
  ln -s $PWD/vimrc $HOME/.vimrc
fi

if [ -L $HOME/.vim ]; then
    echo "... Ignoring symlinked vim folder"
else
  ln -s $PWD $HOME/.vim
fi

echo "=== Vundling"
vim +PluginInstall +qall

echo "=== Done"
