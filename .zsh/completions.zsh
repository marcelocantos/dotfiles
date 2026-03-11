# fzf
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2>/dev/null
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

# Google Cloud SDK
for script in /opt/homebrew/share/google-cloud-sdk/{completion,path}.zsh.inc; do
  [[ -f "$script" ]] && source "$script"
done

# bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# nvm bash completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
