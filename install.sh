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

if [ -d ~/.config/polybar ]; then 
    rm -rf ~/.config/polybar
fi 
ln -sf $working_dir/.config/polybar ~/.config/polybar


if [ -d ~/.config/i3 ]; then 
    rm -rf ~/.config/i3
fi 
ln -sf $working_dir/.config/i3 ~/.config/i3

if [ -d ~/scripts ]; then 
    rm -rf ~/scripts
fi 
ln -sf $working_dir/scripts ~/scripts
chmod +x ~/scripts/*.sh

# We don't update this file.
if [ ! -f ~/.zshrc_variables ]; then 
    cp .zshrc_variables.dist .zshrc_variables
    ln -sf $working_dir/.zshrc_variables ~/.zshrc_variables
fi

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then 
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

vim +PluginInstall +qall
~/scripts/generate_i3_config.sh
echo "done!"