# Anyenv plugins setup
if [ -d $HOME/.repos/anyenv-update -a ! -d $HOME/.anyenv/plugins/anyenv-update ]; then
    ln -s $HOME/.repos/anyenv-update $HOME/.anyenv/plugins/anyenv-update
fi

if [ -d $HOME/.repos/anyenv-git -a ! -d $HOME/.anyenv/plugins/anyenv-git ]; then
    ln -s $HOME/.repos/anyenv-git $HOME/.anyenv/plugins/anyenv-git
fi
