export PATH=$PATH:$HOME/.local/bin
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

source ~/dotfiles/helper_scripts/zsh-completions/zsh-completions.plugin.zsh
source ~/dotfiles/helper_scripts/fzf-tab/fzf-tab.plugin.zsh
# source ~/dotfiles/helper_scripts/fzf-tab/fzf-tab.zsh
source ~/dotfiles/helper_scripts/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
# source ~/dotfiles/helper_scripts/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/helper_scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
# source ~/dotfiles/helper_scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /etc/zsh_command_not_found
source ~/dotfiles/zsh/secrets.zsh

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

lsofport() { lsof -i tcp:$1 }

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
alias wezterm-here='wezterm start --cwd .'
alias sqlite='sqlite3'
alias unstow="stow --delete"

# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -Uz add-zsh-hook
autoload -Uz vcs_info

# watch_prompt() {
#     if [[ "$PROMPT" != "$LAST_PROMPT" || "$RPROMPT" != "$LAST_RPROMPT" ]]; then
#         print -P "%F{red}PROMPT CHANGED%f"
#         LAST_PROMPT=$PROMPT
#         LAST_RPROMPT=$RPROMPT
#     fi
# }

# add-zsh-hook precmd watch_prompt
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:git:*' formats '%b '

export FZF_TMUX=1

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/foo/.lmstudio/bin"
# End of LM Studio CLI section

# export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/Users/foo/.gem/ruby/3.4.0/bin:$PATH"

alias kube-homelab="export KUBECONFIG=~/.kube/clusters/k3s-homelab.yaml"
alias kube-default="export KUBECONFIG=~/.kube/config"
alias kube-local="unset KUBECONFIG"

# default logging configs for opentofu
export TF_LOG=DEBUG
export TF_LOG_PATH=./opentofu.log

# for postgres install using mise
export PKG_CONFIG_PATH="/opt/homebrew/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"
export LDFLAGS="-L/opt/homebrew/opt/icu4c/lib $LDFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/icu4c/include $CPPFLAGS"

# reconfigure global git config folder
export XDG_CONFIG_HOME="$HOME/.config"

eval "$($HOME/.local/bin/mise activate zsh)"

setopt PROMPT_SUBST

if command -v oh-my-posh >/dev/null; then
    eval "$(oh-my-posh init zsh --config "$HOME/dotfiles/oh-my-posh/my-craver.omp.json")"
else
    # for SSH sessions where oh-my-posh is not available    
    NEWLINE=$'\n'
    PROMPT='%(?.%F{green}✓.%F{red}✗)%f %F{green}%*%f %B%F{blue}%n%f@%F{white}%m%f%b %F{yellow}%~%f %F{red}${vcs_info_msg_0_}%f%# ${NEWLINE}%F{white}⯈%f '
    RPROMPT='%F{8}⏱  %*%f'
fi
