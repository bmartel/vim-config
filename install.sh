#!/bin/sh
echo "Attempting to setup vim/neovim configs"

VIM_BIN=$(command -v vim)
NEOVIM_BIN=$(command -v nvim)


# Vim
if [ -e "$VIM_BIN" ]; then
  echo "Vim detected"

  if [ -d "$PWD/vim" ]; then
    echo "=== Local Vim folder exists"
  else
    echo "=== Creating local Vim folder"
    mkdir "$PWD/vim"
  fi

  if [ -e "$HOME/.vimrc" ] || [ -e "$HOME/.vim" ]; then
    today=$(date +%F)
    echo "=== Vim files detected, backing old ones up if not symlinked"

    if [ -L "$HOME/.vimrc" ]; then
      echo "... Ignoring symlinked Vim config"
    else
      if [ -e "$HOME/.vimrc" ]; then
        echo "... Backing up $HOME/.vimrc to $HOME/vimrc_$today"
        mv "$HOME/.vimrc" "$HOME/vimrc_$today"
      fi
    fi

    if [ -L "$HOME/.vim" ]; then
      echo "... Ignoring symlinked Vim directory"
    else
      if [ -d "$HOME/.vim" ]; then
        echo "... Backing up $HOME/.vim to $HOME/vim_$today"
        rm -rf "$HOME/vim_$today"
        mkdir "$HOME/vim_$today"
        cp -R "$HOME/.vim" "$HOME/vim_$today/"
        rm -rf "$HOME/.vim"
      fi
    fi
  else
    echo "=== Installing Vim config files"
  fi

  echo "=== Linking Vim files"
  if [ -L "$HOME/.vimrc" ]; then
    echo "... Ignoring symlinked Vim config"
  else
    ln -s "$PWD/vimrc" "$HOME/.vimrc"
  fi

  if [ -L "$HOME/.vim" ]; then
    echo "... Ignoring symlinked Vim directory"
  else
    ln -s "$PWD/vim" "$HOME/.vim"
  fi

  if [ -e "$HOME/.vim/autoload/plug.vim" ]; then
    echo "... VimPlug already installed and autoloaded for Vim"
  else
    echo "=== Installing VimPlug for Vim"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  echo "=== Installing Vim plugins"
  vim +PlugInstall! +qall
fi

# NeoVim
if [ -e "$NEOVIM_BIN" ]; then
  echo "NeoVim detected"

  if [ -d "$PWD/nvim" ]; then
    echo "=== Local NeoVim folder exists"
  else
    echo "=== Creating local NeoVim folder"
    mkdir "$PWD/nvim"
  fi

  if [ -e "$HOME/.config/nvim" ]; then
    today=$(date +%F)
    echo "=== NeoVim files detected, backing old ones up if not symlinked"

    if [ -L "$HOME/.config/nvim" ]; then
      echo "... Ignoring symlinked NeoVim directory"
    else
      if [ -d "$HOME/.config/nvim" ]; then
        echo "... Backing up $HOME/.config/nvim to $HOME/neovim_$today"
        rm -rf "$HOME/neovim_$today"
        mkdir "$HOME/neovim_$today"
        cp -R "$HOME/.config/nvim" "$HOME/neovim_$today/"
        rm -rf "$HOME/.config/nvim"
      fi
    fi
  else
    echo "=== Installing NeoVim config files"
  fi

  echo "=== Linking NeoVim files"
  if [ -L "$HOME/.config/nvim" ]; then
    echo "... Ignoring symlinked NeoVim directory"
  else
    ln -s "$PWD/nvim" "$HOME/.config/nvim"
  fi

  if [ -e "$HOME/.config/nvim/autoload/plug.vim" ]; then
    echo "... VimPlug already installed and autoloaded for NeoVim"
  else
    echo "=== Installing VimPlug for NeoVim"
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  echo "=== Installing NeoVim plugins"
  nvim +PlugInstall! +qall

  echo "=== Done"
fi
