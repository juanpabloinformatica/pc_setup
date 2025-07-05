# Need to be fixxed
# include ./requirements.mk
include ./secrets.mk
#Variables
#Needs to be changed
GITHUB_TOKEN?=<ACCESS_TOKEN>
USERNAME?=<USERNAME>
PWD:=$(shell pwd)
DOCUMENTS_PATH:=${HOME}/Documents
REPOSITORIES:=${PWD}/repositories.txt
SRC_PATH:=${PWD}/src
DOTFILES:=${DOCUMENTS_PATH}/dotfiles
SCRIPTS:=${DOCUMENTS_PATH}/scripts
GIT_REPOS=$(shell cat repositories.txt)
DOTFILES_REPO=$(filter %dotfiles.git,${GIT_REPOS})
SCRIPTS_REPO=$(filter %scripts.git,${GIT_REPOS})


all: dotfiles scripts
#
# dotfiles:
#
scripts:${SCRIPTS}
#
${SCRIPTS}: repositories
	git clone ${SCRIPTS_REPO} "$@"

#this will get the projects
# projects

#Will update projects
# update-projects

dotfiles: ${DOTFILES}

${DOTFILES}: repositories
	git clone ${DOTFILES_REPO} "$@"
	bash ${SRC_PATH}/dotfiles.sh


repositories: ${REPOSITORIES}


${REPOSITORIES}:
	curl -L \
	-H "Accept: application/vnd.github+json" \
	-H "Authorization: Bearer ${GITHUB_TOKEN}" \
	-H "X-GitHub-Api-Version: 2022-11-28" \
	https://api.github.com/users/${USERNAME}/repos | grep -Pi "\bclone_url\b" | awk  '{print $$2}' | tr '\n' ' ' | tr ',' ' ' | tr -d '"' | tee ${REPOSITORIES}




clean:
	rm -r ${DOTFILES}
	rm -r ${SCRIPTS}




test: ;
.PHONY: all clean

