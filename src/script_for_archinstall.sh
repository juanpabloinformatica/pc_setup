#! /usr/bin/bash
source ./variables.sh
source ./utilities.sh
source ./script_dotfiles.sh

# first sudo pacman -Syu
# For this git needs to be installed
# function ()
function init() {
    # setupNvimAndVim &&
    setupXdgDirectories &&
        # user_sudo_nopasswd &&
        setImportantPrograms &&
        setConfigFiles &&
        initDotfiles &&
        installationFromSourceToPath
}
function installationFromSourceToPath() {
    append_path FZF_BIN_PATH
    append_path VIM_BIN_PATH
    append_path NVIM_BIN_PATH
}

function setImportantPrograms() {
    preparingSetting &&
        setupReflector &&
        setupDocker &&
        setupFzf &&
        setupPyenv &&
        setupNvm
    # setupZsh
}
function preparingSetting() {
    sudo pacman -S zsh wget curl && chsh -s /usr/bin/zsh

}
function setupFzf() {
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/Downloads/fzf"
    "$HOME/Downloads/fzf/install"
}
function setupXdgDirectories() {
    if ! command -v xdg-user-dirs-update 2>&1 >/dev/null; then
        sudo pacman -S xdg-user-dirs
    fi
    super_user_execute "xdg-user-dirs-update"
}
function setupReflector() {
    if ! command -v reflector 2>&1 >/dev/null; then
        sudo pacman -S reflector
    fi
    sudo systemctl enable reflector.timer
}
function setupDocker() {

    if ! command -v docker 2>&1 >/dev/null; then
        sudo pacman -S docker
    fi
    sudo usermod -aG docker "$USER"
}
function setupZsh() {
    echo -e "\nINSTALLING ZSH HANDLER" &&
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}
function setupPyenv() {
    curl https://pyenv.run | bash &&
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >>~/.zshrc
    echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >>~/.zshrc
    echo 'eval "$(pyenv init -)"' >>~/.zshrc
}
function setupNvm() {
      curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
}

function setConfigFiles() {
    setFont &
    setAlacritty
}
function setFont() {
    echo -e "\nINSTALLING Iosevka FONT"
    mkdir -p "$FONT_PATH" &&
        wget --directory-prefix "$FONT_PATH" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Iosevka.zip &&
        unzip "$FONT_PATH/Iosevka.zip" -d "$FONT_PATH" &&
        rm -rf "$FONT_PATH/Iosevka.zip"
}
function setAlacritty() {
    echo -e "\n GETTING Alacritty THEMES"
    git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
}

# here it starts
init
