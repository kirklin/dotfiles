#!/bin/bash

# Main setup script for a complete developer environment on macOS.

echo "🚀 Starting full environment setup..."

# --- Step 1: Install Oh My Zsh (if not installed) ---
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "✅ Oh My Zsh is already installed."
else
  echo "📦 Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  if [ $? -ne 0 ]; then
    echo "❌ Failed to install Oh My Zsh. Aborting."
    exit 1
  fi
fi

# --- Step 2: Install Homebrew and Essential CLI Tools ---
chmod +x ./homebrew-install.sh
echo "📦 Running Homebrew installer for CLI tools..."
# We run with --cli to get essential tools like git, nvm, etc.
# --mirror is used for faster downloads in China.
./homebrew-install.sh --cli --mirror
if [ $? -ne 0 ]; then
  echo "❌ Homebrew script failed. Aborting."
  exit 1
fi

# --- Step 3: Create Development Directories ---
echo "📂 Creating development directories..."
mkdir -p "$HOME/go"
mkdir -p "$HOME/Code/projects"
mkdir -p "$HOME/Code/forks"
mkdir -p "$HOME/Code/repros"
echo "  -> Created ~/go, ~/Code/projects, ~/Code/forks, ~/Code/repros"

# --- Step 4: Install Zsh Theme and Plugins ---
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
echo "🎨 Installing Zsh theme and plugins..."

# Install spaceship-prompt theme
if [ ! -d "$ZSH_CUSTOM/themes/spaceship-prompt" ]; then
  echo "  -> Installing spaceship-prompt theme..."
  git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
else
  echo "  -> spaceship-prompt theme already exists."
fi

# Install zsh-autosuggestions plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "  -> Installing zsh-autosuggestions plugin..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
  echo "  -> zsh-autosuggestions plugin already exists."
fi

# Install zsh-syntax-highlighting plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "  -> Installing zsh-syntax-highlighting plugin..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
  echo "  -> zsh-syntax-highlighting plugin already exists."
fi

# Install zsh-completions plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
  echo "  -> Installing zsh-completions plugin..."
  git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
else
  echo "  -> zsh-completions plugin already exists."
fi

# Install zsh-z plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-z" ]; then
  echo "  -> Installing zsh-z plugin..."
  git clone https://github.com/agkozak/zsh-z "$ZSH_CUSTOM/plugins/zsh-z"
else
  echo "  -> zsh-z plugin already exists."
fi

# --- Step 5: Copy .zshrc Configuration ---
ZSHRC_PATH="$HOME/.zshrc"
ZSHRC_BACKUP_PATH="$HOME/.zshrc.pre-dotfiles.bak"

echo "⚙️  Setting up .zshrc..."
# Backup existing .zshrc file
if [ -f "$ZSHRC_PATH" ]; then
  echo "  -> Found existing .zshrc. Backing it up to $ZSHRC_BACKUP_PATH"
  mv "$ZSHRC_PATH" "$ZSHRC_BACKUP_PATH"
fi

# Copy the .zshrc from the repository
echo "  -> Copying repository's .zshrc to $ZSHRC_PATH"
cp "$(pwd)/.zshrc" "$ZSHRC_PATH"

# --- Step 6: Install Global NPM Packages ---
echo "🌐 Installing global NPM packages..."
# Source nvm to use it in this script
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

# Install the latest LTS version of Node.js and set it as the default
echo "  -> Installing latest LTS Node.js version via nvm..."
nvm install --lts
echo "  -> Setting the LTS version as the default Node.js version..."
nvm alias default lts/*

# Install the packages
echo "  -> Installing global npm packages..."
npm install -g @antfu/ni live-server

# --- Final Step ---
echo ""
echo "🎉 Setup complete!"
echo "Please restart your terminal or run 'source ~/.zshrc' to apply all changes."
