# DEFAULT_USER="drakemorin"
# prompt_context(){}

export GOPATH=$HOME/go

alias gs="git status"
alias gd="git diff"
alias gch="git checkout"
alias gres1="git reset --soft HEAD~1"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/drakemorin/.oh-my-zsh"

# Spin functions from Ed
function spin_poc_repo {
  spin shell $1 -- "set -x && stop && cd /src/github.com/shopify/$1 && source .spin/bin/env && source /etc/profile && git checkout -- . && git checkout poc_org_admin_in_web && update && start"
}

function spin_setup_poc {
        set -x
        spin_poc_repo business-platform \
                && spin_poc_repo shopify \
                && spin_poc_repo web
}

function spin_log() {
  kubectl logs -f $1.$(spin info fqdn | cut -d. -f2-) --namespace $(spin info fqdn | cut -d. -f3) --context "spin-us-central1-1" spin-host
}

function spin_db {
  open "mysql://root@$1.$(spin info fqdn | cut -d. -f2-)/$2" -a "Sequel Ace"
}

function spin_bp_db {
  spin_db business-platform business_platform_development
}

function spin_identity_db {
  spin_db identity identity_development
}

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Powerline configuration
# Add newline to below to have newline before prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status dir vcs)

# No right prompt
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_DISABLE_RPROMPT=true

# Truncate all but last 2 directories
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

# Git status colours
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='green4'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='cyan'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'

# Hide status unless it's an error
POWERLEVEL9K_STATUS_OK=false
# Only show an X for non-zero exit codes
POWERLEVEL9K_STATUS_VERBOSE=false

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  ruby
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/Users/drakemorin/Library/Python/3.7/bin:$PATH"
[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
if [ -e /Users/drakemorin/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/drakemorin/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# cloudplatform: add Shopify clusters to your local kubernetes config
export KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}/Users/drakemorin/.kube/config:/Users/drakemorin/.kube/config.shopify.cloudplatform
for file in /Users/drakemorin/src/github.com/Shopify/cloudplatform/workflow-utils/*.bash; do source ${file}; done
kubectl-short-aliases
