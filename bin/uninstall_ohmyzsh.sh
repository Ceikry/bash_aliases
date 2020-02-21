#!/bin/bash

#/**
# * Uninstall ohmyzsh
# *
# * @category bin
# * @version  0.1.0
# * @licence  MIT
# * @author   "Matthias Morin" <mat@tangoman.io>
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

# clean zsh folder
echo_info 'rm -rf ~/.oh-my-zsh'
rm -rf ~/.oh-my-zsh

echo_info 'rm -f ~/.zshrc'
rm -f ~/.zshrc

echo_info 'rm -f ~/.zshrc.bak'
rm -f ~/.zshrc.bak

echo_info 'rm -f ~/.zsh_history'
rm -f ~/.zsh_history

echo_success 'oh-my-zsh uninstalled'
