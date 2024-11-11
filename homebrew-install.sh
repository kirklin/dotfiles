#!/bin/bash

# Homebrew Installation Script
# This script sets up a proxy, installs Homebrew, and then installs a list of GUI applications and CLI tools using Homebrew.

# Enable proxy before running Homebrew commands to enhance download speed
export https_proxy=http://127.0.0.1:7890
export http_proxy=http://127.0.0.1:7890
export all_proxy=socks5://127.0.0.1:7890
echo "Proxy enabled: http://127.0.0.1:7890"

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

# Install GUI applications
brew install --cask \
  battle-net \
  bob \
  clion \
  datagrip \
  docker \
  feishu \
  figma \
  goland \
  google-chrome \
  github \
  intellij-idea \
  microsoft-edge \
  microsoft-remote-desktop \
  obs \
  obsidian \
  raycast \
  rustrover \
  sourcetree \
  sogouinput \
  tencent-lemon \
  visual-studio-code \
  webstorm \
  wechat \
  wechatwebdevtools \
  warp

# Install CLI tools
brew install \
  autojump \
  bat \
  diff-so-fancy \
  fd \
  ffmpeg \
  fzf \
  gh \
  git \
  hub \
  mkcert \
  nvm \
  pnpm \
  tldr \
  tree \
  wget
