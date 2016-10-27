# Created by newuser for 5.2
source ~/.zplug/init.zsh

zplug "plugins/git", from:oh-my-zsh, if:"which git"
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
zplug "themes/ys", from:oh-my-zsh

zplug "junegunn/fzf-bin", from:gh-r, as:command
zplug "peco/peco", from:gh-r, as:command
zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq

zplug "b4b4r07/enhancd"
zplug "mollifier/cd-gitroot"
zplug "mollifier/anyframe", on:"peco/peco"

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", nice:10

# zplug "~/.zsh", from:local
# zplug "repos/robbyrussell/oh-my-zsh/custom/plugins/my-plugin", from:local

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

# User local setting
if [ ! -d $HOME/local ] ; then
  mkdir $HOME/local
  mkdir $HOME/local/bin
fi
export PATH="$HOME/local/bin:$PATH"

# homeshick setting
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

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
fi

# emacs settings
if [ -d $HOME/.cask ] ; then
  export PATH=$HOME/.cask/bin:$PATH
fi

