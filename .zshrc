export PATH="/usr/local/bin:$HOME/bin:$HOME/.local/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"
export ZSH="$HOME/.oh-my-zsh"


# OMZ stuff
ZSH_THEME="aphrodite/aphrodite"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd/mm/yyyy"
plugins=(
	git
	virtualenv
	zsh-autopair
	zsh-interactive-cd
	sudo
	command-not-found
	fzf
	nvm
)

source $ZSH/oh-my-zsh.sh


# Some global settings
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export EDITOR='nvim'


# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
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
export PATH=$BUN_INSTALL/bin:$PATH
[ -s "/home/jdgt/.bun/_bun" ] && source "/home/jdgt/.bun/_bun"


# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
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


# Extra ZSH plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept

fastfetch

