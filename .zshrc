# -------------------------------- #
# Homebrew Configuration
# -------------------------------- #
export HOMEBREW_INSTALL_FROM_API=1
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"

# -------------------------------- #
# Oh-My-Zsh Configuration
# -------------------------------- #

# Set the path to the Oh My Zsh installation directory.
# 设置 Oh My Zsh 的安装目录路径。
export ZSH="$HOME/.oh-my-zsh"

# -------------------------------- #
# Oh-My-Zsh Theme and Plugins
# -------------------------------- #

# git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
# ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
ZSH_THEME="spaceship"

# -------------------------------- #
# Plugins
# Define which plugins to load for Oh My Zsh.
# -------------------------------- #

# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
# git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
plugins=(
  git
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
  zsh-z
)

# Load Oh My Zsh. This should be done after setting ZSH_THEME and plugins.
# 加载 Oh My Zsh。应在设置 ZSH_THEME 和 plugins 后执行。
# Documentation: [https://ohmyz.sh/](https://ohmyz.sh/)
source $ZSH/oh-my-zsh.sh

# -------------------------------- #
# Environment Variables / 环境变量配置
# -------------------------------- #

# -- Java Environment --
# Add Homebrew installed OpenJDK to the PATH.
# 将 Homebrew 安装的 OpenJDK 添加到 PATH 环境变量。
# Assumes OpenJDK was installed via `brew install openjdk`.
# 假设已通过 `brew install openjdk` 安装。
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# -- Go (Golang) Development Environment --
# Set GOPATH: The root of your Go workspace. Recommended: $HOME/go.
# 设置 GOPATH: Go 工作区的根目录。推荐设置为 $HOME/go。
export GOPATH="$HOME/go"
# Add the Go workspace's bin directory to PATH for running installed binaries.
# 将 Go 工作区的 bin 目录添加到 PATH，以便运行 `go install` 安装的程序。
export PATH="$PATH:$GOPATH/bin"
# GOROOT is usually managed automatically by Go, no need to set it manually.
# GOROOT 通常由 Go 自动管理，无需手动设置。

# -- Node Version Manager (NVM) --
# Set the directory where NVM stores Node versions.
# 设置 NVM 存储 Node 版本的目录。
export NVM_DIR="$HOME/.nvm"
# Load NVM script if it exists.
# 如果 NVM 脚本存在则加载。
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
# Load NVM bash_completion script if it exists.
# 如果 NVM bash_completion 脚本存在则加载。
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# -------------------------------- #
# Starship Prompt Initialization / Starship 提示符初始化
# -------------------------------- #
# Initialize Starship prompt. This overrides the ZSH_THEME prompt.
# 初始化 Starship 提示符。这将覆盖 ZSH_THEME 设置的提示符。
eval "$(starship init zsh)"

# -------------------------------- #
# Aliases and Functions / 别名与函数
# -------------------------------- #

# -- Node Package Manager Aliases (using antfu/ni) --
# Requires `npm install -g @antfu/ni`. Provides a unified interface (ni, nu, nr, etc.).
# 需要先执行 `npm install -g @antfu/ni`。提供统一的包管理命令 (ni, nu, nr 等)。
# Source: [https://github.com/antfu/ni](https://github.com/antfu/ni)
alias ni='ni'                # Install dependencies / 安装依赖
alias nu='ni -u'             # Update dependencies / 更新依赖
alias nci='ni --frozen'      # Clean install (using lockfile) / 清洁安装 (使用锁文件)
alias na='ni add'            # Add dependency / 添加依赖
alias nr='nr'                # Run script / 运行脚本
alias nio="ni --prefer-offline" # Install preferring offline cache / 优先使用离线缓存安装
alias s="nr start"           # Alias for `nr start` / `nr start` 的别名
alias d="nr dev"             # Alias for `nr dev`
alias b="nr build"           # Alias for `nr build`
alias bw="nr build --watch"  # Alias for `nr build --watch`
alias t="nr test"            # Alias for `nr test`
alias tu="nr test -u"        # Alias for `nr test -u` (update snapshots)
alias tw="nr test --watch"   # Alias for `nr test --watch`
alias w="nr watch"           # Alias for `nr watch`
alias c="nr typecheck"       # Alias for `nr typecheck`
alias lint="nr lint"         # Alias for `nr lint`
alias lintf="nr lint --fix"  # Alias for `nr lint --fix`
alias release="nr release"   # Alias for `nr release`
alias re="nr release"        # Shorter alias for `nr release`
alias up="taze latest -r -w"

# -- Git Aliases --

# Go to the top level of the git repository / 跳转到 Git 仓库的根目录
alias grt='cd "$(git rev-parse --show-toplevel)"'

# Common Git commands / 常用 Git 命令别名
alias gs='git status'
alias gp='git push'
alias gpf='git push --force' # Force push (use with caution!) / 强制推送 (谨慎使用!)
alias gpft='git push --follow-tags' # Push commits and tags / 推送提交和标签
alias gpl='git pull --rebase' # Pull with rebase / 使用 rebase 方式拉取更新
alias gcl='git clone'
alias gst='git stash' # Stash changes / 暂存更改
alias grm='git rm'    # Remove file from git / 从 Git 中移除文件
alias gmv='git mv'    # Move/rename file in git / 在 Git 中移动/重命名文件

# Branch switching / 分支切换
alias main='git checkout main' # Switch to main branch (or master) / 切换到 main 分支 (或 master)
alias gco='git checkout'      # Alias for checkout / checkout 的别名
alias gcob='git checkout -b' # Create and switch to a new branch / 创建并切换到新分支

# Branch management / 分支管理
alias gb='git branch'         # List branches / 列出分支
alias gbd='git branch -d'     # Delete branch / 删除分支

# Rebasing / Rebase 操作
alias grb='git rebase'
alias grbom='git rebase origin/main' # Rebase onto remote main/master / Rebase 到远程 main/master 分支
alias grbc='git rebase --continue'   # Continue rebase after resolving conflicts / 解决冲突后继续 rebase

# Logging / 查看日志
alias gl='git log'
alias glo='git log --oneline --graph' # Compact graph log / 紧凑的图形化日志

# Resetting / 重置操作
alias grh='git reset HEAD'   # Unstage changes / 取消暂存更改
alias grh1='git reset HEAD~1' # Unstage last commit / 取消最后一次提交 (保留更改)

# Adding changes / 添加更改
alias ga='git add'
alias gA='git add -A' # Add all changes (new, modified, deleted) / 添加所有更改 (新增、修改、删除)

# Committing / 提交操作
alias gc='git commit'
alias gcm='git commit -m' # Commit with message / 带信息提交
alias gca='git commit -a' # Add and commit modified/deleted files (not new) / 添加并提交修改/删除的文件 (不包括新文件)
alias gcam='git add -A && git commit -m' # Add all and commit with message / 添加所有文件并带信息提交

# Fetching and Rebasing / 获取并 Rebase
alias gfrb='git fetch origin && git rebase origin/main' # Fetch from origin and rebase onto main/master / 从 origin 获取并 rebase 到 main/master

# Cleaning working directory / 清理工作目录
alias gxn='git clean -dn' # Dry run clean (show files to be removed) / 模拟清理 (显示将移除的文件)
alias gx='git clean -df'  # Force clean (remove untracked files/dirs) / 强制清理 (移除未跟踪的文件/目录)

# Utility aliases / 实用别名
alias gsha='git rev-parse HEAD | pbcopy' # Copy current commit SHA to clipboard / 复制当前提交 SHA 到剪贴板
alias ghci='gh run list -L 1' # List latest GitHub Actions run / 列出最新的 GitHub Actions 运行记录

# Git log pretty function / 美化 Git 日志函数
# Usage: glp 5 (shows last 5 commits) / 用法: glp 5 (显示最近 5 次提交)
function glp() {
  git --no-pager log -"$1"
}

# Git diff function with diff-so-fancy / 使用 diff-so-fancy 的 Git diff 函数
# Requires `brew install diff-so-fancy` / 需要 `brew install diff-so-fancy`
# Usage: gd (diff unstaged) or gd HEAD~1 (diff against commit) / 用法: gd (对比未暂存) 或 gd HEAD~1 (对比特定提交)
function gd() {
  if [[ -z "$1" ]]; then
    git diff --color | diff-so-fancy
  else
    git diff --color "$1" | diff-so-fancy
  fi
}

# Git diff cached function with diff-so-fancy / 使用 diff-so-fancy 的 Git diff --cached 函数
# Usage: gdc (diff staged changes) / 用法: gdc (对比已暂存的更改)
function gdc() {
  if [[ -z "$1" ]]; then
    git diff --color --cached | diff-so-fancy
  else
    git diff --color --cached "$1" | diff-so-fancy
  fi
}

# GitHub CLI Pull Request function / GitHub CLI Pull Request 函数
# Usage: pr ls (list PRs) or pr 123 (checkout PR #123) / 用法: pr ls (列出PR) 或 pr 123 (切换到 PR #123)
function pr() {
  if [ "$1" = "ls" ]; then
    gh pr list
  else
    gh pr checkout "$1"
  fi
}

# -- Directory Navigation Functions --
# Custom functions based on your preferred ~/Code structure.
# 基于你偏好的 ~/Code 目录结构的自定义函数。
# Adjust paths if your structure is different. / 如果你的结构不同，请调整路径。

# Navigate to project directory under ~/Code/projects
# 跳转到 ~/Code/projects 下的项目目录
function pj() {
  cd ~/Code/projects/"$1"
}
# Navigate to fork directory under ~/Code/forks
# 跳转到 ~/Code/forks 下的 fork 目录
function fk() {
  cd ~/Code/forks/"$1"
}
# Navigate to reproduction directory under ~/Code/repros
# 跳转到 ~/Code/repros 下的复现目录
function rp() {
  cd ~/Code/repros/"$1"
}

# -- Clone & Open Functions --
# Requires GitHub CLI (`gh`) and your IDE's command-line launcher (e.g., `webstorm`, `code`).
# 需要 GitHub CLI (`gh`) 和你的 IDE 命令行启动器 (例如 `webstorm`, `code`)。
# Ensure the IDE launcher is in your PATH. / 确保 IDE 启动器在你的 PATH 中。

# Improved clone function using gh cli / 使用 gh cli 改进的 clone 函数
function clone() {
  local repo_url=$1
  # Extract repo name as default target directory / 提取仓库名作为默认目标目录
  local target_dir=${2:-$(basename "$repo_url" .git)}
  echo "Cloning $repo_url into $target_dir..."
  # Clone using gh and cd into it, return 1 on failure / 使用 gh 克隆并进入目录，失败时返回 1
  gh repo clone "$repo_url" "$target_dir" && cd "$target_dir" || return 1
}

# Clone to 'projects', open in WebStorm, return to previous dir / 克隆到 'projects' 目录, 用 WebStorm 打开, 返回之前目录
function cpj() {
  local target_path=~/Code/projects # Adjust path if needed / 如有需要调整路径
  # Use subshell (...) to isolate cd and clone; && ensures webstorm runs only on success
  # 使用子 shell (...) 隔离 cd 和 clone；&& 确保只有 clone 成功才执行 webstorm
  (cd "$target_path" && clone "$@" && webstorm .)
}
# Clone to 'forks', open in WebStorm, return to previous dir / 克隆到 'forks' 目录...
function cfk() {
  local target_path=~/Code/forks # Adjust path if needed / 如有需要调整路径
  (cd "$target_path" && clone "$@" && webstorm .)
}
# Clone to 'repros', open in WebStorm, return to previous dir / 克隆到 'repros' 目录...
function crp() {
  local target_path=~/Code/repros # Adjust path if needed / 如有需要调整路径
  (cd "$target_path" && clone "$@" && webstorm .)
}

# -- Utility Functions --

# Create a directory and change into it / 创建目录并进入
# Usage: mkcd new_directory / 用法: mkcd new_directory
function mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Use live-server to serve a directory / 使用 live-server 提供目录服务
# Requires `npm install -g live-server` / 需要 `npm install -g live-server`
# Usage: serve (serves ./dist) or serve public (serves ./public) / 用法: serve (服务 ./dist) 或 serve public (服务 ./public)
function serve() {
  if [[ -z "$1" ]]; then
    live-server dist # Default to serving 'dist' directory / 默认服务 'dist' 目录
  else
    live-server "$1"
  fi
}

# -------------------------------- #
# Proxy Management / 代理管理
# -------------------------------- #
# Functions to quickly enable/disable proxy environment variables.
# 快速启用/禁用代理环境变量的函数。
# Adjust port numbers if your proxy uses different ones. / 如果你的代理使用不同端口，请调整端口号。

# Function to enable proxy / 启用代理函数
function p() {
  export https_proxy=http://127.0.0.1:7890
  export http_proxy=http://127.0.0.1:7890
  export all_proxy=socks5://127.0.0.1:7890
  echo "Proxy enabled: http://127.0.0.1:7890"
}

# Function to disable the proxy manually / 手动禁用代理函数
function dp() {
  unset https_proxy
  unset http_proxy
  unset all_proxy
  echo "Proxy disabled"
}

# Enable Proxy at terminal start (optional, uncomment to enable)
# 在终端启动时启用代理 (可选, 取消注释以启用)
# p

# --- Ensure NVM is loaded late (important for some setups) ---
# --- 确保 NVM 在较后加载 (对某些设置很重要) ---
# Source NVM scripts again to make sure they are available after all other initializations.
# 再次 source NVM 脚本以确保它们在所有其他初始化之后可用。
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# -------------------------------- #
# Ollama Configuration
# -------------------------------- #
launchctl setenv OLLAMA_ORIGINS "*"
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi

setopt no_nomatch

# Disable Caps Lock delay
hidutil property --set '{"CapsLockDelayOverride":0}'

# End of ~/.zshrc
