echo "Apply dotfiles..."
mkdir -p ~/.ssh
working_dir=$(pwd)
ln -sf $working_dir/.ssh/config ~/.ssh/config
ln -sf $working_dir/.angular-config.json ~/.angular-config.json
ln -sf $working_dir/.gitconfig ~/.gitconfig
ln -sf $working_dir/.gitignore_global ~/.gitignore_global
ln -sf $working_dir/.vimrc ~/.vimrc
ln -sf $working_dir/.zsh_aliases ~/.zsh_aliases
ln -sf $working_dir/.zshrc ~/.zshrc
cp .zshrc_variables.dist .zshrc_variables
ln -sf $working_dir/.zshrc_variables ~/.zshrc_variables

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then 
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall