# Navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# Eza aliases (modern ls replacement with icons)
alias ls='eza --icons --group-directories-first -1'
alias ll='eza --icons --group-directories-first -lah'
alias la='eza --icons --group-directories-first -la'
alias l='eza --icons --group-directories-first -l'
alias lt='eza --icons --group-directories-first --tree --level=2'
alias tree='eza --icons --tree'

# Bat aliases (better cat with syntax highlighting)
alias bat='bat --theme=Dracula'
alias b='bat --theme=Dracula'
alias bcat='bat -pp'
alias bathelp='bat --list-themes'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate'

# Safety nets
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Shortcuts
alias h='history'
alias j='jobs -l'
alias c='clear'
alias reload='source ~/.zshrc'

# Development
alias python='python3'
alias pip='pip3'

# Show/hide hidden files in Finder
alias show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"

# Cleanup
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"