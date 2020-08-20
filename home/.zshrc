# Zplug setting
if [[ -f $HOME/.zplug/init.zsh ]]; then
  source ~/.zplug/init.zsh

  zplug "plugins/git", from:oh-my-zsh, if:"which git"
  zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
  zplug "themes/ys", from:oh-my-zsh, as:theme

  zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*darwin*amd64*"
  zplug "peco/peco", from:gh-r, as:command
  zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq

  zplug "b4b4r07/enhancd"
  zplug "mollifier/cd-gitroot"
  zplug "mollifier/anyframe", on:"peco/peco"

  zplug "zsh-users/zsh-completions"
  zplug "zsh-users/zsh-history-substring-search"
  zplug "zsh-users/zsh-syntax-highlighting", defer:2

  # zplug "~/.zsh", from:local
  # zplug "repos/robbyrussell/oh-my-zsh/custom/plugins/my-plugin", from:local

  if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
          echo; zplug install
      fi
  fi

  #zplug load --verbose
  zplug load
fi

# Execute local machine setting
[ -f $HOME/.zshrc_localmachine ] && . $HOME/zshrc_localmachine

# Zsh history setting
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

function history-all { history -E 1 }

bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

function peco-history-selection() {
  BUFFER=`history -n 1 | tac | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N peco-history-selection
bindkey '^p' peco-history-selection

## Zsh cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':completion:*' recent-dirs-insert both
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':chpwd:*' recent-dirs-max 1000
  zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

function peco-cdr() {
  local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | peco --prompt="cdr >" --query="$LBUFFER")"
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}

zle -N peco-cdr
bindkey '^e' peco-cdr

# Zsh directory setting
export CLICOLOR=1
case "$OSTYPE" in
  *darwin*|*freebsd*)
    alias ls='ls -FG'
    ;;
  linux*)
    alias ls='ls --color=auto'
    ;;
esac
alias la='ls -lhA'
alias ll='ls -l'
alias lst='ls -ltr'
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# Zsh completion
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# User local setting
if [ ! -d $HOME/local/bin ] ; then
  mkdir -p $HOME/local/bin
fi
export PATH="$HOME/local/bin:$PATH"

# homeshick setting
if [ -d $HOME/.homesick/repos/homeshick ]; then
  source "$HOME/.homesick/repos/homeshick/homeshick.sh"
  fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
fi

# Anyenv settings
if [ -d $HOME/.anyenv ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi

# Go environment
if [ ! -d $HOME/.go ] ; then
  mkdir $HOME/.go
  mkdir $HOME/.go/bin
  mkdir $HOME/.go/pkg
  mkdir $HOME/.go/src
fi
export PATH=$HOME/.go/bin:$PATH
export GOPATH=$HOME/.go
if [ -f /usr/local/go/bin/go ]; then
  export PATH=/usr/local/go/bin:$PATH
fi

# Rust environment
if [ -f $HOME/.cargo/env ] ; then
  # export PATH=$HOME/.cargo/bin:$PATH
  source $HOME/.cargo/env

  if [ ! -f $HOME/.rust/completions/rust_zsh_completions ]; then
    rustup completions zsh > $HOME/.rust/completions/rust_zsh_completions
  fi
  fpath+=$HOME/.rust/completions
fi

