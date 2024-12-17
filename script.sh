#! /usr/bin/bash
function init(){
  setPathStartingPoint
  installEssentialPackages
  getConfigFiles
  setConfigFiles
}
function setPathStartingPoint(){
  cd $HOME
}
function installEssentialPackages(){
echo -e "\n"
echo -e "STARTING WITH THIS PART OF THE SETUP"
# installing zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
# installing pyenv
# doubt?? As I am using zsh it will work???
curl https://pyenv.run | bash
exec "$SHELL" # Or just restart your terminal
# Once the pyenv is installed settup python
echo "------  pyenv ------"
pyenv install-latest
pythonVersion=$(cat $HOME/.pyenv/version)
pyenv global $pythonVersion
# Installing nvm ==> package manager for node
echo "------  nvm ------"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
exec "$SHELL" # Or just restart your terminal
nvm install --lts
# refresh pacman
sudo pacman -Syu 
# install archlinux
echo "------ Installing vlc ------"
sudo pacman -S vlc
# install yay
echo "------ yay ------"
git clone https://aur.archlinux.org/yay.git $HOME/Downloads
cd $HOME/Downloads/yay
makepkg -si
exec "$SHELL" # Or just restart your terminal
cd $HOME
# installing simple Screen recorder
yay -S simplescreenrecorder
# installing bluez
# installing bluez utils for bluetoothctl
# installing feh for the background
# Installing flamshot for screenshots
# Installing htop for better top
# Installing spotify for music
# Installing valgrind for memory leaks
# Installing vagrant for IaC virtual machines
sudo pacman -S bluez bluez-utils feh flameshot htop spotify-launcher valgrind
sudo pacman -S virtualbox
sudo gpasswd -a $USER vboxusers
sudo pacman -S linux-headers
sudo modprobe vboxdrv
exec "$SHELL"
# installing reflector for handling mirrors
sudo pacman -S reflector
sudo systemctl enable reflector.timer
sudo pacman -S xdg-user-dirs
exec "$SHELL"
xdg-user-dirs-update
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
  git clone git@github.com:juanpabloinformatica/dotfiles.git $HOME/Documents/
stow --target=$HOME $HOME/Documents/home
stow --target=$HOME/.config $HOME/Documents/config
stow --target=$HOME/Pictures $HOME/Documents/Pictures
}

function setConfigFiles(){
  setFont
  setZsh
  setAlacritty
}
function setFont(){
  echo -e "\nINSTALLING Iosevka FONT"
  mkdir -p $HOME/.local/share/fonts
 wget --directory-prefix $HOME/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Iosevka.zip 
 # unzip $HOME/.local/share/fonts/Iosevka.zip -d $HOME/.local/share/fonts/Iosevka.zip
 rm -rf Iosevka.zip
}
function setZsh(){
  echo -e "\nINSTALLING ZSH HANDLER"
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
}
function setAlacritty(){
  echo -e "\n GETTING Alacritty THEMES"
  git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
}

# here it starts
init

