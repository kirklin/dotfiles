# Kirk Lin's Dotfiles

This repository contains my personal dotfiles and automated installation scripts designed to provision a complete, highly-customized development environment on macOS from scratch.

## Automated Deployment

To fully bootstrap the macOS environment, simply run the primary setup script. Ensure the scripts have the correct execution permissions before proceeding.

### Prerequisites

Before launching the setup scripts, ensure that your system is up to date and that the Xcode Command Line Tools are installed:

```bash
xcode-select --install
```

### Running the Setup

```bash
# Grant execution permissions
chmod +x setup.sh homebrew-install.sh

# Run the complete setup
./setup.sh
```

**What does `setup.sh` do?**

1. **Zsh Core**: Installs Oh My Zsh.
2. **Package Manager**: Triggers `homebrew-install.sh` to install foundational CLI utilities.
3. **Workspace Initialization**: Provisions standard developer directories (`~/Code/projects`, `~/Code/forks`, etc.).
4. **Shell Customization**: Installs necessary Zsh plugins (e.g., `spaceship-prompt`, `zsh-autosuggestions`, `zsh-syntax-highlighting`).
5. **Configuration Linking**: Backs up your existing `.zshrc` and links the one provided in this repository.
6. **Node.js Environment**: Sets up `nvm`, installs the latest LTS Node.js release, and installs essential global npm packages.

---

## Standalone Homebrew Installer (`homebrew-install.sh`)

This repository includes a script `homebrew-install.sh` to automate the installation of Homebrew and various applications.

### Usage

The script is controlled via command-line flags. Before running, ensure it has execution permissions:

```bash
chmod +x homebrew-install.sh
```

Then, run the script with the desired options:

```bash
./homebrew-install.sh [options]
```

**Options:**

| Flag             | Description                                                   |
| ---------------- | ------------------------------------------------------------- |
| `-c`, `--cli`    | Install command-line interface (CLI) tools.                   |
| `-g`, `--gui`    | Install graphical user interface (GUI) applications (casks).  |
| `-f`, `--fonts`   | Install essential developer fonts (Nerd Fonts).               |
| `-a`, `--mas`     | Install Mac App Store apps (requires 'mas' CLI).              |
| `-p`, `--proxy`  | Enable proxy (`http://127.0.0.1:7890`) for the session.       |
| `-m`, `--mirror` | Use Chinese mirror (USTC) for Homebrew for faster downloads.  |
| `-h`, `--help`   | Display the help message.                                     |

**Example:**

To install CLI tools, GUI applications, and developer fonts using the Chinese mirror, run:

```bash
./homebrew-install.sh --cli --gui --fonts --mirror
```

**Note:** The script will check if Xcode Command Line Tools are installed. If not, it will prompt you to install them first by running `xcode-select --install`.

---

## Manual Installation Steps

If you prefer to configure your environment manually instead of using the automated scripts, follow these instructions.

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

Add the following line to your `.zshrc` to initialize Starship:

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

  - View my `.zshrc` configuration

---

## Check Also

- [kirklin/dotfiles](https://github.com/kirklin/dotfiles) - My dotfiles
- [kirklin/vscode-settings](https://github.com/kirklin/vscode-settings) - My VS Code settings
- [kirklin/eslint-config](https://github.com/kirklin/eslint-config) - My ESLint config
- [kirklin/ts-starter](https://github.com/kirklin/boot-ts) - My starter template for TypeScript library

This README outlines the essential steps for setting up zsh, Oh My Zsh, and Starship, as well as installing useful plugins for an enhanced command-line experience.

Feel free to copy and use this markdown content directly!
