#!/bin/bash
echo "Installation of dependencies for neovim on this computer"
sleep 1

echo "Installing Rust via rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Installation of tree-sitter"
cargo install --locked tree-sitter-cli

if [ "$(uname)" = "Darwin" ]; then
    echo "You are running this setup file on macOS"

    brew install $(cat install/pkgs-macos.txt)

    echo "Note: wl-clipboard is Linux/Wayland only. On macOS, pbcopy/pbpaste are built-in."
    echo "If not working, please check the relevant repos for alternatives."

elif [ -f /etc/os-release ] && grep -q "Arch" /etc/os-release; then
    echo "You are running this setup file on an Arch-based Linux distro"
    sudo pacman -S --needed --noconfirm $(cat install/pkgs-arch.txt)  
    echo "If not working, please check the relevant repos for alternatives."

elif [ -f /etc/os-release ] && grep -q "Debian\|Ubuntu" /etc/os-release; then
    echo "You are running this setup file on a Debian-based Linux distro"

    sudo apt install $(cat install/pkgs-debian_based.txt)

echo ""
echo "All dependencies installed successfully!"
