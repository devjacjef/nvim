#!/bin/sh

# Cloning Neovim to /tmp/
git clone https://github.com/neovim/neovim /tmp/nvim

# Building Neovim
cd /tmp/nvim  
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo

# Installing Neovim for Debian
cd build && cpack -G DEB && sudo dpkg -i nvim-linux-x86_64.deb
