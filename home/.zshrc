# Created by newuser for 5.2
source ~/.zplug/zplug

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

# pyenv setting
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# rbenv setting
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# ndenv settings
export PATH="$HOME/.ndenv/bin:$PATH"
eval "$(ndenv init -)"

# Go environment
export GOPATH=$HOME/go/ext-pkg:$HOME/go/my-pkg
export PATH=$HOME/go/ext-pkg/bin:$PATH

