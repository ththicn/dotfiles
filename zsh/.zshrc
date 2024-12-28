# --- 環境変数の設定 ---
# Homebrew の自動更新を無効化
export HOMEBREW_NO_AUTO_UPDATE=1

# パスの設定
export PATH="$HOME/.local/bin:$PATH"

# Dotfiles ディレクトリ
DOTFILES_DIR="$HOME/src/github.com/ththicn/dotfiles"

# ツールディレクトリ
TOOLS_DIR="$DOTFILES_DIR/tools/llm"

# Google Cloud SDK のディレクトリ
GCS_DIR="$HOME/google-cloud-sdk"

# --- エイリアスの設定 ---
# ls コマンドのエイリアス
alias ls='ls --color=auto'
alias la='ls --color=auto -a'
alias ll='ls --color=auto -l'
alias l1='ls --color=auto -1'
alias lal='ls --color=auto -al'
alias lt='ls --color=auto -T'

# その他のエイリアス
alias cat='bat'
alias diff='delta'
alias cur='cursor'
alias en="$TOOLS_DIR/trans_en.sh"

# --- 関数の設定 ---
# fzf を使用した履歴選択
function select-history() {
  local BUFFER=$(history -n -r 1 | fzf --reverse --height=50% --query="$LBUFFER")
  if [ -n "$BUFFER" ]; then
    CURSOR=${#BUFFER}
  fi
  zle clear-screen
  zle accept-line
}
zle -N select-history
bindkey '^r' select-history

# ghq と fzf を使用したディレクトリ選択
function ghq-fzf() {
  local src=$(ghq list | fzf --reverse --height=50%)
  if [ -n "$src" ]; then
    BUFFER="z $(ghq root)/$src"
    zle accept-line
  fi
  zle clear-screen
}
zle -N ghq-fzf
bindkey '^g' ghq-fzf

# --- プロンプトの初期化 ---
eval "$(starship init zsh)"

# --- Zsh の設定 ---
# 履歴設定
setopt hist_ignore_all_dups
setopt hist_ignore_dups

# 補完設定
fpath=(
  "$HOME/.zsh/completions"
  $fpath
)
autoload -Uz compinit
compinit

# zsh のプラグイン
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- 外部ツールの初期化 ---
# Mise の初期化
eval "$(mise activate zsh)"

# Zoxide の初期化
eval "$(zoxide init zsh)"

# 1Password のプラグイン
source "$HOME/.config/op/plugins.sh"

# --- Google Cloud SDK の設定 ---
# PATH の更新
if [ -f "$GCS_DIR/path.zsh.inc" ]; then
  source "$GCS_DIR/path.zsh.inc"
fi

# gcloud の補完を有効化
if [ -f "$GCS_DIR/completion.zsh.inc" ]; then
  source "$GCS_DIR/completion.zsh.inc"
fi
