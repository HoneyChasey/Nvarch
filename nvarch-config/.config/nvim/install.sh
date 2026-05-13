#/bin/bash 

echo "installation of dependencies for neovim on the computer"
sleep 1 

if [ "$(uname)" = "Darwin" ]; then
    echo "You running this setup file on, macos"
    echo "Installation of ripgrep, for find string in your computer"
    brew install ripgrep
    brew install lazygit 
    echo "If not working, please go check ripgrep repo, of find alternative"
elif [ -f /etc/os-release ] && grep -q "Debian\|Ubuntu" /etc/os-release; then
    echo "You running this setup file on, debian-based linux distro"
    echo "Installation of ripgrep, for find string in your computer"
    sudo apt-get install ripgrep
    sudo apt-get install lazygit
    echo "If not working, please go check ripgrep repo, of find alternative"
else
    echo "Your system cannot run this setup file, abort"
    exit
fi



## Use this on arch based system 
sudo pacman -S lazygit 
sudo pacman -S luarocks
sudo pacman -S wl-clipboard
sudo pacman -S ripgrep
sudo pacan -S unixodbc # Used by qllms lsp. ODBC is an open specification for providing application developers with a predictable API with which to access Data Sources
