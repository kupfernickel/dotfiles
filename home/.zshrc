# Created by newuser for 5.2
source ~/.zplug/init.zsh

zplug "plugins/git", from:oh-my-zsh, if:"which git"
zplug "themes/ys", from:oh-my-zsh
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

zplug "peco/peco", as:command, from:gh-r

zplug "b4b4r07/enhancd", of:enhancd.sh
zplug "mollifier/cd-gitroot"
zplug "mollifier/anyframe"

zplug "zsh-users/zsh-history-substring-search", do:"__zsh_version 4.3"
zplug "zsh-users/zsh-syntax-highlighting", nice:10

zplug "~/.zsh", from:local
zplug "repos/robbyrussell/oh-my-zsh/custom/plugins/my-plugin", from:local

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

# homeshick setting
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

# fzf
if [ -f $HOME/.fzf.zsh ] ; then
  source $HOME/.fzf.zsh
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
if [ -d $HOME/.cargo/bin ] ; then
  export PATH=$HOME/.cargo/bin:$PATH
  if [ -f $HOME/cargo/bin/racer ] ; then
    export RUST_SRC_PATH=$HOME/.rust/src/1.12.0/
  fi
fi

# Cask settings
if [ -d $HOME/.cask ] ; then
  export PATH=$HOME/.cask/bin:$PATH
fi

