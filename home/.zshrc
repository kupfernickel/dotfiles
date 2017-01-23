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

  zplug load --verbose
fi

# Zsh history setting
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

function history-all { history -E 1 }

bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

# Zsh directory setting
export CLICOLOR=1
alias ls='ls --color=auto'
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
if type go 2>/dev/null 1>/dev/null ; then
  if [ ! -d $HOME/.go ] ; then
    mkdir $HOME/.go
    mkdir $HOME/.go/bin
    mkdir $HOME/.go/pkg
    mkdir $HOME/.go/src
  fi
  export GOPATH=$HOME/.go
  export PATH=$HOME/.go/bin:$PATH
fi

# Rust environment
if [ -f $HOME/.cargo/env ] ; then
  # export PATH=$HOME/.cargo/bin:$PATH
  source $HOME/.cargo/env
fi

