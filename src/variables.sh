#! /usr/bin/bash
# shellcheck disable=SC2034
#
USER=$1

DOTFILE_HOME_CONFIG="home"
DOTFILE_CONFIG_CONFIG="config"
DOTFILE_PICTURE_CONFIG="pictures"
DOTFILE_GIT=".git"

# this will be $HOME/Documents/dotfiles
DOTFILE_PATH="$HOME/Documents/dotfiles"
# this will be $HOME/.config/
SYMLINK_CONFIG="$HOME/.config"
# this will be $HOME/
SYMLINK_HOME="$HOME"
# this will be $HOME/Pictures
SYMLINK_PICTURES="$HOME/Pictures"

#Font
FONT_PATH="$HOME/.local/share/fonts"
#Alacritty
ALACRITTY_PATH="$DOTFILE_HOME_CONFIG/alacritty/themes"

#PATH
FZF_BIN_PATH="$HOME/Downloads/fzf/bin"
VIM_BIN_PATH="$HOME/Downloads/vim/bin"
NVIM_BIN_PATH="$HOME/Downloads/nvim/bin"
