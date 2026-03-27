# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

# PATH
PATH="/Library/TeX/texbin:$PATH"
PATH="$HOME/go/bin:$PATH"
PATH="/opt/homebrew/opt/python@3.10/bin:$PATH"
PATH="/opt/homebrew/opt/llvm/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="/opt/zerobrew/prefix/bin:$PATH"
PATH="$HOME/.jenv/bin:$PATH"
PATH="$HOME/Library/Android/sdk/tools/bin:$HOME/Library/Android/sdk/build-tools/36.0.0:$PATH"
PATH="$HOME/.bun/bin:$PATH"
export PATH

# Environment variables
export BYOBU_PREFIX=/opt/homebrew
export LESSOPEN='| lessfilter-fzf %s'
export BUN_INSTALL="$HOME/.bun"
export NVM_DIR="$HOME/.nvm"
export PYENV_ROOT="$HOME/.pyenv"
export GGHTTP=1

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
