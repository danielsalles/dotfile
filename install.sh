#!/usr/bin/env bash

# Dotfiles Installation Script
# This script sets up a new macOS machine with all configurations

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${YELLOW}→${NC} $1"
}

# Get the directory of the script
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "🚀 Starting Dotfiles Installation..."
echo "======================================"

# 1. Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    print_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    print_success "Homebrew installed"
else
    print_success "Homebrew already installed"
fi

# 2. Install packages from Brewfile
print_info "Installing packages from Brewfile..."
brew bundle --file="${DOTFILES_DIR}/Brewfile"
print_success "Packages installed"

# 3. Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh My Zsh installed"
else
    print_success "Oh My Zsh already installed"
fi

# 4. Install custom Oh My Zsh plugins
print_info "Installing Oh My Zsh custom plugins..."
"${DOTFILES_DIR}/scripts/install-plugins.sh"
print_success "Custom plugins installed"

# 5. Create config directory if it doesn't exist
mkdir -p ~/.config

# 6. Backup existing files and create symlinks
print_info "Creating symlinks..."

# Function to backup and symlink
backup_and_symlink() {
    local src="$1"
    local dest="$2"

    # If destination exists and is not a symlink, back it up
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        print_info "Backing up existing $(basename $dest) to $(basename $dest).backup"
        mv "$dest" "${dest}.backup"
    fi

    # Remove existing symlink if it exists
    if [ -L "$dest" ]; then
        rm "$dest"
    fi

    # Create new symlink
    ln -sf "$src" "$dest"
    print_success "Linked $(basename $src) → $(basename $dest)"
}

# Symlink dotfiles
backup_and_symlink "${DOTFILES_DIR}/zsh/.zshrc" "$HOME/.zshrc"
backup_and_symlink "${DOTFILES_DIR}/config/starship.toml" "$HOME/.config/starship.toml"

# 7. Install Node Version Manager (NVM) if not installed
if [ ! -d "$HOME/.nvm" ]; then
    print_info "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    print_success "NVM installed"
else
    print_success "NVM already installed"
fi

# 8. Set macOS defaults (optional)
read -p "Do you want to set macOS defaults? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_info "Setting macOS defaults..."
    "${DOTFILES_DIR}/macos/set-defaults.sh"
    print_success "macOS defaults set"
fi

# 9. Configure iTerm2 (if installed)
if [ -d "/Applications/iTerm.app" ]; then
    print_info "Configuring iTerm2..."
    "${DOTFILES_DIR}/scripts/setup-iterm2.sh"
    print_success "iTerm2 configured"
fi

# 10. Install and configure LazyVim
read -p "Do you want to install LazyVim (Neovim IDE)? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_info "Installing LazyVim..."
    "${DOTFILES_DIR}/scripts/install-lazyvim.sh"
    print_success "LazyVim installed"
fi

echo ""
echo "======================================"
echo -e "${GREEN}✨ Dotfiles installation complete!${NC}"
echo ""
echo "Please restart your terminal or run: source ~/.zshrc"
echo ""
echo "Optional: Import Dracula theme in iTerm2:"
echo "  1. Open iTerm2 Preferences"
echo "  2. Go to Profiles → Colors"
echo "  3. Import Dracula theme"
echo ""
if [ -d "$HOME/.config/nvim" ]; then
    echo "LazyVim is installed! Run 'nvim' to start."
fi