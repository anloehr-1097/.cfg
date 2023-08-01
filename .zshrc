# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/Andy/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/Andy/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/Andy/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/Andy/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
export PATH="$PATH:/Users/Andy/.local/bin"
# export HOMEBREW_PREFIX=~/usr/local
# export PATH=/Users/Andy/opt/anaconda3/bin:/Users/Andy/opt/anaconda3/condabin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:/Users/Andy/.local/bin:/Users/Andy/homebrew/bin
export PATH="/Applications/Julia-1.7.app/Contents/Resources/julia/bin:${PATH}"
# export PATH="/Users/Andy/homebrew/sbin:$PATH"
export PATH="/Users/Andy/.config/emacs/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/homebrew/bin:$PATH"
export PATH="$HOME/homebrew/sbin:$PATH"
export PATH="$HOME/opt/anaconda3/bin:$PATH"
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

