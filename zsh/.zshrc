# brew
export HOMEBREW_NO_AUTO_UPDATE=1

# Set Alias
alias ls='exa'
alias la='exa -a'
alias ll='exa -l'
alias l1='exa -1'
alias lal='exa -al'
alias lt='exa -T'
alias python='/opt/homebrew/bin/python3.11'
alias cat='bat'


# fzf hisotory
function select-history() {
  local BUFFER=$(history -n -r 1 | fzf --reverse --height=~50% --query="$LBUFFER")
  if [ -n "$BUFFER" ]; then
    CURSOR=${#BUFFER}
  fi
  zle clear-screen
  zle accept-line
}
zle -N select-history
bindkey '^r' select-history

# ghq + fzf
function ghq-fzf() {
  local src=$(ghq list | fzf --reverse --height=~50%)
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle clear-screen
}
zle -N ghq-fzf
bindkey '^g' ghq-fzf

# starship
eval "$(starship init zsh)"

# zsh history
setopt hist_ignore_all_dups
setopt hist_ignore_dups

# zsh completion
fpath=(
  ${HOME}/.zsh/completions
  ${fpath}
)
autoload -Uz compinit
compinit

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# poetry
export PATH="/Users/ththicn/.local/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ththicn/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ththicn/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ththicn/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ththicn/google-cloud-sdk/completion.zsh.inc'; fi
