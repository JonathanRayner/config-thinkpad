# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v  # vim keybindings
# End of lines configured by zsh-newuser-install

autoload -Uz compinit

# Don't pollute $HOME with zcompdump files, instead save here
compinit -d "$HOME/.cache/zsh/zcompdump-$ZSH_VERSION-$HOST"

# Completion Style Configuration
zstyle :compinstall filename '$HOME/.zshrc'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'   # case-insensitive matching
zstyle ':completion:*' rehash true                       # automatically find new executables
zstyle ':completion:*' menu select                       # menu selection for completions

# bash compatibility
autoload -U +X bashcompinit && bashcompinit

# prompt format
setopt PROMPT_SUBST
PROMPT='%F{208}%n@%F{039}%M%F{226}:%~%F{red}TODO:git '

# Prefer vim or else fail over to vi
EDITOR="$(command -v vim 2>/dev/null || command -v vi)"
VISUAL="$(command -v vim 2>/dev/null || command -v vi)"

# Node Version Manager
source /usr/share/nvm/init-nvm.sh


# Avoid stale environment variables (like for SSH forwarding) when rejoing tmux sessions
function update_env_in_tmux() {
	if [ -n "${TMUX}" ]; then
		eval "$(tmux show-environment -s)"
	fi
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd update_env_in_tmux

# Plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# minio client
complete -o nospace -C /usr/bin/mcli mcli

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

# ssh
eval $(keychain --eval --quiet github)

# jujutsu stuff
source <(jj util completion zsh)

# jj commits
alias jjc="jj commit"
alias jjn="jj new"
alias jjd="jj describe -m"
alias jjdi="jj diff"

# jj navigation
alias jje="jj edit"
alias jjn="jj next"
alias jjp="jj prev"

# jj changing commit history
alias jjr="jj rebase"
alias jjsq="jj squash"
alias jjsp="jj split"
alias jja="jj abandon"

# jj git
alias jjg="jj git"
alias jjf="jj git fetch"
alias jjpr="jj git push --allow-new -r"  # usually want this one
alias jjpc="jj git push --allow-new -c"  # if don't care about remote branch name
alias jjpb="jj git push --allow-new -b"  # if specifying local branch name
alias jjcl="jj git clone"

# jj bookmarks
alias jjb="jj bookmark"
alias jjbs="jj bookmark set"
alias jjbd="jj bookmark delete"
alias jjbr="jj bookmark rename"
alias jjbl="jj bookmark list"
alias jjbt="jj bookmark track main@origin"  # when in a new repo, track main branch
