# Script holding everythin to be installed in new setup
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "OS TYPE: macOS"

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "OS TYPE: Linux"

else
    echo "OS TYPE: Unknown"
fi
brew install cmake
brew install curl
brew install git
brew install htop
brew install neovim
brew install python3
brew install ripgrep
brew install silversearcher-ag
brew install tmux
brew install tree
brew install unzip
brew install wget
brew install zsh
brew install ripgrep-all
brew install zathura
brew install zathura-pdf-poppler
brew install zoxide
brew install fzf
brew install entr
brew install buku
brew install --cask amethyst

brew install aspell
# -- potentially worse than aspell
brew install ispell  

brew install emacs
brew install --cask anki
brew install --cask font-cantarell
brew install --cask font-iosevka-nerd-font
brew install node
brwe install powerlevel10k
brew tap d12frosted/emacs-plus
brew install emacs-plus
brew install --cask visual-studio-code
brew install --cask miniconda
brew install --cask eloston-chromium
brew install --cask keepassxc
brew install pass
brew install tldr

# other tools possibly over git 
# zsh-autosuggestions
#
