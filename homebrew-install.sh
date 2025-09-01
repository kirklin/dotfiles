#!/bin/bash

# Homebrew Installation Script
#
# This script installs Homebrew and, optionally, a list of CLI and GUI applications.
# It supports flags for enabling a proxy and using a Chinese mirror for faster downloads.

# --- Default Configuration ---
INSTALL_CLI="false"
INSTALL_GUI="false"
USE_PROXY="false"
USE_CN_MIRROR="false"

# --- Help Function ---
usage() {
  echo "Usage: $0 [options]"
  echo
  echo "Options:"
  echo "  -c, --cli          Install command-line interface (CLI) tools."
  echo "  -g, --gui          Install graphical user interface (GUI) applications (casks)."
  echo "  -p, --proxy        Enable proxy (http://127.0.0.1:7890) for the session."
  echo "  -m, --mirror       Use Chinese mirror (USTC) for Homebrew."
  echo "  -h, --help         Display this help message."
  echo
  echo "Example: To install both CLI and GUI apps using the Chinese mirror:"
  echo "  $0 --cli --gui --mirror"
  exit 1
}

# --- Argument Parsing ---
if [ "$#" -eq 0 ]; then
    usage
fi

while [[ "$#" -gt 0 ]]; do
  case $1 in
    -c|--cli) INSTALL_CLI="true"; shift ;;
    -g|--gui) INSTALL_GUI="true"; shift ;;
    -p|--proxy) USE_PROXY="true"; shift ;;
    -m|--mirror) USE_CN_MIRROR="true"; shift ;;
    -h|--help) usage ;;
    *) echo "Unknown parameter passed: $1"; usage ;;
  esac
done


# --- Pre-flight Checks ---
# Check for Xcode Command Line Tools
if ! xcode-select -p &> /dev/null; then
  echo "Xcode Command Line Tools are not installed. Please run 'xcode-select --install' and then re-run this script."
  exit 1
fi


# --- Execution ---
# Apply Chinese Mirror Settings if enabled
if [ "$USE_CN_MIRROR" = "true" ]; then
  export HOMEBREW_INSTALL_FROM_API=1
  export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
  export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
  export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
  export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
  echo "Using Chinese mirror for Homebrew."
fi

# Apply Proxy Settings if enabled
if [ "$USE_PROXY" = "true" ]; then
  export https_proxy=http://127.0.0.1:7890
  export http_proxy=http://127.0.0.1:7890
  export all_proxy=socks5://127.0.0.1:7890
  echo "Proxy enabled for this session."
fi


# Install Homebrew if not already installed
if ! command -v brew &> /dev/null
then
  echo "Homebrew not found, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed"
fi

# Update Homebrew
brew update

# Install CLI tools if requested
if [ "$INSTALL_CLI" = "true" ]; then
  echo "Installing CLI tools..."
  brew install \
    autojump \
    bat \
    diff-so-fancy \
    fd \
    ffmpeg \
    fzf \
    go \
    gh \
    git \
    mkcert \
    nvm \
    openjdk \
    starship \
    tldr \
    tree \
    wget
fi

# Install GUI applications if requested
if [ "$INSTALL_GUI" = "true" ]; then
  echo "Installing GUI applications..."
  brew install --cask \
    adobe-creative-cloud \
    adobe-creative-cloud-cleaner-tool \
    adrive \
    android-platform-tools \
    android-studio \
    baidunetdisk \
    battle-net \
    bob \
    claude \
    clion \
    cursor \
    datagrip \
    feishu \
    figma \
    flutter \
    git-credential-manager \
    github \
    google-chrome \
    goland \
    gstreamer-runtime \
    iina \
    intellij-idea \
    motrix \
    obs \
    obsidian \
    ollama \
    orbstack \
    postman \
    pycharm \
    raspberry-pi-imager \
    raycast \
    rustrover \
    sourcetree \
    steam \
    tencent-lemon \
    visual-studio-code \
    warp \
    webstorm \
    wechatwebdevtools \
    wireshark
fi

echo "Script finished."
