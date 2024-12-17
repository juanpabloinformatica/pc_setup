# Description

## program flow

- init -> installEssentialPackages -> setFont -> setConfigFiles

## Description of each function

### init

This will be the entry point of the program.

### installEssentialPackages

This is where the packages that were not install with the archinstall
are installed. Follow installations listed in **1** [things to install](./steps.md)

### setFont

- Create the folder ~/.local/share/fonts
- Inside there save all the fonts gotten from [link to get fonts](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Iosevka.zip) --> wget --directory-prefix ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Iosevka.zip
- Ones Executed that I need to unzip the folder put everything in ~/.local/share/fonts
- unzip ~/.local/share/fonts/Iosevka.zip
- rm -rf ~/.local/share/fonts/Iosevka.zip

### setConfigFiles
<!-- dotfiles will have
.
.gitconfig
.tmux.conf
.zshrc
.config/
  |__alacritty/
  |__i3/
  |__nvim/
  |__vim/
-->
- Clone .dotfiles folder --> git clone git@github.com:juanpabloinformatica/dotfiles.git ~/Documents/

- Once they are cloned
- I will have to copy those files to their respective locations
- cp ~/Documents/dotfiles/.gitconfig ~/
- cp ~/Documents/dotfiles/.tmux.conf ~/
- cp ~/Documents/dotfiles/.zshrc ~/
- cp -r ~/Documents/.config/alacritty ~/.config/
- cp -r ~/Documents/.config/alacritty ~/.config/
- cp -r ~/Documents/.config/i3 ~/.config/
- cp -r ~/Documents/.config/nvim ~/.config/
- cp -r ~/Documents/.config/vim ~/.config/

### Missing

- Generate ssh key and add pub to github.
