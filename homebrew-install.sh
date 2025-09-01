#!/bin/bash

# Homebrew Installation Script
#
# This script installs Homebrew and a list of applications.
# It includes configurable options for using a proxy and a Chinese mirror.

# --- Configuration ---
# Set to "true" to enable the proxy for Homebrew commands.
USE_PROXY="false"
# Set to "true" to use the Chinese mirror for Homebrew.
USE_CN_MIRROR="false"
# ---------------------

# Apply Proxy Settings if enabled
if [ "$USE_PROXY" = "true" ]; then
  export https_proxy=http://127.0.0.1:7890
  export http_proxy=http://127.0.0.1:7890
  export all_proxy=socks5://127.0.0.1:7890
  echo "Proxy enabled for this session."
fi

# Apply Chinese Mirror Settings if enabled
if [ "$USE_CN_MIRROR" = "true" ]; then
  export HOMEBREW_INSTALL_FROM_API=1
  export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
  export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
  export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
  export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
  echo "Using Chinese mirror for Homebrew."
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

# Install GUI applications
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

# Install CLI tools
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
  pnpm \
  tldr \
  tree \
  wget
