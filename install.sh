echo "Apply dotfiles..."
mkdir -p ~/.ssh
working_dir=$(pwd)

ln -sf $working_dir/.ssh/config ~/.ssh/config

if [ -d ~/scripts ]; then 
    rm -rf ~/scripts
fi 
ln -sf $working_dir/scripts ~/scripts
chmod +x ~/scripts/*.sh

# Angular Configuration.
if [ ! -z "$(command -v ng)" ] 
then 
    ln -sf $working_dir/.angular-config.json ~/.angular-config.json
fi 

# GIT Configuration.
if [ ! -z "$(command -v git)" ] 
then 
    ln -sf $working_dir/.gitconfig ~/.gitconfig
    ln -sf $working_dir/.gitignore_global ~/.gitignore_global
fi 

# VIM Configuration.
if [ ! -z "$(command -v vim)" ] 
then 
    ln -sf $working_dir/.vimrc ~/.vimrc
    if [ ! -d ~/.vim/bundle/Vundle.vim ]; then 
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi
    vim +PluginInstall +qall
fi

# ZSH Configuration.
if [ ! -z "$(command -v zsh)" ] 
then 
    ln -sf $working_dir/.zsh_aliases ~/.zsh_aliases
    ln -sf $working_dir/.zsh_functions ~/.zsh_functions
    ln -sf $working_dir/.zshrc ~/.zshrc
    echo "export DOTFILES_DIR=\"$(pwd)\"" >> ~/.zshrc.local
    # We don't replace this file.
    if [ ! -f ~/.zshrc_variables ]; then 
        cp .zshrc_variables.dist .zshrc_variables
        ln -sf $working_dir/.zshrc_variables ~/.zshrc_variables
    fi

    # But produce a warning if current file has fewer lines
    numberSource=$(wc -l .zshrc_variables.dist | awk '{print $1}')
    numberTarget=$(wc -l ~/.zshrc_variables | awk '{print $1}')
    
    if [ "$numberSource" != "$numberTarget" ]; then 
        echo "Some differences are present in your .zshrc_variables file."
        echo "Please check it, and upgrade it."
        diff $working_dir/.zshrc_variables.dist ~/.zshrc_variables
        read
        vim ~/.zshrc_variables
    fi

fi

# PolyBar Configuration.
if [ ! -z "$(command -v polybar)"]
then
    if [ -d ~/.config/polybar ]; then 
        rm -rf ~/.config/polybar
    fi 
    ln -sf $working_dir/.config/polybar ~/.config/polybar
fi

# i3 Configuration.
if [ ! -z "$(command -v i3)"]
then
    if [ -d ~/.config/i3 ]; then 
        rm -rf ~/.config/i3
    fi 
    ln -sf $working_dir/.config/i3 ~/.config/i3
    ~/scripts/generate_i3_config.sh
fi

echo "done!"