.PHONY: help install update backup clean test brew-update symlinks plugins macos

# Default target
help: ## Show this help message
	@echo "Available commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: ## Run full installation
	@echo "🚀 Starting Dotfiles Installation..."
	@./install.sh

update: ## Update Homebrew packages and Oh My Zsh plugins
	@echo "📦 Updating Homebrew packages..."
	@brew update
	@brew upgrade
	@brew bundle --file=Brewfile
	@echo "🔌 Updating Oh My Zsh plugins..."
	@./scripts/install-plugins.sh
	@echo "✅ Update complete!"

backup: ## Backup current dotfiles
	@echo "💾 Backing up current dotfiles..."
	@mkdir -p backup
	@cp ~/.zshrc backup/.zshrc.$(shell date +%Y%m%d_%H%M%S) 2>/dev/null || true
	@cp ~/.config/starship.toml backup/starship.toml.$(shell date +%Y%m%d_%H%M%S) 2>/dev/null || true
	@cp ~/.gitconfig backup/.gitconfig.$(shell date +%Y%m%d_%H%M%S) 2>/dev/null || true
	@echo "✅ Backup complete! Files saved in ./backup/"

clean: ## Clean broken symlinks and backup files
	@echo "🧹 Cleaning broken symlinks..."
	@find ~ -maxdepth 1 -type l -exec test ! -e {} \; -delete 2>/dev/null || true
	@echo "✅ Cleanup complete!"

test: ## Test if all configurations are valid
	@echo "🧪 Testing configurations..."
	@echo -n "Testing Zsh syntax... "
	@zsh -n zsh/.zshrc && echo "✅" || echo "❌"
	@echo -n "Testing Starship config... "
	@starship config && echo "✅" || echo "❌"
	@echo -n "Testing Git config... "
	@git config --file=git/.gitconfig --list > /dev/null && echo "✅" || echo "❌"

brew-update: ## Update Brewfile with currently installed packages
	@echo "📝 Updating Brewfile..."
	@brew bundle dump --file=Brewfile --force --describe
	@echo "✅ Brewfile updated!"

symlinks: ## Create symlinks for dotfiles
	@echo "🔗 Creating symlinks..."
	@ln -sf $(PWD)/zsh/.zshrc ~/.zshrc
	@ln -sf $(PWD)/config/starship.toml ~/.config/starship.toml
	@ln -sf $(PWD)/git/.gitconfig ~/.gitconfig
	@ln -sf $(PWD)/git/.gitignore_global ~/.gitignore_global
	@echo "✅ Symlinks created!"

plugins: ## Install Oh My Zsh plugins
	@echo "🔌 Installing Oh My Zsh plugins..."
	@./scripts/install-plugins.sh

macos: ## Set macOS defaults
	@echo "🍎 Setting macOS defaults..."
	@./macos/set-defaults.sh

doctor: ## Check if everything is installed correctly
	@echo "🏥 Running diagnostics..."
	@echo ""
	@echo "Checking required tools:"
	@command -v brew >/dev/null 2>&1 && echo "✅ Homebrew" || echo "❌ Homebrew"
	@command -v zsh >/dev/null 2>&1 && echo "✅ Zsh" || echo "❌ Zsh"
	@command -v starship >/dev/null 2>&1 && echo "✅ Starship" || echo "❌ Starship"
	@command -v zoxide >/dev/null 2>&1 && echo "✅ Zoxide" || echo "❌ Zoxide"
	@command -v fzf >/dev/null 2>&1 && echo "✅ fzf" || echo "❌ fzf"
	@command -v fuck >/dev/null 2>&1 && echo "✅ TheFuck" || echo "❌ TheFuck"
	@command -v git >/dev/null 2>&1 && echo "✅ Git" || echo "❌ Git"
	@command -v node >/dev/null 2>&1 && echo "✅ Node.js" || echo "❌ Node.js"
	@echo ""
	@echo "Checking configurations:"
	@test -f ~/.zshrc && echo "✅ .zshrc" || echo "❌ .zshrc"
	@test -f ~/.config/starship.toml && echo "✅ starship.toml" || echo "❌ starship.toml"
	@test -d ~/.oh-my-zsh && echo "✅ Oh My Zsh" || echo "❌ Oh My Zsh"
	@test -d ~/.nvm && echo "✅ NVM" || echo "❌ NVM"