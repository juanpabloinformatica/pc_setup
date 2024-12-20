#! /usr/bin/bash
DOTFILE_HOME_CONFIG="home"
DOTFILE_CONFIG_CONFIG="config"
DOTFILE_PICTURE_CONFIG="pictures"
function main(){
  dotfilesHandler
}
function dotfilesHandler(){
  getDotfiles
  # setDotfiles
}
function getDotfiles(){
 # temporal location 
 #
  if [[ ! -d "$HOME/dotfiles" ]]; then
    git clone https://github.com/juanpabloinformatica/dotfiles.git $HOME/dotfiles
    local -a dotFileDirFiles=($HOME/dotfiles/*)
    for dotFile in "${dotFileDirFiles[@]}";do
      echo "$dotFile"
      if [[ -d "$dotFile" ]]; then
        echo "i am a folder : $dotFile"
        local fileOrFolderName=$(echo "$dotFile##*/")
        if [[ "$fileOrFolderName" =~ $DOTFILE_HOME_CONFIG ]]; then
          # createSymlink $dotFile 
          local -a dotFileHomeConfigs=($dotFile/*)
          echo "Home ${dotFileHomeConfigs[*]}"
          for dotFileHomeConfig in "${dotFileHomeConfigs[@]}";do
            ln -s "$dotFileHomeConfig" $(echo"$HOME/tmp$fileOrFolderName"))
          done
        elif [[ $(echo "$dotFile##*/") =~ $DOTFILE_CONFIG_CONFIG ]]; then
          local -a dotFileConfigConfigs=($dotFile/*)
          echo "config ${dotFileHomeConfigs[*]}"
          for dotFileConfigConfig in "${dotFileConfigConfigs[@]}";do
            ln -s "$dotFileConfigConfig" $(echo"$HOME/tmp/.config$fileOrFolderName")
          done
        elif [[ $(echo "$dotFile##*/") =~ $DOTFILE_PICTURE_CONFIG ]]; then
          local -a dotFilePictureConfigs=($dotFile/*)
          echo " pictures ${dotFileHomeConfigs[*]}"
          for dotFilePictureConfig in "${dotFilePictureConfigs[@]}";do
            ln -s $dotFilePictureConfig $(echo"$HOME/tmp/Pictures$fileOrFolderName")
          done
        else
          echo "Not decided yet"
        fi
      # else
      #   if [[ $(echo "$dotFile##*/") =~  ]]; then
      #   fi
      fi
    done
  else
    echo "Folder doesn't exist"
  fi
}
function setDotfiles(){
  echo "here"
}
main
