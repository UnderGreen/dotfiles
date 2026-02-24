# Only load interactive configuration if shell is interactive
if [[ -o interactive ]]; then
  # Initialize completion system
  autoload -Uz compinit && compinit

  # Plugin manager (antidote)
  ANTIDOTE_HOME="${ZDOTDIR:-$HOME}/.antidote"
  [[ -d $ANTIDOTE_HOME ]] || git clone --depth=1 https://github.com/mattmc3/antidote.git $ANTIDOTE_HOME
  source $ANTIDOTE_HOME/antidote.zsh
  antidote load

  # History configuration
  HISTFILE=~/.zsh_history
  HISTSIZE=10000
  SAVEHIST=$HISTSIZE
  setopt append_history
  setopt extended_history
  setopt hist_expire_dups_first
  setopt hist_find_no_dups
  setopt hist_ignore_dups
  setopt hist_ignore_space
  setopt hist_reduce_blanks
  setopt hist_verify
  setopt inc_append_history
  setopt share_history

  # Emacs-style keybindings
  bindkey -e

  # Starship prompt
  eval "$(starship init zsh)"

  DISABLE_AUTO_TITLE="true"

  iterm_tab_title() {
    echo -ne "\e]0;${PWD##*/}\a"
  }
  add-zsh-hook precmd iterm_tab_title

  # fzf configuration
  source <(fzf --zsh)
  export FZF_CTRL_T_OPTS="--height 40% --exact --reverse --preview 'bat --color \"always\" {}'"
  export FZF_CTRL_R_OPTS="--height 40%"

  # zoxide (smart cd)
  eval "$(zoxide init --cmd cd zsh)"

  # direnv hook
  eval "$(direnv hook zsh)"

  # Load macOS-specific configuration
  [[ -f "$HOME/.zshrc.macos" ]] && source "$HOME/.zshrc.macos"
fi
