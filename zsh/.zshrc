export PATH=$PATH:$HOME/.local/bin

if command -v oh-my-posh > /dev/null; then
    # eval "$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/craver.omp.json)"
    eval "$(oh-my-posh init zsh --config ~/dotfiles/oh-my-posh/my-craver.omp.json)"
fi

source ~/dotfiles/helper_scripts/zsh-completions/zsh-completions.plugin.zsh
source ~/dotfiles/helper_scripts/fzf-tab/fzf-tab.plugin.zsh
source ~/dotfiles/helper_scripts/fzf-tab/fzf-tab.zsh
source ~/dotfiles/helper_scripts/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ~/dotfiles/helper_scripts/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/helper_scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source ~/dotfiles/helper_scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /etc/zsh_command_not_found

# Load completions
autoload -Uz compinit && compinit

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

kill_port() {
    if [ -z "$1" ]; then
        echo "Usage: k <port_number>"
        return 1
    fi

    PORT=$1
    PIDS=$(lsof -t -i:"$PORT")

    if [ -z "$PIDS" ]; then
        echo "No processes found running on port $PORT"
        return 0
    fi

    echo "Killing processes on port $PORT: $PIDS"
    kill -9 $PIDS
}

alias k='kill_port'

# Aliases
alias ls='ls --color -lah'
alias supdate='sudo apt update && sudo apt dist-upgrade -y'

# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
# for SSH sessions where oh-my-posh is not available
NEWLINE=$'\n'
PROMPT='%(?.%F{green}✓.%F{red}✗)%f %F{green}%*%f %B%F{blue}%n%f@%F{white}%m%f%b %F{yellow}%~%f %F{red}${vcs_info_msg_0_}%f%# ${NEWLINE}%F{white}⯈%f '
RPROMPT='%F{8}⏱  %*%f'

export FZF_TMUX=1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
