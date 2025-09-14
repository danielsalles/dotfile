# 🚀 Daniel's Dotfiles

> Modern macOS development environment with Zsh, Oh My Zsh, Starship, and iTerm2

![macOS](https://img.shields.io/badge/macOS-12+-blue)
![Shell](https://img.shields.io/badge/Shell-Zsh-green)
![Terminal](https://img.shields.io/badge/Terminal-iTerm2-orange)

## ✨ Features

- **🎨 Dracula Theme** - Consistent dark theme across all tools
- **⚡ Fast Shell** - Optimized plugins with async loading
- **🔧 Automated Setup** - Single command installation
- **📦 Homebrew Bundle** - Reproducible package management
- **🚀 Modern CLI Tools** - eza, bat, ripgrep, fd, and more
- **🧠 Smart Navigation** - Zoxide for intelligent directory jumping
- **💻 LazyVim IDE** - Full Neovim IDE experience in terminal
- **🔍 Dynamic Paths** - Works from any clone location

## 🚀 Quick Install

```bash
# Clone and install
git clone https://github.com/danielsalles/dotfile.git ~/dotfiles && cd ~/dotfiles && ./install.sh

# Or using Make
git clone https://github.com/danielsalles/dotfile.git ~/dotfiles && cd ~/dotfiles && make install
```

## ⚠️ Required Manual Configuration

### iTerm2 Font Setup
After installation, configure iTerm2 to display icons correctly:

1. Open iTerm2 → Preferences (`Cmd+,`)
2. Go to **Profiles → Text**
3. Change font to **"Hack Nerd Font"**
4. Recommended size: 13-14pt
5. Restart iTerm2

Without this, you'll see boxes/question marks instead of icons.

## 📋 What's Included

### Shell & Plugins
**Oh My Zsh plugins configured:**
- `git` - Git aliases and functions
- `extract` - Extract any archive format
- `nvm` - Node Version Manager integration
- `thefuck` - Command correction
- `eza` - Integration with eza command
- `fzf-tab` - Fuzzy completion
- `zsh-autosuggestions` - Fish-like suggestions
- `you-should-use` - Alias reminders
- `zsh-syntax-highlighting` - Command highlighting

### Terminal Tools
- **[eza](https://github.com/eza-community/eza)** - Modern ls replacement with icons
- **[bat](https://github.com/sharkdp/bat)** - Enhanced cat with syntax highlighting
- **[starship](https://starship.rs)** - Cross-shell prompt
- **[zoxide](https://github.com/ajeetdsouza/zoxide)** - Smarter cd command
- **[fzf](https://github.com/junegunn/fzf)** - Fuzzy finder
- **[ripgrep](https://github.com/BurntSushi/ripgrep)** - Ultra-fast grep
- **[fd](https://github.com/sharkdp/fd)** - User-friendly find
- **[thefuck](https://github.com/nvbn/thefuck)** - Command correction

### Development Tools
- **Git** - Version control with custom aliases
- **Node.js** - JavaScript runtime
- **Python** - For various CLI tools
- **Neovim** - Modern Vim fork
- **Lazygit** - Terminal UI for Git

### LazyVim IDE
- Full IDE experience with LSP support
- Language servers for JS/TS, Python, Lua, and more
- Telescope fuzzy finder
- Treesitter syntax highlighting
- Git integration with Gitsigns

## 📁 Repository Structure

```
dotfiles/
├── Brewfile              # Homebrew packages
├── Makefile              # Automation commands
├── README.md             # This file
├── install.sh            # Main installation script
├── config/               # Application configurations
│   ├── starship.toml     # Starship prompt config
│   ├── nvim/             # Neovim/LazyVim config
│   └── iterm2/           # iTerm2 configurations
│       └── key-mappings.json
├── git/                  # Git configuration
│   ├── .gitconfig        # Git config
│   └── .gitignore_global # Global gitignore
├── macos/                # macOS specific
│   └── set-defaults.sh   # macOS preferences
├── scripts/              # Helper scripts
│   ├── install-plugins.sh     # Oh My Zsh plugins
│   ├── install-lazyvim.sh     # LazyVim setup
│   ├── setup-iterm2.sh        # iTerm2 config
│   └── validate-setup.sh      # Validation tool
└── zsh/                  # Zsh configuration
    ├── .zshrc            # Main Zsh config
    ├── aliases.zsh       # Custom aliases
    └── functions.zsh     # Custom functions
```

## 🛠️ Installation Details

The install script will:
1. ✅ Install Homebrew (if not installed)
2. ✅ Install all packages from Brewfile
3. ✅ Install Oh My Zsh framework
4. ✅ Clone and install custom Zsh plugins
5. ✅ Create symlinks for all configurations
6. ✅ Configure dynamic DOTFILES_DIR for portability
7. ✅ Install NVM for Node.js management
8. ✅ Set up iTerm2 key mappings
9. ✅ Configure LazyVim (optional)
10. ✅ Apply macOS defaults (optional)

## ⚙️ Configuration

### Key Aliases

**eza (ls replacement):**
- `ls` - List files vertically with icons
- `ll` - Long format with details
- `la` - Show all including hidden
- `lt` - Tree view (2 levels)
- `tree` - Full tree with icons

**bat (cat replacement):**
- `b` - Quick view with Dracula theme
- `bcat` - Plain output (cat compatible)
- `bathelp` - List available themes

**Navigation:**
- `..` - Go up one directory
- `...` - Go up two directories
- `-` - Go to previous directory

### Custom Functions
- `mkd` - Create directory and enter it
- `extract` - Extract any archive format
- `ff` - Find files by name
- `fd` - Find directories by name

### Adding Your Own

```bash
# Add aliases to zsh/aliases.zsh
alias myalias='my command'

# Add functions to zsh/functions.zsh
function myfunction() {
    # your code
}

# Add packages to Brewfile
brew "package-name"
```

## 🎨 Themes

All tools are configured with the **Dracula** dark theme for consistency:
- Starship prompt (config/starship.toml)
- Bat syntax highlighting
- LazyVim editor theme
- iTerm2 (manual import required)

To import iTerm2 Dracula theme:
1. Download from [draculatheme.com/iterm](https://draculatheme.com/iterm)
2. iTerm2 → Preferences → Profiles → Colors → Import

## 💻 LazyVim Usage

### Key Bindings
- `Space` - Leader key
- `Space e` - File explorer
- `Space ff` - Find files
- `Space fg` - Live grep
- `Space gg` - Open Lazygit
- `K` - Hover documentation
- `gd` - Go to definition

### First Time Setup
1. Run `nvim` after installation
2. Wait for plugins to install automatically
3. Restart Neovim
4. Run `:checkhealth` to verify

## 🔧 Useful Commands

```bash
# Update everything
make update

# Backup current configs
make backup

# Validate installation
make doctor
./scripts/validate-setup.sh

# Test portability
./scripts/validate-setup.sh --test-clone

# Clean broken symlinks
make clean
```

## 🐛 Troubleshooting

### Icons not showing?
Ensure iTerm2 is using "Hack Nerd Font" (see Required Manual Configuration above)

### Plugins not loading?
```bash
./scripts/install-plugins.sh
source ~/.zshrc
```

### Command not found?
```bash
brew bundle --file=Brewfile
source ~/.zshrc
```

### Permission denied?
```bash
chmod +x install.sh scripts/*.sh macos/*.sh
```

## 📝 Post-Installation

1. **Configure Git:**
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

2. **Import iTerm2 theme** (optional - see Themes section)

3. **Customize as needed** (see Configuration section)

## 🤝 Contributing

Feel free to fork and customize for your own use!

## 📄 License

MIT - See [LICENSE](LICENSE) file

## 🙏 Acknowledgments

Inspired by:
- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles) - macOS defaults script
- [holman/dotfiles](https://github.com/holman/dotfiles) - Topic-centric organization
- [Dracula Theme](https://draculatheme.com) - Beautiful dark theme

---

**⭐ If you find this useful, please consider giving it a star!**