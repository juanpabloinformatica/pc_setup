#! /usr/bin/bash
function init(){
  setPathStartingPoint &&\
  setPreInstallations &&\
  installEssentialPackages &&\
  getConfigFiles &&\
  setConfigFiles 
}
function setPreInstallations(){
  pacman -Sy archlinux-keyring && pacman -Su
}
function setPathStartingPoint(){
  cd $HOME
}
function installEssentialPackages(){
echo -e "\n"
echo -e "STARTING WITH THIS PART OF THE SETUP"
sudo pacman -S vim pipewire docker git zsh alacritty i3 tmux firefox base-devel wget curl zip unzip stow ripgrep python nodejs vlc &&\
git clone https://aur.archlinux.org/yay.git $HOME/Downloads &&\
cd $HOME/Downloads/yay &&\
makepkg -si &&\
yay -S simplescreenrecorder &&\
sudo pacman -S  git zsh alacritty i3 i3bar i3-msg i3lock i3-input i3blocks i3status i3status i3-nagbar i3-dump-log i3-save-tree i3-config-wizard i3-dmenu-desktop i3-sensible-pager i3-sensible-editor i3-sensible-terminal i3-migrate-config-to-v4 tmux firefox base-devel wget curl zip unzip stow ripgrep&&\
sudo pacman -S bluez bluez-utils feh flameshot htop spotify-launcher valgrind &&\
sudo pacman -S virtualbox &&\
sudo gpasswd -a $USER vboxusers &&\
sudo pacman -S linux-headers &&\
sudo modprobe vboxdrv &&\
sudo pacman -S docker && sudo systemctl enable docker.service && sudo usermod -aG docker $USER && newgrp docker &&\
# installing reflector for handling mirrors
sudo pacman -S reflector &&\
sudo systemctl enable reflector.timer &&\
sudo pacman -S xdg-user-dirs &&\
exec "$SHELL"&&\
xdg-user-dirs-update &&\
echo "FINISHING WITH THIS PART OF THE SETUP"
echo -e "\n"
}

function getConfigFiles(){
  if ! command -v stow 2>&1 >/dev/null
  then
    sudo pacman -S stow
  fi
  if ! command -v git 2>&1 >/dev/null
  then
    sudo pacman -S git
  fi
  git clone git@github.com:juanpabloinformatica/dotfiles.git $HOME/Documents/ &&\
stow --target=$HOME $HOME/Documents/home &&\
stow --target=$HOME/.config $HOME/Documents/config &&\
stow --target=$HOME/Pictures $HOME/Documents/Pictures
}

function setConfigFiles(){
  setFont &&\
  setAlacritty &&\
  setZsh 
}
function setFont(){
  echo -e "\nINSTALLING Iosevka FONT"
  mkdir -p $HOME/.local/share/fonts &&\
 wget --directory-prefix $HOME/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Iosevka.zip &&\
  unzip $HOME/.local/share/fonts/Iosevka.zip -d $HOME/.local/share/fonts/Iosevka.zip &&\
 rm -rf Iosevka.zip
}
function setAlacritty(){
  echo -e "\n GETTING Alacritty THEMES"
  git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
}
function setZsh(){
  echo -e "\nINSTALLING ZSH HANDLER" &&\
  sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" 
}

# here it starts
init

