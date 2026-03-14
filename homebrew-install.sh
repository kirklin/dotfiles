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
  
  # Define CLI packages in an array with categories and descriptions
  CLI_PACKAGES=(
    # --- System & Navigation ---
    autojump      # 快速目录跳转工具 / Directory navigation tool
    bat           # 带语法高亮的 cat 替代品 / cat clone with syntax highlighting
    coreutils     # GNU 核心工具集 (提供 g ls 等) / GNU core utilities
    fd            # 更快、更好的 find 替代品 / Fast and user-friendly alternative to find
    fzf           # 命令行模糊查找器 / Command-line fuzzy finder
    starship      # 跨 Shell 提示符 / Cross-shell prompt
    tldr          # 简化的 man 帮助页面 / Simplified tool pages
    tmux          # 终端复用器 / Terminal multiplexer
    tree          # 以树形显示目录结构 / Display directories as trees

    # --- Search & Data Processing ---
    jq            # 轻量级命令行 JSON 处理器 / Lightweight command-line JSON processor
    
    # --- Version Control ---
    diff-so-fancy # 提供更易读的 git diff 输出 / Good-lookin' diffs
    gh            # GitHub 官方 CLI / GitHub CLI
    git           # 分布式版本控制系统 / Distributed version control system

    # --- Development & Languages ---
    cmake         # 跨平台构建系统 / Cross-platform make
    go            # Go 编程语言 / Go programming language
    nvm           # Node.js 版本管理器 / Node Version Manager
    openjdk       # Java 开发工具包 / Java Development Kit
    pnpm          # 快速、节省磁盘空间的包管理器 / Fast, disk space efficient package manager
    python@3.12   # Python 3.12
    python@3.14   # Python 3.14 (Preview)
    uv            # 极速 Python 包管理器 / Extremely fast Python package installer
    watchman      # 文件监控服务 / File watching service
    
    # --- DevOps & Cloud ---
    docker        # 容器开发平台 CLI / Container development platform CLI
    helm          # Kubernetes 包管理器 / Kubernetes package manager
    kubernetes-cli # Kubernetes 命令行工具 (kubectl) / Kubernetes command-line tool
    
    # --- Network & Web ---
    hugo          # 快速静态网站生成器 / Fast static site generator
    mkcert        # 本地开发零配置 HTTPS 证书工具 / Zero-config tool to make locally trusted development certificates
    wget          # 网络下载工具 / Internet file retriever
    
    # --- Media & Content ---
    ffmpeg        # 音视频处理神器 / Play, record, convert, and stream audio and video
  )
  
  brew install "${CLI_PACKAGES[@]}"
fi

# Install GUI applications if requested
if [ "$INSTALL_GUI" = "true" ]; then
  echo "Installing GUI applications..."
  
  # Define GUI packages in an array with categories and descriptions
  GUI_PACKAGES=(
    # --- Browsers & Networking ---
    google-chrome # 谷歌浏览器 / Web browser
    postman       # API 开发和测试工具 / API development and testing tool
    proxyman      # 现代 HTTP 调试代理 / Modern HTTP debugging proxy
    warp          # 极速智能的现代终端 / Modern, Rust-based terminal
    wireshark     # 网络抓包协议分析器 / Network protocol analyzer
    
    # --- Development IDEs & Tools ---
    android-studio # Android 官方 IDE / Official IDE for Android development
    antigravity   # AI IDE 智能助手工具 / AI IDE agent tools
    clion         # C/C++ 跨平台 IDE / Cross-platform C/C++ IDE
    cursor        # 整合 AI 的代码编辑器 / AI-powered code editor
    datagrip      # 数据库管理工具 / Database IDE
    flutter       # 谷歌 UI 工具包 / Google's UI toolkit
    goland        # Go 语言 IDE / Go IDE
    intellij-idea # Java IDE
    pycharm       # Python IDE
    rustrover     # Rust IDE
    visual-studio-code # 微软开源代码编辑器 / Code editor
    webstorm      # JavaScript/TypeScript IDE
    wechatwebdevtools # 微信开发者工具 / WeChat web development tools
    
    # --- Version Control ---
    git-credential-manager # Git 凭据管理器 / Secure Git credential storage
    github        # GitHub 桌面版 / GitHub Desktop
    sourcetree    # Git 图形化客户端 / Graphical Git client
    
    # --- AI Tools & Productivity ---
    bob           # macOS 上的划词翻译和 OCR 软件 / Translation and OCR software
    claude        # Anthropic 的 AI 助手客户端 / Anthropic AI assistant
    feishu        # 飞书协作办公平台 / Feishu collaboration platform
    obsidian      # 本地知识库和双链笔记软件 / Knowledge base and note-taking app
    ollama        # 本地运行大模型的工具 / Run large language models locally
    raycast       # 极速效率启动器 (Spotlight 替代品) / Fast launcher and productivity tool
    
    # --- Media & Design ---
    adobe-creative-cloud               # Adobe 创意云 / Adobe Creative Cloud
    adobe-creative-cloud-cleaner-tool  # Adobe 卸载清理工具 / Adobe Cleaner Tool
    blackhole-16ch    # 16 通道虚拟音频驱动 (用于录制内部声音) / 16-channel virtual audio driver
    blackhole-64ch    # 64 通道虚拟音频驱动 / 64-channel virtual audio driver
    figma             # UI/UX 协同设计工具 / Collaborative UI design tool
    gstreamer-runtime # 多媒体框架运行库 / Multimedia framework runtime
    iina              # 现代 macOS 视频播放器 / Modern video player for macOS
    obs               # 开源直播和录屏软件 / Open Broadcaster Software
    
    # --- Storage & Download ---
    adrive        # 阿里云盘客户端 / Alibaba Cloud Drive
    baidunetdisk  # 百度网盘客端 / Baidu Netdisk
    motrix        # 全能下载工具 / Full-featured download manager
    
    # --- System Utilities & Virtualization ---
    android-platform-tools # Android 平台工具 (adb, fastboot 等) / Android SDK Platform-Tools
    orbstack      # 轻量极速的 Docker 和 Linux 虚拟机 / Fast Docker desktop alternative
    raspberry-pi-imager # 树莓派系统烧录工具 / Raspberry Pi OS imaging tool
    tencent-lemon     # 腾讯柠檬系统清理工具 / System cleaner
    vmware-fusion     # 虚拟机软件 / Virtual machine software
    
    # --- Games ---
    battle-net    # 暴雪战网客户端 / Blizzard Battle.net desktop app
    steam         # Steam 游戏平台 / Steam game platform
  )
  
  brew install --cask "${GUI_PACKAGES[@]}"
fi

echo "Script finished."
