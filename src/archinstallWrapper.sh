#! /usr/bin/bash

#Variables

curr_dir=$(pwd)
random_server="googleaaa.com"
archinstall_json_url="https://raw.githubusercontent.com/juanpabloinformatica/pc_setup/refs/heads/main/src/archinstallConfig.json"
config_file="${curr_dir}/config.json"

function check_internet() {
	ping -c1 ${random_server} -c1 &> /dev/null \
		&& return 0 \
		|| return 1
}

function get_archinstall_config() {
	curl --output "${config_file}" ${archinstall_json_url} \
		&& return 0 \
		|| return 1
}
function init_wrapper() {
	check_internet \
		|| echo "Set internet" \
		&& return 1
	get_archinstall_config \
		|| return 1
	archinstall --config "${config_file}"
}
init_wrapper
