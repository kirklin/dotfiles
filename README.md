# Kirk Lin's Dotfiles

This repository contains my personal dotfiles and setup instructions for zsh and other tools.

## Installation Steps

### 1. Install zsh and Oh My Zsh
Run the following command to install Oh My Zsh:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

After installation, update Oh My Zsh and reload your configuration:

```bash
omz update
source ~/.zshrc
```

### 2. Install Starship Prompt

Starship is a fast and highly customizable prompt written in Rust. Install it using Homebrew:

```zsh
brew install starship
```

Add the following line to your .zshrc to initialize Starship:

```zsh
eval "$(starship init zsh)"
```

### 3. Install Useful zsh Plugins

I use the following plugins to enhance the zsh experience:
	- zsh-autosuggestions
	- zsh-completions
	- zsh-syntax-highlighting

Clone these plugins into your Oh My Zsh custom plugins directory:

```zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Configuration Files

	•	View my .zshrc configuration

### Check Also

- [kirklin/dotfiles](https://github.com/kirklin/dotfiles) - My dotfiles
- [kirklin/vscode-settings](https://github.com/kirklin/vscode-settings) - My VS Code settings
- [kirklin/eslint-config](https://github.com/kirklin/eslint-config) - My ESLint config
- [kirklin/ts-starter](https://github.com/kirklin/boot-ts) - My starter template for TypeScript library

This README outlines the essential steps for setting up zsh, Oh My Zsh, and Starship, as well as installing useful plugins for an enhanced command-line experience.

Feel free to copy and use this markdown content directly!
