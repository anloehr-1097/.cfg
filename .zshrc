# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$PATH:/Users/Andy/.local/bin"
export PATH="/Users/Andy/.config/emacs/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/homebrew/bin:$PATH"
export PATH="$HOME/homebrew/sbin:$PATH"
alias emacs="open -a ~/Applications/Emacs.app"
alias em="~/Applications/Emacs.app/Contents/MacOs/bin/emacsclient -cn"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/ncurses/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ncurses/lib"
export CPPFLAGS="-I/usr/local/opt/ncurses/include"
export PKG_CONFIG_PATH="/usr/local/opt/ncurses/lib/pkgconfig"
alias ls='ls --color'
export PATH="/usr/local/opt/m4/bin:$PATH"
alias gconf='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

neofetch

alias emst='open -a /Users/Andy/Applications/Emacs.app --args --bg-daemon'
export PATH="/usr/local/Cellar/gdb/13.1/bin:$PATH"
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /Users/Andy/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Users/Andy/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /Users/Andy/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

export PATH="/usr/local/opt/python@3.11:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/Users/Andy/Library/Python/3.9/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/Users/Andy/lldb/lldb-mi/src:$PATH"
export PATH="/usr/local/Cellar/gdb/13.2/bin:$PATH"
