# Shell startup docs: ~/CLAUDE.md § "Shell Startup Scripts"
# Enable Powerlevel10k instant prompt. Should stay at the top.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Oh-My-Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git fzf-tab fzf-zsh-plugin)
source "$ZSH/oh-my-zsh.sh"

# Shell options
PROMPT_EOL_MARK='%B%S!↩%b%s'

# Modular config
for conf in aliases functions tools completions; do
  source "$HOME/.zsh/${conf}.zsh"
done

# Powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Global Python virtualenv
[[ -f ~/.py/bin/activate ]] && . ~/.py/bin/activate

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true
