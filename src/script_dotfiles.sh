#! /usr/bin/bash
set -euxo pipefail

source ./variables.sh
source ./utilities.sh

function initDotfiles() {
	echo "DOTFILES HANDLER ACTIVATED"
	dotfilesHandler
	echo "FINISHING DOTFILES"
	exit 0
}
function dotfilesHandler() {
	getDotfiles #[working]
	setDotfiles
}
function getDotfiles() {
	# temporal location
	# clone if folder doesn't exist
	if [[ ! -d "$DOTFILE_PATH" ]]; then
		git clone https://github.com/juanpabloinformatica/dotfiles.git "$DOTFILE_PATH"
	else
		echo "Folder already exist"
	fi
}

function getType() {
	local dotfileType=$1
	local fileOrFolderName
	fileOrFolderName=$(basename "$dotfileType")

	if [[ "$fileOrFolderName" =~ $DOTFILE_HOME_CONFIG ]]; then
		echo "$DOTFILE_HOME_CONFIG"
	elif [[ "$fileOrFolderName" =~ $DOTFILE_CONFIG_CONFIG ]]; then
		echo "$DOTFILE_CONFIG_CONFIG"
	elif [[ "$fileOrFolderName" =~ $DOTFILE_PICTURE_CONFIG ]]; then
		echo "$DOTFILE_PICTURE_CONFIG"
	else
		echo "$DOTFILE_GIT"
	fi
}

function setSymlink() {
	local dirFile=$1
	local typeFile=$2
	local lastFileName
	lastFileName="$(basename "$dirFile")"
	if [[ "$typeFile" =~ $DOTFILE_HOME_CONFIG ]]; then
		if [[ ! -L "$SYMLINK_HOME/$lastFileName" ]]; then
			ln -s "$dirFile" "$SYMLINK_HOME/$lastFileName"
		fi
	elif [[ "$typeFile" =~ $DOTFILE_CONFIG_CONFIG ]]; then
		if [[ ! -L "$SYMLINK_CONFIG/$lastFileName" ]]; then
			ln -s "$dirFile" "$SYMLINK_CONFIG/$lastFileName"
		fi
	else
		if [[ ! -L "$SYMLINK_PICTURES/$lastFileName" ]]; then
			ln -s "$dirFile" "$SYMLINK_PICTURES/$lastFileName"
		fi
	fi
}
function setDotfiles() {
	# Once the dotfiles folder is got
	# I need to traverse each file | folder
	# and create the symlink with each of them
	# I need to get the each element as a list with their filepaths
	mapfile -t dotfilesArray < <(find "$DOTFILE_PATH" -type d -maxdepth 1 ! -path "$DOTFILE_PATH" ! -path "$DOTFILE_PATH/$DOTFILE_GIT")
	local -i dotfilesArrayLength=${#dotfilesArray[@]}
	for ((i = 0; i < dotfilesArrayLength; i += 1)); do
		# For each file I will create the symlink
		mapfile -t filesInDirectory < <(find "${dotfilesArray[i]}" -maxdepth 1 '!' -path "${dotfilesArray[i]}")
		local filesInDirectoryLength=${#filesInDirectory[@]}
		for ((j = 0; j < filesInDirectoryLength; j += 1)); do
			local resultType
			resultType="$(getType "${dotfilesArray[i]}")"
			setSymlink "${filesInDirectory[j]}" "$resultType"
		done
	done
}
initDotfiles
