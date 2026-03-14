#!/bin/bash

# ==============================================================================
# macOS Developer Environment Setup Script
# macOS 开发者环境配置脚本
# ==============================================================================

echo "Starting full environment setup... / 开始配置完整开发环境..."

# --- Step 1: Install Oh My Zsh / 步骤 1: 安装 Oh My Zsh ---
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "[OK] Oh My Zsh is already installed. / Oh My Zsh 已安装。"
else
  echo "[INFO] Installing Oh My Zsh... / 正在安装 Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  if [ $? -ne 0 ]; then
    echo "[ERROR] Failed to install Oh My Zsh. Aborting. / 安装 Oh My Zsh 失败。终止执行。"
    exit 1
  fi
fi

# --- Step 2: Install Homebrew and Essential CLI Tools / 步骤 2: 安装 Homebrew 及其基础命令行工具 ---
chmod +x ./homebrew-install.sh
echo "[INFO] Running Homebrew installer for CLI tools... / 运行 Homebrew 安装脚本，安装核心命令行工具..."
# We run with --cli to get essential tools like git, nvm, etc. / 使用 --cli 参数安装必要的工具（如 git, nvm 等）
# --mirror is used for faster downloads in China. / 使用 --mirror 参数以启用国内镜像服务器（提升下载速度）
./homebrew-install.sh --cli --mirror
if [ $? -ne 0 ]; then
  echo "[ERROR] Homebrew script failed. Aborting. / Homebrew 脚本执行失败。终止执行。"
  exit 1
fi

# --- Step 3: Create Development Directories / 步骤 3: 初始化开发工作区目录 ---
echo "[INFO] Creating development directories... / 初始化开发工作区目录..."
mkdir -p "$HOME/go"
mkdir -p "$HOME/Code/projects"
mkdir -p "$HOME/Code/forks"
mkdir -p "$HOME/Code/repros"
echo "  -> Created / 已创建: ~/go, ~/Code/projects, ~/Code/forks, ~/Code/repros"

# --- Step 4: Install Zsh Theme and Plugins / 步骤 4: 安装 Zsh 主题与插件 ---
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
echo "[INFO] Installing Zsh theme and plugins... / 安装 Zsh 主题与插件..."

# Install spaceship-prompt theme / 安装 spaceship-prompt 主题
if [ ! -d "$ZSH_CUSTOM/themes/spaceship-prompt" ]; then
  echo "  -> Installing spaceship-prompt theme... / 正在安装 spaceship-prompt 主题..."
  git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
else
  echo "  -> spaceship-prompt theme already exists. / spaceship-prompt 主题已存在。"
fi

# Install zsh-autosuggestions plugin / 安装 zsh-autosuggestions 插件
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "  -> Installing zsh-autosuggestions plugin... / 正在安装 zsh-autosuggestions 插件..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
  echo "  -> zsh-autosuggestions plugin already exists. / zsh-autosuggestions 插件已存在。"
fi

# Install zsh-syntax-highlighting plugin / 安装 zsh-syntax-highlighting 插件
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "  -> Installing zsh-syntax-highlighting plugin... / 正在安装 zsh-syntax-highlighting 插件..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
  echo "  -> zsh-syntax-highlighting plugin already exists. / zsh-syntax-highlighting 插件已存在。"
fi

# Install zsh-completions plugin / 安装 zsh-completions 插件
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
  echo "  -> Installing zsh-completions plugin... / 正在安装 zsh-completions 插件..."
  git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
else
  echo "  -> zsh-completions plugin already exists. / zsh-completions 插件已存在。"
fi

# Install zsh-z plugin / 安装 zsh-z 插件
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-z" ]; then
  echo "  -> Installing zsh-z plugin... / 正在安装 zsh-z 插件..."
  git clone https://github.com/agkozak/zsh-z "$ZSH_CUSTOM/plugins/zsh-z"
else
  echo "  -> zsh-z plugin already exists. / zsh-z 插件已存在。"
fi

# --- Step 5: Copy .zshrc Configuration / 步骤 5: 配置 .zshrc 文件 ---
ZSHRC_PATH="$HOME/.zshrc"
ZSHRC_BACKUP_PATH="$HOME/.zshrc.pre-dotfiles.bak"

echo "[INFO] Setting up .zshrc... / 正在配置 .zshrc..."
# Backup existing .zshrc file / 备份现有的 .zshrc
if [ -f "$ZSHRC_PATH" ]; then
  echo "  -> Found existing .zshrc. Backing it up to $ZSHRC_BACKUP_PATH / 发现已有配置文件，将其备份至 $ZSHRC_BACKUP_PATH"
  mv "$ZSHRC_PATH" "$ZSHRC_BACKUP_PATH"
fi

# Copy the .zshrc from the repository / 拷贝仓库中的 .zshrc 至本地
echo "  -> Copying repository's .zshrc to $ZSHRC_PATH / 复制当前代码库的 .zshrc 文件至 $ZSHRC_PATH"
cp "$(pwd)/.zshrc" "$ZSHRC_PATH"

# --- Step 6: Install Global NPM Packages / 步骤 6: 安装 NPM 全局包 ---
echo "[INFO] Installing global NPM packages... / 正在安装 NPM 全局依赖包..."
# Source nvm to use it in this script / 导入 nvm 环境变量
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

# Install the latest LTS version of Node.js and set it as the default / 安装最新的 Node.js LTS 稳定版并设为默认
echo "  -> Installing latest LTS Node.js version via nvm... / 通过 nvm 安装最新 Node.js LTS 版本..."
nvm install --lts
echo "  -> Setting the LTS version as the default Node.js version... / 将其设为 Node.js 默认版本..."
nvm alias default lts/*

# Install the packages / 安装指定的全局工具包
echo "  -> Installing global npm packages... / 安装常用 npm 库 (live-server, pnpm, taze)..."
npm install -g @antfu/ni live-server pnpm taze

# --- Final Step / 最终步骤 ---
echo ""
echo "[SUCCESS] Setup complete! / 环境配置完成！"
echo "Please restart your terminal or run 'source ~/.zshrc' to apply all changes."
echo "请重启终端或执行 'source ~/.zshrc' 使全部配置生效。"
