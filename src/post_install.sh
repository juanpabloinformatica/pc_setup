#!/usr/bin/bash

function _generate_temporal_pacman_packages() {
  sudo pacman -Q >temporal_pacman_packages.txt
}
function _remove_temporal_pacman_packages() {
  rm -rf temporal_pacman_packages.txt
}
function _package_handling() {

  if ! grep -q "${needed_package}" temporal_pacman_packages.txt; then
    printf "\n%s --> %s" "Installing" "${needed_package}"
    sudo pacman -S "${needed_package}"
  else
    printf "\n%s --> %s" "${needed_package}" "Already installed"
  fi
}

function _dir_handling() {
  if [[ ! -d "${needed_dir}" ]]; then
    printf "\n%s" "Creating needed directory"
    mkdir -p "${needed_dir}"
  else
    printf "\n%s" "Needed directory already there"
  fi
}
function _font_handling() {
  printf "\n%s --> %s" "Check font" "${needed_font}"
  if ! find "${needed_dir[0]}" -type f | grep -q Iosevka; then
    printf "\n%s " "Font not found, Installing" "${needed_font}"
    output_font="${needed_dir[0]}/IosevkaTerm.zip"
    curl -L -o "${output_font}" \
      https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/IosevkaTerm.zip |
      unzip "${output_font}"
  fi
}

function set_display() {

  printf "\n%s" "set_display function"
  needed_packages=("xorg-server" "lightdm" "lightdm-gtk-greeter")
  # temporal file
  for needed_package in "${needed_packages[@]}"; do
    _package_handling
  done
  # Once installed needed package enable service
  sudo systemctl enable lightdm.service
  # Check xorg and lightdm and light greeter
}
function set_fzf() {
  printf "\n%s" "set_fzf  function"
  needed_package=("fzf")
  _package_handling
}
function set_font() {
  printf "\n%s" "set_font  function"
  needed_packages=("curl")
  _package_handling
  needed_dir=("$HOME/.local/share/fonts")
  _dir_handling
  needed_font=("IosevkaNerdFont")
  _font_handling

}
function set_version_mgrs() {
  set_pyenv
  set_nvm
}
function set_nvm() {
  printf "\n%s" "set_nvm  function"
}
function set_pyenv() {
  printf "\n%s" "set_pyenv function"
}
function set_dotfiles() {
  printf "\n%s" "set_dotfiles function"
}
function get_personal_projects() {
  printf "\n%s" "get_personal_projects  function"
}

function main() {

  _generate_temporal_pacman_packages
  printf "\n%s" "main function"
  if set_display; then
    printf "\n%s" "Display setup working"
  fi
  if set_fzf; then
    printf "\n%s" "fzf setup working"
  fi
  if set_font; then
    printf "\n%s" "font setup working"
  fi
  _remove_temporal_pacman_packages
}
main "$@"
