#!/usr/bin/bash
set -xe

# current_dir=$(pwd)

function _generate_temporal_pacman_packages() {
  pacman -Q >temporal_pacman_packages.txt
}
function _remove_temporal_pacman_packages() {
  rm -rf temporal_pacman_packages.txt
}

function _print_error() {
  printf "\n\t\%\t\n" "${1}"
}

function _packages_handling() {

  download_command="sudo pacman -S"
  for p in "${needed_packages[@]}"; do
    if ! grep -q "${p}" temporal_pacman_packages.txt; then
      printf "\n%s --> %s" "Installing" "${p}"
      sudo pacman -S --noconfirm "${p}"
    else
      printf "\n%s --> %s" "${p}" "Already installed"
    fi
  done

}

function _dir_handling() {
  for dir in "${needed_dirs[@]}"; do
    if [[ ! -d "${dir}" ]]; then
      printf "\n%s" "Creating needed directory"
      mkdir -p "${dir}"
    else
      printf "\n%s" "Needed directory already there"
    fi
  done
}

function _set_my_dirs() {
  download_prefix="$HOME/Downloads"
  video_prefix="$HOME/Videos"
  document_prefix="$HOME/Documents"
  needed_dirs=(
    "$download_prefix/images"
    "$download_prefix/isos"
    "$download_prefix/other"
    "$download_prefix/pdfs"
    "$download_prefix/software"
    "$download_prefix/compressed"
    "$video_prefix/nand2tetris"
    "$video_prefix/scripts"
    "$video_prefix/others"
    "$document_prefix/courses"
    "$document_prefix/personal"
    "$document_prefix/profesional"
    "$document_prefix/books"
    "$document_prefix/sharpening"
    "$document_prefix/projects"
  )
  _dir_handling
}

function _font_handling() {

  printf "\n%s --> %s" "Check font" "${needed_font}"
  if ! find "${dir[0]}" -type f | grep -q Iosevka; then
    printf "\n%s " "Font not found, Installing" "${needed_font}"
    output_font="${dir[0]}/IosevkaTerm.zip"
    curl -L -o "${output_font}" \
      https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/IosevkaTerm.zip &&
      unzip "${output_font}" -d "${dir[0]}" ||
      _print_error "Iosevka font zip not able to be downloaded"

  fi
}

function set_display() {

  printf "\n%s" "set_display function"
  needed_packages=("xorg-server" "lightdm" "lightdm-gtk-greeter")
  # temporal file
  _packages_handling
  # Once installed needed package enable service
  sudo systemctl enable lightdm.service
  # Check xorg and lightdm and light greeter
}
function set_font() {
  printf "\n%s" "set_font  function"
  needed_packages=("curl" "unzip")
  _packages_handling
  needed_dirs=("$HOME/.local/share/fonts")
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
  needed_packages=("curl")
  _packages_handling
  needed_dirs=("$HOME/.config/zsh")
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
	source "$HOME/.config/zsh/.zshrc"
  # ${nvm_bin} install stable || return 1
}
function set_pyenv() {
  printf "\n%s" "set_pyenv function"
  needed_packages=("curl")
  _packages_handling
  curl -fsSL https://pyenv.run | bash
}
function set_dotfiles() {
  printf "\n%s" "set_dotfiles function"
  needed_packages=("git")
  _packages_handling
  needed_dirs=("$HOME/Documents")
  _dir_handling

  [[ ! -d "${dir[0]}/dotfiles" ]] &&
    git clone --recurse-submodules https://github.com/juanpabloinformatica/dotfiles.git "${dir[0]}/dotfiles"

  if [[ -d "${dir[0]}/dotfiles" ]]; then
    (
      cd "${dir[0]}/dotfiles" || exit
      bash script_dotfiles.sh
    )
  fi
}
function handling_essential_user_packages() {
  printf "\n%s" "Handling essential packages"
  needed_packages=()
  while IFS= read -r -d $'\n' package; do
    if ! grep -q -E "(#)|(^\s*$)" <<<"${package}"; then
      needed_packages+=("${package}")
    fi
  done < <(cat packages.txt)
  _packages_handling
}

function set_dirs() {
  printf "\n%s" "Handling essential packages"
  needed_packages=("xdg-user-dir")
  _packages_handling
  xdg-user-dirs-update
  _set_my_dirs
}
function get_personal_projects() {
  printf "\n%s" "get_personal_projects  function"
  needed_packages=("git")
  _packages_handling
  needed_dirs=("$HOME/Documents/projects")
  _dir_handling

}
function set_scripts() {
  printf "\n%s" "get_personal_projects  function"
  needed_packages=("git")
  _packages_handling
  needed_dirs=("$HOME/Documents")
  _dir_handling
  script_url="$(awk '$0 ~ /scripts\.git/ && $0 ~ /clone_url/ {print $2}' ./repos.txt | tr -d "\"" | tr -d ",")"
  if [[ ! -d "${dir[0]}/scripts" ]]; then
    git clone "${script_url}" "${dir[0]}/scripts"
  fi
}

function set_antidote() {
  needed_packages=("git")
  _packages_handling
  needed_dirs=("$HOME/.config/zsh")
  _dir_handling
  if [[ ! -d "${dir[0]}/.antidote" ]]; then
    git clone --depth=1 https://github.com/mattmc3/antidote.git "${dir[0]}/.antidote"
  fi

}

function _update_keyring() {
  printf "\n%s" "Update keyring"
  sudo pacman -Sy --noconfirm archlinux-keyring --needed &&
    sudo pacman -Su --noconfirm || return 1
}

function main() {

  _generate_temporal_pacman_packages

  printf "\n%s" "main function"
  #
  ! _update_keyring &&
    printf "\n\%s" " _update_keyring didn't work" &&
    return 1 ||
    printf "\n%s" "updated archlinux keyring"

  ! handling_essential_user_packages &&
    printf "\n\%s" " handling_essential_user_packages didn't work" &&
    return 1 ||
    printf "\n%s" "Installing essential packages"

  ! set_dirs &&
    printf "\n%s" "font setup didn't work" &&
    return 1 ||
    printf "\n%s" "font setup working"

  ! set_font &&
    printf "\n\%s" " set_font didn't work" &&
    return 1 ||
    printf "\n%s" "font setup working"

  ! set_scripts &&
    printf "\n\%s" " set_scripts didn't work" &&
    return 1 ||
    printf "\n%s" "set_scripts setup working"

  ! set_dotfiles &&
    printf "\n%s" "font setup didn't work" &&
    return 1 ||
    printf "\n%s" "font setup working"

  # ! set_zsh &&
  #   printf "\n%s" "set_zsh setup didn't work" &&
  #   return 1 ||
  #   printf "\n%s" "set_zsh setup working"


  ! set_antidote &&
    printf "\n%s" "Antidote setup didn't work" &&
    return 1 ||
    printf "\n%s" "Antidote setup working"

  ! set_version_mgrs &&
    printf "\n\%s" " set_version_mgrs didn't work" &&
    return 1 ||
    printf "\n%s" "Version Mgr setup working"

  #
  ! set_display &&
    printf "\n\%s" " set_display didn't work" &&
    return 1 ||
    printf "\n%s" "Display setup working"

  # Missing ssh config

  #
  _remove_temporal_pacman_packages

  # Check config
  systemctl reboot
  # systemctl poweroff

}
main "$@"
