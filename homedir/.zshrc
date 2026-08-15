# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.dotfiles/oh-my-zsh
# if you want to use this, change your non-ascii font to Droid Sans Mono for Awesome
# POWERLEVEL9K_MODE='awesome-patched'
export ZSH_THEME="jreese"

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# disable colors in ls
# export DISABLE_LS_COLORS="true"

# disable autosetting terminal title.
export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.dotfiles/oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(colorize compleat dirpersist autojump git gulp history cp)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ ! -s "$NVM_DIR/nvm.sh" ] && [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh" # brew-installed nvm

autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

if command -v nvm >/dev/null; then
  add-zsh-hook chpwd load-nvmrc
  load-nvmrc
fi

command -v direnv >/dev/null && eval "$(direnv hook zsh)"

# Customize to your needs...
unsetopt correct

[ -x "$HOME/projects/hemnet-terminal-command/bin/hemnet" ] && eval "$("$HOME/projects/hemnet-terminal-command/bin/hemnet" init - zsh)"

# run fortune on new terminal :)
# fortune
export PATH="/opt/homebrew/opt/texinfo/bin:$PATH"

# source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
# PS1='$(kube_ps1) '$PS1

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

[ -f "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ] && source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# # pnpm
# export PNPM_HOME="/Users/meric426/Library/pnpm"
# case ":$PATH:" in
#   *":$PNPM_HOME:"*) ;;
#   *) export PATH="$PNPM_HOME:$PATH" ;;
# esac
# # pnpm end

export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"

export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$PATH:~/.rbenv/shims"
command -v rbenv >/dev/null && eval "$(rbenv init - zsh)"

export PATH="$HOME/.jenv/bin:$PATH"
command -v jenv >/dev/null && eval "$(jenv init -)"

[ -f "$HOME/.rubyopenssl_default_store.rb" ] && export RUBYOPT="-r$HOME/.rubyopenssl_default_store.rb $RUBYOPT"

[[ "$TERM_PROGRAM" == "vscode" ]] && command -v code >/dev/null && . "$(code --locate-shell-integration-path zsh)"

# Load Angular CLI autocompletion.
command -v ng >/dev/null && source <(ng completion script)
export PATH="$HOME/.local/bin:$PATH"

alias cursor="open -a Cursor"
export EDITOR="code --wait"
