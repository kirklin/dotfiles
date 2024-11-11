# -------------------------------- #
# Homebrew Configuration
# -------------------------------- #
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/bottles"

# -------------------------------- #
# Node Version Manager (NVM)
# -------------------------------- #
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # Load nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # Load nvm bash_completion

# -------------------------------- #
# Starship Prompt
# -------------------------------- #
eval "$(starship init zsh)"

# -------------------------------- #
# Oh-My-Zsh Theme and Plugins
# -------------------------------- #

# git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
# ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
ZSH_THEME="spaceship"

# git clone https://github.com/agnoster/agnoster-zsh-theme.git "$ZSH_CUSTOM/themes/agnoster-zsh-theme" --depth=1
# ZSH_THEME="agnoster"

# -------------------------------- #
# Plugins
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

# Load Oh My Zsh
# https://ohmyz.sh/
source ~/.oh-my-zsh/oh-my-zsh.sh

# -------------------------------- #
# Node Package Manager
# -------------------------------- #
# https://github.com/antfu/ni

alias nio="ni --prefer-offline"
alias s="nr start"
alias d="nr dev"
alias b="nr build"
alias bw="nr build --watch"
alias t="nr test"
alias tu="nr test -u"
alias tw="nr test --watch"
alias w="nr watch"
alias c="nr typecheck"
alias lint="nr lint"
alias lintf="nr lint --fix"
alias release="nr release"
alias re="nr release"
alias up="taze latest -r -w"

# -------------------------------- #
# Git Aliases
# -------------------------------- #

# Use github/hub
alias git=hub

# Go to project root
alias grt='cd "$(git rev-parse --show-toplevel)"'

alias gs='git status'
alias gp='git push'
alias gpf='git push --force'
alias gpft='git push --follow-tags'
alias gpl='git pull --rebase'
alias gcl='git clone'
alias gst='git stash'
alias grm='git rm'
alias gmv='git mv'

alias main='git checkout main'

alias gco='git checkout'
alias gcob='git checkout -b'

alias gb='git branch'
alias gbd='git branch -d'

alias grb='git rebase'
alias grbom='git rebase origin/master'
alias grbc='git rebase --continue'

alias gl='git log'
alias glo='git log --oneline --graph'

alias grh='git reset HEAD'
alias grh1='git reset HEAD~1'

alias ga='git add'
alias gA='git add -A'

alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcam='git add -A && git commit -m'
alias gfrb='git fetch origin && git rebase origin/master'

alias gxn='git clean -dn'
alias gx='git clean -df'

alias gsha='git rev-parse HEAD | pbcopy'

alias ghci='gh run list -L 1'

# Git log pretty function
function glp() {
  git --no-pager log -$1
}

# Git diff function with diff-so-fancy
function gd() {
  if [[ -z $1 ]] then
    git diff --color | diff-so-fancy
  else
    git diff --color $1 | diff-so-fancy
  fi
}

function gdc() {
  if [[ -z $1 ]] then
    git diff --color --cached | diff-so-fancy
  else
    git diff --color --cached $1 | diff-so-fancy
  fi
}

function pr() {
  if [ $1 = "ls" ]; then
    gh pr list
  else
    gh pr checkout $1
  fi
}

function dir() {
  mkdir $1 && cd $1
}

function clone() {
  if [[ -z $2 ]] then
    hub clone "$@" && cd "$(basename "$1" .git)"
  else
    hub clone "$@" && cd "$2"
  fi
}

# -------------------------------- #
# Directory Navigation Functions
# -------------------------------- #

# Navigate to specific project directory under Code
function pj() {
  cd ~/Code/projects/$1
}

# Navigate to specific fork directory under Code
function fk() {
  cd ~/Code/forks/$1
}

# Navigate to specific reproduction directory under Code
function rp() {
  cd ~/Code/repros/$1
}

# Clone a repo to 'projects' and navigate into it using WebStorm
function cpj() {
  pj && clone "$@" && webstorm . && cd ~2
}

# Clone a repo to 'forks' and navigate into it using WebStorm
function cfk() {
  fk && clone "$@" && webstorm . && cd ~2
}

# Clone a repo to 'reproductions' and navigate into it using WebStorm
function crp() {
  rp && clone "$@" && webstorm . && cd ~2
}

# -------------------------------- #
# Utility Functions
# -------------------------------- #

# Create a directory and move into it
function mkcd() {
  mkdir $1 && cd $1
}

# Use live server to serve a directory
function serve() {
  if [[ -z $1 ]] then
    live-server dist
  else
    live-server $1
  fi
}

# -------------------------------- #
# Proxy Management
# -------------------------------- #

# Function to enable proxy
function p() {
  export https_proxy=http://127.0.0.1:7890
  export http_proxy=http://127.0.0.1:7890
  export all_proxy=socks5://127.0.0.1:7890
  echo "Proxy enabled: http://127.0.0.1:7890"
}
