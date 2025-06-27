#! /usr/bin/bash
source ./variables.sh

function super_user_execute() {
	su - "$USER" -c "$@"
}

append_path() {
	case ":$PATH:" in
		*:"$1":*) ;;
		*)
			PATH="${PATH:+$PATH:}$1"
			;;
	esac
}

function user_sudo_nopasswd() {
	echo "here"
	# need to study sed command
	# echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" >>
	# sudo sed '/root ALL=(ALL:ALL) ALL/a\'"${USER}"' ALL=(ALL:ALL) NOPASSWD: ALL' /etc/sudoers | sudo tee /etc/sudoers
}
