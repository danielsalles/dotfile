# Path to Oh My Zsh (default install)
export ZSH="$HOME/.oh-my-zsh"

# Disable OMZ theme to avoid conflicts with Starship
ZSH_THEME=""

# Oh My Zsh plugins
plugins=(
    git
    extract
    nvm
    thefuck
    fzf-tab
    zsh-autosuggestions
    you-should-use
    zsh-syntax-highlighting
)

# Load Oh My Zsh (framework features and plugins)
source "$ZSH/oh-my-zsh.sh"

# Starship prompt (install via: brew install starship)
eval "$(starship init zsh)"

# zsh-autosuggestions configuration
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

# fzf-tab configuration
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'

# Initialize zoxide (smart cd)
eval "$(zoxide init zsh)"

# Initialize thefuck
eval "$(thefuck --alias)"

# Basic aliases (examples)
alias ll='ls -lah'
alias gs='git status'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
