#!/bin/bash
HOME_DIR='/home/user'

stow -t ${HOME_DIR} bashrc
stow -t ${HOME_DIR} ranger
stow -t ${HOME_DIR} tmux
stow -t ${HOME_DIR} git
stow -t ${HOME_DIR} nvim
