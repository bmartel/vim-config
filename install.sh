#!/bin/sh
set -e
shopt -s dotglob nullglob

if [ -e $HOME/.vimrc ] || [ -e $HOME/.vim ]; then
  today=$(date +%F)
  echo "=== Vim files detected, backing old ones up if not symlinked"

  if [ -L $HOME/.vimrc ]; then
    echo "... Ignoring symlinked Vim config"
  else
    if [ -e $HOME/.vimrc ]; then
      echo "... Backing up $HOME/.vimrc to $HOME/vimrc_$today"
      mv $HOME/.vimrc $HOME/vimrc_$today
    fi
  fi

  if [ -L $HOME/.vim ]; then
    echo "... Ignoring symlinked Vim directory"
  else
    if [ -d $HOME/.vim ]; then
      echo "... Backing up $HOME/.vim to $HOME/vim_$today"
      rm -rf $HOME/vim_$today
      mkdir $HOME/vim_$today
      cp -R $HOME/.vim $HOME/vim_$today/
      rm -rf $HOME/.vim
    fi
  fi
else
  echo "=== Installing Vim config files"
fi

echo "=== Linking Vim files"
if [ -L $HOME/.vimrc ]; then
  echo "... Ignoring symlinked Vim config"
else
  ln -s $PWD/vimrc $HOME/.vimrc
fi

if [ -L $HOME/.vim ]; then
  echo "... Ignoring symlinked Vim directory"
else
  ln -s $PWD/vim $HOME/.vim
fi

if [ -e $HOME/.vim/bundle/Vundle.vim ]; then
  echo "... Vundle already installed"
else
  echo "=== Checking out Vundle"
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

echo "=== Installing plugins"
vim +PluginInstall +qall

echo "=== Done"
