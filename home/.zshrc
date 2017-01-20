# Created by newuser for 5.2
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

# Zsh history setting
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

function history-all { history -E 1 }

# Add color to ls command
export CLICOLOR=1

# User local setting
if [ ! -d $HOME/local/bin ] ; then
  mkdir -p $HOME/local/bin
fi
export PATH="$HOME/local/bin:$PATH"

# homeshick setting
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

# Anyenv settings
if [ -d $HOME/.repos/.anyenv ] ; then
  if [ -d $HOME/.repos/anyenv-update -a ! -d $HOME/.repos/.anyenv/plugins/anyenv-update ]; then
    ln -sf $HOME/.repos/anyenv-update $HOME/.repos/.anyenv/plugins/anyenv-update
  fi
  if [ -d $HOME/.repos/anyenv-git -a ! -d $HOME/.repos/.anyenv/plugins/anyenv-git ]; then
    ln -sf $HOME/.repos/anyenv-git $HOME/.repos/.anyenv/plugins/anyenv-git
  fi
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

