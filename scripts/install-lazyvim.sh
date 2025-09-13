#!/usr/bin/env bash

# LazyVim Installation Script

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${YELLOW}→${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Get the directory of the script
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
NVIM_CONFIG_DIR="$HOME/.config/nvim"

echo "🚀 Installing LazyVim..."
echo "======================================"

# 1. Backup existing Neovim configuration if it exists
if [ -d "$NVIM_CONFIG_DIR" ]; then
    print_info "Backing up existing Neovim configuration..."
    mv "$NVIM_CONFIG_DIR" "${NVIM_CONFIG_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
    print_success "Backup created"
fi

# 2. Create symlink to our Neovim configuration
print_info "Creating symlink to Neovim configuration..."
mkdir -p "$HOME/.config"
ln -sf "${DOTFILES_DIR}/config/nvim" "$NVIM_CONFIG_DIR"
print_success "Symlink created"

# 3. Install Neovim if not installed
if ! command -v nvim &> /dev/null; then
    print_info "Installing Neovim..."
    brew install neovim
    print_success "Neovim installed"
else
    print_success "Neovim already installed"
fi

# 4. Install required dependencies
print_info "Installing LazyVim dependencies..."

# Install ripgrep if not installed
if ! command -v rg &> /dev/null; then
    brew install ripgrep
    print_success "ripgrep installed"
else
    print_success "ripgrep already installed"
fi

# Install fd if not installed
if ! command -v fd &> /dev/null; then
    brew install fd
    print_success "fd installed"
else
    print_success "fd already installed"
fi

# Install lazygit if not installed
if ! command -v lazygit &> /dev/null; then
    brew install lazygit
    print_success "lazygit installed"
else
    print_success "lazygit already installed"
fi

# 5. Install Node.js dependencies for LSP servers
print_info "Setting up Node.js for LSP servers..."
if command -v npm &> /dev/null; then
    # Install common LSP servers globally
    npm_packages=(
        "typescript"
        "typescript-language-server"
        "@vue/language-server"
        "vscode-langservers-extracted"
        "yaml-language-server"
        "dockerfile-language-server-nodejs"
        "@tailwindcss/language-server"
    )

    for package in "${npm_packages[@]}"; do
        if npm list -g "$package" &>/dev/null; then
            print_success "$package already installed"
        else
            print_info "Installing $package..."
            npm install -g "$package" 2>/dev/null || true
        fi
    done
else
    print_info "npm not found. Install Node.js to enable JavaScript/TypeScript LSP"
fi

# 6. Install Python dependencies for LSP
if command -v pip3 &> /dev/null; then
    print_info "Installing Python LSP server..."
    pip3 install --user pyright 2>/dev/null || true
    print_success "Python LSP configured"
else
    print_info "pip3 not found. Install Python to enable Python LSP"
fi

# 7. Install Lua language server
if ! command -v lua-language-server &> /dev/null; then
    print_info "Installing Lua language server..."
    brew install lua-language-server
    print_success "Lua language server installed"
else
    print_success "Lua language server already installed"
fi

echo ""
echo "======================================"
echo -e "${GREEN}✨ LazyVim installation complete!${NC}"
echo ""
echo "Next steps:"
echo "1. Open Neovim: nvim"
echo "2. LazyVim will automatically install plugins on first launch"
echo "3. Wait for all plugins to install"
echo "4. Run :checkhealth to verify installation"
echo ""
echo "Useful commands:"
echo "  Space + l + l    - Open Lazy plugin manager"
echo "  Space + f + f    - Find files"
echo "  Space + f + g    - Live grep"
echo "  Space + e        - File explorer"
echo "  Space + g + g    - Open lazygit"
echo ""
echo "Leader key is set to: Space"
echo "Local leader is set to: ,"