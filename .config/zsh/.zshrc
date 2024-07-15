export PATH="/usr/local/bin:$HOME/bin:$HOME/.local/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"


# ================================
# Global settings
# ================================

export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export PRETTIERD_DEFAULT_CONFIG="$XDG_CONFIG_HOME/prettierd.json"


# ================================
# Program environments
# ================================

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac


# Cargo
CARGO_ENV="$HOME/.cargo/env"
if [ -f $CARGO_ENV ]; then
    . $CARGO_ENV
fi


# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"


# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


# TeX Live
export PATH="$PATH:/usr/local/texlive/2024/bin/x86_64-linux"
export MANPATH="$MANPATH:/usr/local/texlive/2024/texmf-dist/doc/man"
export INFOPATH="$INFOPATH:/usr/local/texlive/2024/texmf-dist/doc/info"


# thefuck
eval $(thefuck --alias)


# ranger
ranger_cd() {
    temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
    ranger --choosedir="$temp_file" -- "${@:-$PWD}"
    if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
        cd -- "$chosen_dir"
    fi
    rm -f -- "$temp_file"
}


# bat
export BAT_THEME="kanagawa"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}


# ================================
# Aliases
# ================================

# Python virtualenv aliases
alias ve="python3 -m venv ./.venv"
alias va="source ./.venv/bin/activate"


# ls -> exa
alias ls="exa --color=auto"
alias la="ls -A"
alias ll="ls -lhF --sort=type --icons"
alias lla="ll -A --sort=type --icons"
alias l="ls -F"
alias lt="ls -T"
alias lta="lt -A"

# Peaclock with config
alias peaclock="peaclock --config-dir $XDG_CONFIG_HOME/peaclock"

# Fuzzy cd
alias sd="cd ~ && cd \$(fzf --walker=dir,hidden)"


# rmtrash aliases
alias rm="rmtrash"
alias rmdir="rmdirtrash"
alias sudo="sudo " # necessary for some reason


# ================================
# Zsh environment
# ================================

source "$ZDOTDIR/themes/aphrodite/aphrodite.zsh-theme"

source "$ZDOTDIR/plugins/zsh-autopair/autopair.zsh"
autopair-init

source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
bindkey '^ ' autosuggest-accept

_comp_options+=(globdots)
fpath+="$ZDOTDIR/plugins/zsh-completions/src"
autoload -U compinit; compinit

source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

source "/usr/share/doc/pkgfile/command-not-found.zsh"

# ================================
# Zsh Vi mode
# ================================
#
bindkey -v
export KEYTIMEOUT=1
source "$ZDOTDIR/plugins/cursor_mode"

# For some reason these aren't defaults
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char
bindkey "^W" backward-delete-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Better history navigation
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Press v to edit command in editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Text objects
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
    bindkey -M $km -- '-' vi-up-line-or-history
    for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
        bindkey -M $km $c select-quoted
    done
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $km $c select-bracketed
    done
done

# Surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround


albafetch

