export PATH="/opt/homebrew:$PATH"

# Zinit
ZINIT_HOME="${XDG_CACHE_HOME:-$HOME/local/.cache}/zinit/zinit.git"
# Install zinit
if [[ ! -d $ZINIT_HOME ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/default.toml)"
fi

# Syntax Highlighting
zinit light zsh-users/zsh-syntax-highlighting

# Autocompletions
zinit light zsh-users/zsh-completions
# Load completions
autoload -U compinit && compinit
# Match lowercase to uppercase
zstyle ":completion:*" matcher-list "m:{a-z}={A-Z}"
# Fuzzy Search
zinit light Aloxaf/fzf-tab
zstyle ":completion:*" menu no
#                                           Single quoutes are require
#                                           for command to work
zstyle ":fzf-tab:complete:cd:*" fzf-preview 'ls --color $realpath'
zstyle ":fzf-tab:complete:__zoxide_z:*" fzf-preview 'ls --color $realpath'
eval "$(fzf --zsh)"

# Autosuggestions
zinit light zsh-users/zsh-autosuggestions
# Keybindings
# EMACS
bindkey -e
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward
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

# Styling
# Colorize ls
alias ls="ls --color"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"

# Aliases
# General
alias c="clear"
eval "$(zoxide init --cmd cd zsh)"
alias lsa="ls -a"
# Git
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit -m"
alias gcn="git commit --amend --no-edit"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gacp="git add -A && git commit --amend --no-edit && git push --force-with-lease"
alias gbmp="git checkout master && git pull"
alias gbmap="git checkout main && git pull"
alias gb="git branch"
alias gbd="gb -D"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
