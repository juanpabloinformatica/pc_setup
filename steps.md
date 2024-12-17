# Description

- I will try to put step by step what I do at the moment
  of setting up a new pc.

- So the first thing is I run the ISO (archlinux)
- Then at the moment of doing the archinstall script
  - I set the internet with iwctl --
    I let the default as local where I currently are
  - I put as user *??* and then its password
  - I take the default partition system with xfs4 as filesystem
  - Then I decide which software I would like install
    - bob --> (nvim)
    - docker --> (containers)
    - git --> (version control)
    - zsh --> (terminal)
    - alacritty --> (terminal emulator) ** archinstall let me chose this **
    - i3 --> (window manager) ** archinstall let me chose this *
    - yay --> (helper for more packages)
    - tmux -->  (terminal multiplexor)
    - firefox --> (web browser)
    - base-devel --> (c essentials)

  - Then Once the computer is accesable I install
    - pyenv  --> (python version manager)
    - nvm --> (node  version manager)
    - Fonts --> (Isoveka Nerd font)
    - vlc --> (video player)
    - simpleScreenRecoder --> (for recording my screen)
    - reflector --> (handles archlinux mirrors)
    - bluez --> (bluetooth protocl stack)
    - bluez-utils --> (bluetoothctl utility)
    - feh ==> (for X display utilities such as background)
    - flameshot --> (for screenshots)
    - htop --> (better top command)
    - spotify --> (music)
    - valgrind --> (check memory leaks in c/c++ programs)
    - vagrant --> (for virtual machine as IaC)
    - virtualBox  --> (virtual machines provider) | 
      remember adding **??** as vboxuser 
      | then install linux-headers | then give vboxdrv access to kernel-
      (sudo modprobe vboxdrv)
    - 

  - Then I will need to clone all my dotfiles
    - .gitconfig
    - .tmux.conf
    - .zshrc
    - ~/.config/alacritty/alacritty.toml
    - ~/.config/i3/config
    - ~/.config/nvim.bat
    - ~/.config
    - ~/.config/vim/


- So there are two approaches, the first one is-
  taking advantage of the archinstall and the second-
  one, is making it more general for other linux distributions.

