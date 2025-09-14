#!/usr/bin/env bash

# Install Oh My Zsh Custom Plugins

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_info() {
    echo -e "${YELLOW}→${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

# Custom plugins directory
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
PLUGINS_DIR="${ZSH_CUSTOM}/plugins"

# Ensure plugins directory exists
mkdir -p "$PLUGINS_DIR"

# Function to clone or update plugin
install_plugin() {
    local repo_url="$1"
    local plugin_name="$2"
    local plugin_path="${PLUGINS_DIR}/${plugin_name}"

    if [ -d "$plugin_path" ]; then
        print_info "Updating ${plugin_name}..."
        cd "$plugin_path" && git pull
    else
        print_info "Installing ${plugin_name}..."
        git clone "$repo_url" "$plugin_path"
    fi
    print_success "${plugin_name} ready"
}

# Install custom plugins
echo "Installing Oh My Zsh custom plugins..."

install_plugin "https://github.com/Aloxaf/fzf-tab.git" "fzf-tab"
install_plugin "https://github.com/zsh-users/zsh-autosuggestions.git" "zsh-autosuggestions"
install_plugin "https://github.com/zsh-users/zsh-syntax-highlighting.git" "zsh-syntax-highlighting"
install_plugin "https://github.com/MichaelAquilina/zsh-you-should-use.git" "you-should-use"

echo ""
print_success "All custom plugins installed!"