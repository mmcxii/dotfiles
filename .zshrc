# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zinit
ZINIT_HOME="${XDG_CACHE_HOME:-$HOME/local/.cache}/zinit/zinit.git"
# Install zinit
if [[ ! -d $ZINIT_HOME ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
