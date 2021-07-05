# DEFAULT_USER="drakemorin"
# prompt_context(){}

export GOPATH=$HOME/go

source ~/antigen/antigen.zsh

antigen use oh-my-zsh

antigen theme romkatv/powerlevel10k

# Add newline to below to have newline before prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(host status dir vcs newline)

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

# Load bundles from default repo (oh-my-zsh)
antigen bundle git
antigen bundle gitignore
antigen bundle command-not-found
antigen bundle osx
antigen bundle ruby
antigen bundle rails
antigen bundle thefuck

# Load bundles from external repos
antigen bundle zsh-users/zsh-syntax-highlighting

# Tells antigen we're done with our configuration
antigen apply

alias zshconfig="vim ~/.zshrc"
source ~/.zsh_aliases

source ~/.spin_commands

export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/Users/drakemorin/Library/Python/3.7/bin:$PATH"
[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
if [ -e /Users/drakemorin/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/drakemorin/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# cloudplatform: add Shopify clusters to your local kubernetes config
export KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}/Users/drakemorin/.kube/config:/Users/drakemorin/.kube/config.shopify.cloudplatform
for file in /Users/drakemorin/src/github.com/Shopify/cloudplatform/workflow-utils/*.bash; do source ${file}; done
kubectl-short-aliases
