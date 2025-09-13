#!/usr/bin/env bash

# iTerm2 Configuration Setup Script

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

echo "🎨 Configuring iTerm2..."

# 1. Enable Natural Text Editing preset
print_info "Setting up Natural Text Editing preset..."

# This enables the Natural Text Editing preset programmatically
/usr/libexec/PlistBuddy -c "Delete :New\ Bookmarks:0:Keyboard\ Map" ~/Library/Preferences/com.googlecode.iterm2.plist 2>/dev/null || true

# Add Natural Text Editing key mappings
defaults write com.googlecode.iterm2 "New Bookmarks" -array-add '{
  "Keyboard Map" = {
    "0x9-0x40000-0x0" = {
      "Action" = 32;
      "Text" = "";
    };
    "0xf700-0x220000-0x0" = {
      "Action" = 10;
      "Text" = "[1;2A";
    };
    "0xf700-0x240000-0x0" = {
      "Action" = 10;
      "Text" = "[1;5A";
    };
    "0xf700-0x260000-0x0" = {
      "Action" = 10;
      "Text" = "[1;6A";
    };
    "0xf700-0x280000-0x0" = {
      "Action" = 10;
      "Text" = "[1;3A";
    };
    "0xf701-0x220000-0x0" = {
      "Action" = 10;
      "Text" = "[1;2B";
    };
    "0xf701-0x240000-0x0" = {
      "Action" = 10;
      "Text" = "[1;5B";
    };
    "0xf701-0x260000-0x0" = {
      "Action" = 10;
      "Text" = "[1;6B";
    };
    "0xf701-0x280000-0x0" = {
      "Action" = 10;
      "Text" = "[1;3B";
    };
    "0xf702-0x220000-0x0" = {
      "Action" = 10;
      "Text" = "[1;2D";
    };
    "0xf702-0x240000-0x0" = {
      "Action" = 10;
      "Text" = "[1;5D";
    };
    "0xf702-0x260000-0x0" = {
      "Action" = 10;
      "Text" = "[1;6D";
    };
    "0xf702-0x280000-0x0" = {
      "Action" = 10;
      "Text" = "b";
    };
    "0xf702-0x300000-0x0" = {
      "Action" = 11;
      "Text" = "0x01";
    };
    "0xf702-0x320000-0x0" = {
      "Action" = 10;
      "Text" = "[1;2H";
    };
    "0xf703-0x220000-0x0" = {
      "Action" = 10;
      "Text" = "[1;2C";
    };
    "0xf703-0x240000-0x0" = {
      "Action" = 10;
      "Text" = "[1;5C";
    };
    "0xf703-0x260000-0x0" = {
      "Action" = 10;
      "Text" = "[1;6C";
    };
    "0xf703-0x280000-0x0" = {
      "Action" = 10;
      "Text" = "f";
    };
    "0xf703-0x300000-0x0" = {
      "Action" = 11;
      "Text" = "0x05";
    };
    "0xf703-0x320000-0x0" = {
      "Action" = 10;
      "Text" = "[1;2F";
    };
    "0xf728-0x0-0x0" = {
      "Action" = 11;
      "Text" = "0x04";
    };
    "0xf728-0x80000-0x0" = {
      "Action" = 11;
      "Text" = "0x1b 0x64";
    };
    "0xf729-0x20000-0x0" = {
      "Action" = 10;
      "Text" = "[H";
    };
    "0xf729-0x40000-0x0" = {
      "Action" = 10;
      "Text" = "[H";
    };
    "0xf72b-0x20000-0x0" = {
      "Action" = 10;
      "Text" = "[F";
    };
    "0xf72b-0x40000-0x0" = {
      "Action" = 10;
      "Text" = "[F";
    };
  };
}'

print_success "Natural Text Editing configured"

# 2. Set iTerm2 to use custom preferences folder
print_info "Setting custom preferences folder..."
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "${DOTFILES_DIR}/config/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
print_success "Custom preferences folder set"

# 3. Enable Copy Mode for keyboard selection
print_info "Enabling keyboard selection features..."
defaults write com.googlecode.iterm2 CopySelection -bool true
defaults write com.googlecode.iterm2 AllowClipboardAccess -bool true
print_success "Keyboard selection features enabled"

# 4. Install Dracula theme if not present
if [ ! -f ~/Library/Application\ Support/iTerm2/DynamicProfiles/Dracula.json ]; then
    print_info "Installing Dracula theme..."
    mkdir -p ~/Library/Application\ Support/iTerm2/DynamicProfiles
    curl -fsSL https://raw.githubusercontent.com/dracula/iterm/master/Dracula.itermcolors -o /tmp/Dracula.itermcolors
    print_success "Dracula theme downloaded"
else
    print_success "Dracula theme already installed"
fi

echo ""
echo "======================================"
echo -e "${GREEN}✨ iTerm2 configuration complete!${NC}"
echo ""
echo "⚠️  IMPORTANT: Selection with Shift+Arrow keys requires:"
echo ""
echo "1. Enable 'Applications in terminal may access clipboard' in:"
echo "   iTerm2 → Preferences → General → Selection"
echo ""
echo "2. Your shell/app must support ANSI escape sequences for selection"
echo "   (Works best with vim, emacs, and apps that support it)"
echo ""
echo "3. For basic selection, you can also use:"
echo "   - Mouse selection (click and drag)"
echo "   - Copy Mode: Edit → Copy Mode (or ⌘⇧C)"
echo "   - Then use arrow keys to select"
echo ""
echo "4. Restart iTerm2 for all changes to take effect"