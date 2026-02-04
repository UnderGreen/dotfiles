alias grep="/opt/homebrew/bin/ggrep"
alias ls="ls --color=auto -F"
alias vim="nvim"
alias lg="lazygit"
alias ccode='CLAUDE_CONFIG_DIR=~/.claude-personal claude'

export GOPATH="$HOME/go"
export EDITOR="nvim"

# Load local/private environment variables
[[ -f "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"
