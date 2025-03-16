# Description

## program flow

- init -> installEssentialPackages -> getConfigFiles -> setConfig 
                                                          -> setFont
                                                          -> setZsh
                                                          -> setAlacritty


## Description of each function

### init

This will be the entry point of the program.

### installEssentialPackages

This is where the packages that were not install with the archinstall
are installed. Follow installations listed in **1** [things to install](./steps.md)

### getConfigFiles
```
dotfiles/
  |__home/
    |__.gitconfig
    |__.zshrc
    |__.tmux.conf
  |__config/
    |__nvim/
    |__init.lua
    |__lazy-lock.json
    |__README.md
    |__lua/
      |__config/
      |__lua/
    |__vim/
      |__vimrc
    |__alacritty/
      |__alacritty.toml
    |__i3/
      |__config
  |__steps.md
```
- Clone dotfiles folder --> git clone git@github.com:juanpabloinformatica/dotfiles.git ~/Documents/
- Follow the instructions in the ~/Documents/dotfiles/README.md

### setConfig

#### setFont

- Create the folder ~/.local/share/fonts
- Inside there save all the fonts gotten from 
  [link to get fonts](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Iosevka.zip)
  --> wget --directory-prefix ~/.local/share/fonts 
      \https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Iosevka.zip
- Ones Executed that I need to unzip the folder put everything in ~/.local/share/fonts
- unzip ~/.local/share/fonts/Iosevka.zip
- rm -rf ~/.local/share/fonts/Iosevka.zip

#### setZsh

- doubt?? As I am using zsh it will work???
- Install zsh in the machine
- sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
- Once this is done, follow the process

### setAlacritty
- Get themes
- <!--We use Alacritty's default Linux config directory as our storage location here.-->
  mkdir -p ~/.config/alacritty/themes
  git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

### Missing

- Generate ssh key and add pub to github.
