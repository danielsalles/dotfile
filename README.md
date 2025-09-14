# 🚀 Daniel's Dotfiles

> Personal dotfiles for macOS development environment with Zsh, Oh My Zsh, Starship, and iTerm2

![macOS](https://img.shields.io/badge/macOS-Monterey+-blue)
![Shell](https://img.shields.io/badge/Shell-Zsh-green)
![Terminal](https://img.shields.io/badge/Terminal-iTerm2-orange)

## ✨ Features

- **🎨 Dracula Theme** everywhere (iTerm2, Starship)
- **⚡ Fast** shell with optimized plugins and async loading
- **🔧 Automated** setup with single command installation
- **📦 Homebrew Bundle** for consistent package management
- **🚀 Starship Prompt** with custom Dracula theme
- **🧠 Smart Navigation** with Zoxide
- **✨ Enhanced Terminal** with syntax highlighting and autosuggestions
- **🛠️ Developer Tools** pre-configured

## 📋 What's Included

### Shell (Zsh + Oh My Zsh)
- **Plugins:**
  - `git` - Git aliases and functions
  - `extract` - Extract any archive format
  - `nvm` - Node Version Manager integration
  - `thefuck` - Command correction
  - `fzf-tab` - Fuzzy completion
  - `zsh-autosuggestions` - Fish-like suggestions
  - `you-should-use` - Alias reminders
  - `zsh-syntax-highlighting` - Syntax highlighting

### Terminal Tools
- **Starship** - Cross-shell prompt with Dracula theme
- **Zoxide** - Smarter `cd` command
- **fzf** - Fuzzy finder
- **TheFuck** - Corrects console commands

### Development
- **Git** - Version control with custom aliases
- **Node.js** - JavaScript runtime
- **NVM** - Node version management
- **Neovim + LazyVim** - Modern IDE in the terminal

### Editor (LazyVim)
- **Neovim 0.11+** with LazyVim configuration
- **LSP Support** for JavaScript, TypeScript, Python, Lua, and more
- **Dracula Theme** consistent with terminal
- **Telescope** for fuzzy finding
- **Treesitter** for better syntax highlighting
- **Git Integration** with Gitsigns and Lazygit

### Fonts
- **Hack Nerd Font** - Terminal font with icons

## 🚀 Quick Install

### One-liner Installation
```bash
git clone https://github.com/danielsalles/dotfile.git ~/dotfiles && cd ~/dotfiles && ./install.sh
```

### Using Make
```bash
git clone https://github.com/danielsalles/dotfile.git ~/dotfiles
cd ~/dotfiles
make install
```

## ⚠️ Required Manual Configuration

### iTerm2 Font Setup (for icons support)
After installation, you need to configure iTerm2 to use the Nerd Font for icons to display correctly:

1. Open iTerm2
2. Press `Cmd + ,` to open Preferences
3. Go to **Profiles → Text**
4. Click on **Font** and select **"Hack Nerd Font"** or **"Hack Nerd Font Mono"**
5. Recommended size: 13-14pt
6. Restart iTerm2

Without this configuration, you'll see boxes or question marks instead of icons in `eza`, `starship`, and other tools.

## 📖 Manual Installation

1. **Clone the repository:**
```bash
git clone https://github.com/danielsalles/dotfile.git ~/dotfiles
cd ~/dotfiles
```

2. **Run the installation script:**
```bash
./install.sh
```

3. **Restart your terminal or reload configuration:**
```bash
source ~/.zshrc
```

## 🛠️ What Does the Install Script Do?

1. ✅ Installs Homebrew (if not installed)
2. ✅ Installs all packages from `Brewfile`
3. ✅ Installs Oh My Zsh
4. ✅ Clones and installs custom Zsh plugins
5. ✅ Creates symlinks for all configurations
6. ✅ Installs NVM for Node.js management
7. ✅ Optionally sets macOS defaults
8. ✅ Configures iTerm2 preferences
9. ✅ Installs and configures LazyVim (Neovim IDE)

## 📁 Repository Structure

```
dotfiles/
├── Brewfile              # Homebrew packages
├── Makefile             # Automation commands
├── README.md            # This file
├── install.sh           # Main installation script
├── config/              # Application configurations
│   ├── starship.toml   # Starship prompt config
│   └── iterm2/         # iTerm2 preferences
├── git/                 # Git configuration
│   ├── .gitconfig      # Git config
│   └── .gitignore_global # Global gitignore
├── macos/               # macOS specific
│   └── set-defaults.sh # macOS preferences
├── scripts/             # Helper scripts
│   └── install-plugins.sh # Oh My Zsh plugins installer
└── zsh/                 # Zsh configuration
    ├── .zshrc          # Main Zsh config
    ├── aliases.zsh     # Custom aliases
    ├── functions.zsh   # Custom functions
    └── plugins.txt     # Plugin list

```

## ⚙️ Customization

### Adding New Aliases
Edit `zsh/aliases.zsh` and add your custom aliases:
```bash
alias myalias='my command'
```

### Adding New Functions
Edit `zsh/functions.zsh` and add your custom functions:
```bash
function myfunction() {
    # your code here
}
```

### Installing Additional Packages
Add packages to `Brewfile`:
```ruby
brew "package-name"
cask "app-name"
```

Then run:
```bash
brew bundle
```

## 🎨 Themes

### iTerm2 Configuration
The dotfiles include advanced iTerm2 configurations:

#### Natural Text Editing & IDE-like Key Bindings
- **Configured automatically** during installation
- Enables IDE-style text selection and navigation:
  - `⌘←/→` - Jump to beginning/end of line
  - `⌥←/→` - Jump by words
  - `⇧←/→` - Select characters
  - `⌘⇧←/→` - Select to beginning/end of line
  - `⌥⇧←/→` - Select by words
  - `⌘A` - Select all
  - `⌘Z` - Undo

**Note**: Full text selection with Shift+Arrow keys has limitations in terminal emulators. For best results:
1. Use iTerm2's Copy Mode: `Edit → Copy Mode` or `⌘⇧C`
2. Use mouse selection
3. Consider using Warp terminal for full IDE features

#### iTerm2 Dracula Theme
1. Open iTerm2 Preferences (`⌘,`)
2. Go to Profiles → Colors
3. Import Dracula theme from [Dracula Theme](https://draculatheme.com/iterm)
4. Or it will be installed automatically by the setup script

### Starship Dracula Theme
Already configured in `config/starship.toml` with custom Dracula palette.

## 💻 LazyVim (Neovim IDE)

### Features
- **Full IDE Experience** in the terminal
- **Dracula Theme** matching your terminal theme
- **LSP Support** with auto-completion and diagnostics
- **File Explorer** with Neo-tree
- **Fuzzy Finding** with Telescope
- **Git Integration** with Gitsigns and Lazygit
- **Fast Startup** < 50ms

### Key Bindings
- `Space` - Leader key
- `Space e` - File explorer (Neo-tree)
- `Space f f` - Find files (Telescope)
- `Space f g` - Live grep in files
- `Space g g` - Open Lazygit
- `Space l` - Lazy plugin manager
- `Space c` - Code actions
- `K` - Hover documentation
- `gd` - Go to definition
- `gr` - Go to references

### First Time Setup
When you first open Neovim after installation:
1. LazyVim will automatically install all plugins
2. Wait for installation to complete
3. Restart Neovim
4. Run `:checkhealth` to verify everything is working

### Customization
- Custom plugins go in `config/nvim/lua/plugins/`
- Override LazyVim defaults in `config/nvim/lua/config/`
- LSP servers configuration in `config/nvim/lua/plugins/lsp.lua`

## 🔧 Useful Commands

```bash
# Update all Homebrew packages
make update

# Backup current dotfiles
make backup

# Clean up broken symlinks
make clean

# Show all make commands
make help
```

## 🐛 Troubleshooting

### Zsh plugins not loading
```bash
# Reinstall plugins
./scripts/install-plugins.sh
```

### Command not found errors
```bash
# Reload shell configuration
source ~/.zshrc
```

### Permission denied on scripts
```bash
# Make scripts executable
chmod +x install.sh scripts/*.sh macos/*.sh
```

## 📝 Manual Steps After Installation

1. **Configure Git user:**
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

2. **Import iTerm2 Dracula theme:**
   - Download from https://draculatheme.com/iterm
   - Import in iTerm2 Preferences → Profiles → Colors

3. **Set iTerm2 font:**
   - Go to iTerm2 Preferences → Profiles → Text
   - Select "Hack Nerd Font"

## 🤝 Contributing

Feel free to fork this repository and customize it for your own use!

## 📄 License

MIT - See [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

This dotfiles repository structure and organization is heavily inspired by the best practices from:

- **[mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)** - The legendary dotfiles repository by Mathias Bynens, especially the bootstrap approach and macOS defaults script
- **[holman/dotfiles](https://github.com/holman/dotfiles)** - Zach Holman's topic-centric dotfiles organization, which inspired the modular structure
- **[Dracula Theme](https://draculatheme.com)** - The beautiful dark theme used throughout the setup

Special thanks to these developers for sharing their configurations and making the community better!

---

**⭐ If you find this useful, please consider giving it a star!**