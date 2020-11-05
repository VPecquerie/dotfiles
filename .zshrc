#!/bin/zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Check if zplug is installed
[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

# Source functions and aliases.
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases
[[ -f ~/.zsh_functions ]] && source ~/.zsh_functions
[[ -f ~/.zsh_variables ]] && source ~/.zsh_variables

# Theme
zplug "romkatv/powerlevel10k",      as:theme, depth:1

zplug "plugins/colored-man-pages",          from:oh-my-zsh
zplug "plugins/extract",                    from:oh-my-zsh
zplug "plugins/git",                        from:oh-my-zsh, if:"which git"
zplug "plugins/gpg-agent",                  from:oh-my-zsh, if:"which gpg-agent"
zplug "plugins/git",                        from:oh-my-zsh, if:"which git"
zplug "plugins/nmap",                       from:oh-my-zsh, if:"which nmap"
zplug "plugins/sudo",                       from:oh-my-zsh, if:"which sudo"
zplug "plugins/tmux",                       from:oh-my-zsh, if:"which tmux"
zplug "plugins/docker",                     from:oh-my-zsh, if:"which docker"
zplug "plugins/httpie",                     from:oh-my-zsh, if:"which http"
zplug "plugins/npm", 	                      from:oh-my-zsh, if:"which npm"

zplug "plugins/go",                         from:oh-my-zsh, if:"which go"
zplug "plugins/golang",                     from:oh-my-zsh, if:"which go"

# Supports oh-my-zsh plugins and the like
if [[ $OSTYPE = (linux)* ]]; then
	zplug "plugins/archlinux",  from:oh-my-zsh, if:"which pacman"
	zplug "plugins/dnf",        from:oh-my-zsh, if:"which dnf"
	zplug "plugins/debian",     from:oh-my-zsh, if:"which apt"
fi

if [[ $OSTYPE = (darwin)* ]]; then
	zplug "plugins/osx",        from:oh-my-zsh
	zplug "plugins/brew",       from:oh-my-zsh, if:"which brew"
	zplug "plugins/macports",   from:oh-my-zsh, if:"which port"
fi

zplug "zsh-users/zsh-completions",              defer:0
zplug "zsh-users/zsh-autosuggestions",          defer:2
zplug "zsh-users/zsh-syntax-highlighting",      defer:3
zplug "zsh-users/zsh-history-substring-search", defer:3

# Plugins to load
plugins=(
    colorize
    copyfile
    docker
    docker-compose
    git
    gitfast
    history-substring-search
    safe-paste
    tmux
    virtualenv
    zsh-autosuggestions
    zsh-completions
    zsh-history-substring-search
    zsh-syntax-highlighting
)


# =============================================================================
#                                   Options
# =============================================================================
setopt HIST_IGNORE_SPACE
setopt autocd                   # Allow changing directories without `cd`
setopt append_history           # Dont overwrite history
setopt extended_history         # Also record time and duration of commands.
setopt share_history            # Share history between multiple shells
setopt hist_expire_dups_first   # Clear duplicates when trimming internal hist.
setopt hist_find_no_dups        # Dont display duplicates during searches.
setopt hist_ignore_dups         # Ignore consecutive duplicates.
setopt hist_ignore_all_dups     # Remember only one unique copy of the command.
setopt hist_reduce_blanks       # Remove superfluous blanks.
setopt hist_save_no_dups        # Omit older commands in favor of newer ones.
setopt pushd_ignore_dups        # Dont push copies of the same dir on stack.
setopt pushd_minus              # Reference stack entries with "-".
setopt extended_glob

zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# =============================================================================
#                                Key Bindings
# =============================================================================
# Common CTRL bindings.
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^f" forward-word
bindkey "^b" backward-word
bindkey "^k" kill-line
bindkey "^d" delete-char
bindkey "^y" accept-and-hold
bindkey "^w" backward-kill-word
bindkey "^u" backward-kill-line
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^F" history-incremental-pattern-search-forward

# Do not require a space when attempting to tab-complete.
bindkey "^i" expand-or-complete-prefix

# Fixes for alt-backspace and arrows keys
bindkey '^[^?' backward-kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# =============================================================================
#                                 Completions
# =============================================================================
zstyle ':completion:*' rehash true

# case-insensitive (all), partial-word and then substring completion
zstyle ":completion:*" matcher-list \
  "m:{a-zA-Z}={A-Za-z}" \
  "r:|[._-]=* r:|=*" \
  "l:|=* r:|=*"

zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS}

# =============================================================================
#                                   Startup
# =============================================================================
fpath=(~/.zsh/completion $fpath) 

autoload -Uz compinit && compinit -i
source $ZSH/oh-my-zsh.sh

# Load SSH keys from GPG
if [[ $OSTYPE = (darwin)* ]]; then
	GPG_TTY=$(tty)
	export GPG_TTY
	if [ -f "${HOME}/.gpg-agent-info" ]; then
			. "${HOME}/.gpg-agent-info"
			export GPG_AGENT_INFO
			export SSH_AUTH_SOCK
	fi

  # iTerm2 integration
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

# Source local zsh customizations.
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
