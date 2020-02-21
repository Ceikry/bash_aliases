#/**
# * TangoMan bash_aliases
# *
# * Run "make" to print help
# * If you want to add a help message for your rule, 
# * just add : "## My help for this rule", on the previous line
# * use : "### " to group rules by categories
# * You can give "make" arguments with this syntax: PARAMETER=VALUE
# *
# * @version 0.1.0
# * @author  "Matthias Morin" <mat@tangoman.io>
# * @licence MIT
# * @link    https://github.com/TangoMan75/bash_aliases
# */

.PHONY: help info install install-aliases install-zsh uninstall-aliases uninstall-theme uninstall-zsh update submodules generate-doc

# Colors
TITLE     = \033[1;42m
CAPTION   = \033[1;44m
BOLD      = \033[1;34m
LABEL     = \033[1;32m
DANGER    = \033[31m
SUCCESS   = \033[32m
WARNING   = \033[33
SECONDARY = \033[34m
INFO      = \033[35m
PRIMARY   = \033[36m
DEFAULT   = \033[0m
NL        = \033[0m\n

## Print this help
help:
	@printf "${TITLE}TangoMan $(shell basename ${CURDIR})${NL}\n"

	@printf "${CAPTION}description:${NL}\n"
	@printf "$(WARNING) Place desired .sh files inside /bash_files folder\n"
	@printf " Prefix your .sh files with underscore to concatenate them${NL}\n"

	@printf "${CAPTION} Usage:${NL}"
	@printf "${WARNING}  make [command]${NL}\n"

	@printf "${CAPTION}Available commands:${NL}\n"
	@awk '/^### / { printf "\n${BOLD}%s${NL}", substr($$0, 5) } \
	/^[a-zA-Z0-9_-]+:/ { if( match(PREV, /^## /)) HELP = substr(PREV, 4); else HELP = ""; \
		printf " ${LABEL}%-18s${DEFAULT} ${PRIMARY}%s${NL}", substr($$1, 0, index($$1, ":")), HELP \
	} { PREV = $$0 }' ${MAKEFILE_LIST}

##################################################
### Install
##################################################

## Full install
install:
ifeq ($(shell which zsh 2>/dev/null), /usr/bin/zsh)
	@printf "${INFO}ZSH already installed on current system... Skipping${NL}"
	@make -s install-aliases
else
	@make -s install-aliases
	@make -s install-zsh
endif

## Generate and install new bash_aliases
install-aliases: submodules
	@bash ./bin/init_bash_aliases.sh
	@bash ./bin/build_bash_aliases.sh
	@bash ./bin/install_bash_aliases.sh
	@bash ./bin/config_bash_aliases.sh
	@bash ./bin/reload_warning.sh

## Install zsh as default shell (not windows compatible)
install-zsh: submodules
ifeq ($(shell uname -s), Linux)
	@bash ./bin/install_zsh.sh
	@bash ./bin/install_fonts-powerline.sh
	@bash ./bin/install_ohmyzsh.sh
	@bash ./bin/config_zsh.sh
	@bash ./bin/install_tangoman-theme.sh
	@bash ./bin/config_bash_aliases.sh
	@bash ./bin/reload_warning.sh
	@bash ./bin/set_zsh_as_default_shell.sh
else
	@printf "\033[1;31merror:${DEFAULT} ${DANGER}ZSH incompatible with current system... Skipping${NL}"
endif

##################################################
### Uninstall
##################################################

## Remove bash_aliases
uninstall-aliases: submodules
	@bash ./bin/uninstall_bash_aliases.sh

## Remove zsh
uninstall-zsh: submodules
	@bash ./bin/uninstall_zsh.sh
	@bash ./bin/uninstall_ohmyzsh.sh
	@bash ./bin/uninstall_fonts-powerline.sh
	@bash ./bin/reload_warning.sh

## Restore zsh robbyrussell theme
uninstall-theme:
	@bash ./bin/restore_robbyrussell.sh

##################################################
### Update
##################################################

## Check update
update: submodules
	@bash ./bin/check_update.sh

##################################################
### Git
##################################################

## Initialise git submodules
submodules:
	@if [ -f ./.gitmodules ] && [ ! -f ./tools/.git ]; then \
		printf "${INFO}git submodule update --init --recursive${NL}"; \
		git submodule update --init --recursive; \
	fi

##################################################
### Misc
##################################################

## Generate documentation
generate-doc: submodules
	@bash ./bin/generate_doc.sh

