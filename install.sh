echo "Apply dotfiles..."
mkdir -p ~/.ssh
working_dir=$(pwd)

ln -sf $working_dir/.ssh/config ~/.ssh/config
ln -sf $working_dir/.hushlogin ~/.hushlogin

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
fi

# ZSH Configuration.
if [ ! -z "$(command -v zsh)" ] 
then 
    # install oh-my-zsh:
    if [ ! -d "$HOME/.oh-my-zsh" ]
    then 
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
    
    if [ ! -d "$HOME/.zplug" ]
    then 
        curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    fi

    if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]
    then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    fi

    ln -sf $working_dir/.zsh_aliases ~/.zsh_aliases
    ln -sf $working_dir/.zsh_functions ~/.zsh_functions
    ln -sf $working_dir/.zshrc ~/.zshrc
    ln -sf $working_dir/.zsh_variables ~/.zsh_variables
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

if [ ! -z "$(command -v tmux)" ]
then 
    if [ -d ~/.tmux ]; then
        git clone https://github.com/gpakosz/.tmux.git
    fi
    ln -sf $working_dir/.tmux.conf.local ~/.tmux.conf.local
fi


echo "done!"
