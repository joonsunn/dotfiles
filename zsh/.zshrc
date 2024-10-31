if command -v oh-my-posh > /dev/null; then
    eval "$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/craver.omp.json)"
fi

source ~/dotfiles/helper_scripts/zsh-completions/zsh-completions.plugin.zsh
source ~/dotfiles/helper_scripts/fzf-tab/fzf-tab.plugin.zsh
source ~/dotfiles/helper_scripts/fzf-tab/fzf-tab.zsh
source ~/dotfiles/helper_scripts/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ~/dotfiles/helper_scripts/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/helper_scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source ~/dotfiles/helper_scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

# Aliases
alias ls='ls --color -lah'

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

