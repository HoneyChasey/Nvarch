#!/bin/bash
echo "Installation of dependencies for neovim on this computer"
sleep 1

echo "Installing Rust via rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Installation of tree-sitter"
cargo install --locked tree-sitter-cli

if [ "$(uname)" = "Darwin" ]; then
    echo "You are running this setup file on macOS"

    echo "Installing ripgrep (for finding strings in your files)..."
    brew install ripgrep

    echo "Installing lazygit..."
    brew install lazygit

    echo "Installing lazydocker..."
    brew install lazydocker

    echo "Installing luarocks..."
    brew install luarocks

    echo "Installing unixodbc (used by qllms lsp)..."
    brew install unixodbc

    echo "Note: wl-clipboard is Linux/Wayland only. On macOS, pbcopy/pbpaste are built-in."
    echo "If not working, please check the relevant repos for alternatives."

elif [ -f /etc/os-release ] && grep -q "Arch" /etc/os-release; then
    echo "You are running this setup file on an Arch-based Linux distro"

    echo "Installing lazygit..."
    sudo pacman -S --noconfirm lazygit

    echo "Installing lazydocker..."
    brew -S --noconfirm lazydocker

    echo "Installing luarocks..."
    sudo pacman -S --noconfirm luarocks

    echo "Installing wl-clipboard (Wayland clipboard support)..."
    sudo pacman -S --noconfirm wl-clipboard

    echo "Installing ripgrep (for finding strings in your files)..."
    sudo pacman -S --noconfirm ripgrep

    echo "Installing unixodbc (used by qllms lsp)..."
    sudo pacman -S --noconfirm unixodbc


    echo "If not working, please check the relevant repos for alternatives."

elif [ -f /etc/os-release ] && grep -q "Debian\|Ubuntu" /etc/os-release; then
    echo "You are running this setup file on a Debian-based Linux distro"

    echo "Installing ripgrep (for finding strings in your files)..."
    sudo apt-get install -y ripgrep

    echo "Installing lazygit..."
    sudo apt-get install -y lazygit

    echo "Installing luarocks..."
    sudo apt-get install -y luarocks

    echo "Installing lazydocker..."
    sudo apt-get install -y lazydocker

    echo "Installing wl-clipboard (Wayland clipboard support)..."
    sudo apt-get install -y wl-clipboard

    echo "Installing unixodbc (used by qllms lsp)..."
    sudo apt-get install -y unixodbc

    echo "If not working, please check the relevant repos for alternatives."

    echo "setup tex on this computer"
    sudo pacman -S texlive-basic texlive-latex texlive-binextra zathura-pdf-mupdf tesseract-data-fra tesseract-data-eng
else 
    echo "Your system is not supported by this setup file. Aborting."
    exit 1
fi

echo ""
echo "All dependencies installed successfully!"
