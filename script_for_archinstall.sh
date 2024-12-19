#! /usr/bin/bash
function init(){
  setImportantPrograms &&\
  getConfigFiles &&\
  setConfigFiles 
}
function setImportantPrograms(){
    setupXdgDirectories&&\
    setupReflector &&\
    setupDocker &&\
    setupZsh &&\
    setupPyenv &&\
    setupNvm &&\
}
function setupXdgDirectories(){
  if ! command -f xdg-user-dirs 2>&1 > /dev/null
  then 
    sudo pacman -S xdg-user-dirs
  fi
  xdg-user-dirs-update 
}
function setupReflector(){
  if ! command -v reflector 2>&1 >/dev/null
  then
    sudo pacman -S reflector
  fi
  sudo systemctl enable reflector.timer
}
function setupDocker(){
  
  if ! command -v docker 2>&1 >/dev/null
  then
    sudo pacman -S docker
  fi
sudo systemctl enable docker.service && sudo usermod -aG docker $USER && newgrp docker
}
function setZsh(){
  echo -e "\nINSTALLING ZSH HANDLER" &&\
  sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" &&\
}
function setupPyenv(){
  curl https://pyenv.run | bash &&\
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
  echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
  echo 'eval "$(pyenv init -)"' >> ~/.zshrc
}
function setupNvm(){
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
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
  stow --target=$HOME/Pictures $HOME/Documents/Pictures
  stow --target=$HOME/.config $HOME/Documents/config &&\
}

function setConfigFiles(){
  setFont &&\
  setAlacritty &&\
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

# here it starts
init

