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
    - tmux -->  (terminal multiplexor)
    - firefox --> (web browser)
    - base-devel --> (c essentials)
    - wget --> for (telecharging things from the web)
    - curl --> for (transfering and getting data from the web)
    - zip --> for (compressing folders)
    - unzip --> (for unzip compressed folders)
    - stow --> (for managing dotfiles)
    - ripgrep --> (A grep with steroids, better with fzf and telescope)
  - Then Once the computer is accesable I install
    - oh-my-zsh --> (This is what makes better zsh)
    - pyenv  --> (python version manager)
    - nvm --> (node  version manager)
    - vlc --> (video player)
    - yay --> (helper for more packages)
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
    - Fonts --> (Isoveka Nerd font)

  - Then I will need to clone all my dotfiles
    - .gitconfig
    - .tmux.conf
    - .zshrc
    - ~/.config/alacritty/alacritty.toml
    - ~/.config/i3/config
    - ~/.config/nvim.bat
    - ~/.config
    - ~/.config/vim/

  - Missing steps
    - Generate ssh key to been able to push,pull, etc from pc to github/gitlab
    - get alacritty themes


- So there are two approaches, the first one is-
  taking advantage of the archinstall and the second-
  one, is making it more general for other linux distributions.
