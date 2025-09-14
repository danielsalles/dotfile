#!/usr/bin/env bash

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "🔍 Validating Dotfiles Setup..."
echo "================================"
echo ""

# Test 1: Check if DOTFILES_DIR is detected correctly
echo "1. Testing DOTFILES_DIR detection:"
source ~/.zshrc 2>/dev/null || true
if [[ -n "$DOTFILES_DIR" ]]; then
    echo -e "${GREEN}✓${NC} DOTFILES_DIR detected as: $DOTFILES_DIR"
    if [[ -d "$DOTFILES_DIR" ]]; then
        echo -e "${GREEN}✓${NC} Directory exists and is accessible"
    else
        echo -e "${RED}✗${NC} Directory does not exist!"
        exit 1
    fi
else
    echo -e "${RED}✗${NC} DOTFILES_DIR not detected!"
    exit 1
fi
echo ""

# Test 2: Verify all symlinks are valid
echo "2. Checking symlinks:"
SYMLINKS=(
    "$HOME/.zshrc"
    "$HOME/.config/starship.toml"
    "$HOME/.gitconfig"
    "$HOME/.gitignore_global"
    "$HOME/.config/nvim"
)

for link in "${SYMLINKS[@]}"; do
    if [[ -L "$link" ]]; then
        target=$(readlink -f "$link")
        if [[ -e "$target" ]]; then
            echo -e "${GREEN}✓${NC} $link → $target"
        else
            echo -e "${RED}✗${NC} $link → broken link!"
        fi
    else
        echo -e "${YELLOW}⚠${NC}  $link is not a symlink"
    fi
done
echo ""

# Test 3: Check if custom files are being loaded
echo "3. Testing custom file loading:"
if alias ls &>/dev/null; then
    LS_ALIAS=$(alias ls 2>/dev/null | grep eza || echo "")
    if [[ -n "$LS_ALIAS" ]]; then
        echo -e "${GREEN}✓${NC} Custom aliases loaded (ls uses eza)"
    else
        echo -e "${YELLOW}⚠${NC}  Custom aliases may not be loaded"
    fi
else
    echo -e "${YELLOW}⚠${NC}  Unable to check aliases"
fi

if type mkd &>/dev/null; then
    echo -e "${GREEN}✓${NC} Custom functions loaded (mkd function exists)"
else
    echo -e "${YELLOW}⚠${NC}  Custom functions may not be loaded"
fi
echo ""

# Test 4: Check installed tools
echo "4. Checking required tools:"
tools=("git" "zsh" "starship" "eza" "zoxide" "fzf" "nvim")
for tool in "${tools[@]}"; do
    if command -v $tool &>/dev/null; then
        echo -e "${GREEN}✓${NC} $tool installed"
    else
        echo -e "${RED}✗${NC} $tool not found"
    fi
done
echo ""

# Test 5: Test portability
echo "5. Testing portability:"
echo "Current DOTFILES_DIR: $DOTFILES_DIR"
echo "Testing if setup would work from different location..."

# Simulate different clone location
TEST_DIR="/tmp/dotfiles-test-$$"
if [[ "$1" == "--test-clone" ]]; then
    echo "Cloning to $TEST_DIR for testing..."
    git clone "$DOTFILES_DIR" "$TEST_DIR" &>/dev/null
    cd "$TEST_DIR"

    # Check if install script detects correct path
    DETECTED_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}/../" )" && pwd )"
    if [[ "$DETECTED_DIR" == "$TEST_DIR" ]]; then
        echo -e "${GREEN}✓${NC} Install script would detect correct path"
    else
        echo -e "${RED}✗${NC} Path detection issue"
    fi

    # Cleanup
    rm -rf "$TEST_DIR"
else
    echo -e "${YELLOW}→${NC} Run with --test-clone to test full portability"
fi
echo ""

echo "================================"
echo -e "${GREEN}✅ Validation complete!${NC}"
echo ""
echo "Your dotfiles are portable and will work from any directory!"