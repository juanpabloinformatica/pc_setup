#! /usr/bin/bash
# shellcheck disable=SC2034
USER=$1

##MEAN_PATHS##
DOCUMENTS_PATH="$HOME/Documents"
DOWNLOADS_PATH="$HOME/Downloads"
PICTURES_PATH="$HOME/Pictures"
VIDEOS_PATH="$HOME/Videos"

##DOTFILES##
DOTFILE_HOME_CONFIG="home"
DOTFILE_CONFIG_CONFIG="config"
DOTFILE_PICTURE_CONFIG="pictures"
DOTFILE_GIT=".git"
DOTFILE_PATH="${DOCUMENTS_PATH}/dotfiles"
SYMLINK_CONFIG="$HOME/.config"
SYMLINK_HOME="$HOME"
SYMLINK_PICTURES="$HOME/Pictures"
ALACRITTY_PATH="$DOTFILE_HOME_CONFIG/alacritty/themes"

##FONTS##
FONT_PATH="$HOME/.local/share/fonts"

##BIN_PATHS##
FZF_BIN_PATH="$HOME/Downloads/fzf/bin"
VIM_BIN_PATH="$HOME/Downloads/vim/bin"
NVIM_BIN_PATH="$HOME/Downloads/nvim/bin"

##SCRIPTS##
SCRIPTS_PATH="${DOCUMENTS_PATH}/scripts"
mapfile -t DOWNLOADS_FOLDERS < <(find "$DOWNLOADS_PATH" -mindepth 1 -maxdepth 1 -type d)
mapfile -t VIDEOS_FOLDERS < <(find "$VIDEOS_PATH" -mindepth 1 -maxdepth 1 -type d)

##DOCUMENTS_FOLDERS##
mapfile -t DOCUMENTS_FOLDER < <(find "$HOME/Documents" -mindepth 1 -maxdepth 1 -type d)

##I3_VARIABLES##
WATCHER_SCRIPT="${SCRIPTS_PATH}/watcher.sh"
WATCHER_SCRIPT_PATH="${SCRIPTS_PATH}"
BACKGROUND_IMAGE="${PICTURES_PATH}/samurai.jpg"

##PACKAGES##
ARCH_PACKAGES=("git" "pipewire" "vim" "docker" "zsh" "alacritty" "i3" "tmux" "firefox" "base-devel" "wget" "curl" "zip" "unzip" "stow" "ripgrep" "vlc" "bob" "bluez" "bluez-utils" "feh" "flameshot" "htop" "-vim-git" "valgrind" "lightdm" "xorg-server" "reflector" "xdg-user-dirs"
)
# DEBIAN_PACKAGES=()
