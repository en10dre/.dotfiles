# Installation
```
sudo apt update
sudo apt install -y ninja-build gettext libtool autoconf automake cmake g++ 
pkg-config unzip curl

git clone git@github.com:neovim/neovim.git
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install

nvim --version
```

## Quickstart
Create a configuration directory by typing this command
```
mkdir -p ~/.config/nvim
cd ~/.dotfiles/nvim
stow nvim --target=$HOME/.config/nvim
```

## Usage
type `nvim` or `nvim .` in the command line.
