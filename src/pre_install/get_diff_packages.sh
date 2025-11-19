#!/usr/bin/bash

function get_diff_packages() {
  mapfile -t all_packages < <(sudo pacman -Q | awk '{print $1}')
  diff_packages=()
  for package in "${all_packages[@]}"; do
    if ! grep -q "${package}" ./archlinux_packages.txt; then
      diff_packages+=("${package}")
    fi
  done
  for package in "${diff_packages[@]}"; do
    printf "\n%s" "${package}"
  done
}
function main() {
  get_diff_packages
}
main "$@"
