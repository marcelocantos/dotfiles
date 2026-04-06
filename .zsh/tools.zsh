# Shell startup docs: ~/CLAUDE.md § "Shell Startup Scripts"
# iterm2
[[ -f ~/.local/sbin/iterm2_shell_integration.zsh ]] && source ~/.local/sbin/iterm2_shell_integration.zsh

# iTerm2 badge: compacted PWD using shortest unique prefix per component
# ~/think/calendar-widget → ~/t/calendar-widget (if think is unique under ~)
# ~/think/calendar-widget → ~/thi/calendar-widget (if ~/things also exists)
function _iterm2_badge_pwd() {
  local full="${PWD/#$HOME/~}"
  if [[ -z "$full" || "$full" == / ]]; then
    printf '\e]1337;SetBadgeFormat=%s\a' "$(echo -n '/' | base64)"
    return
  fi

  local -a parts=("${(@s:/:)full}")
  local result="" dir="/"
  if [[ "$full" == ~* ]]; then
    result="~"
    dir="$HOME"
    parts=("${parts[@]:1}")
  fi

  # Handle root or home specially
  if (( ${#parts} == 0 )); then
    printf '\e]1337;SetBadgeFormat=%s\a' "$(echo -n "$result" | base64)"
    return
  fi

  # Keep last component full (safe now)
  local last
  if (( ${#parts} > 0 )); then
    last="${parts[-1]}"
    parts=("${parts[@]:0:${#parts[@]}-1}")
  else
    last=""
  fi

  for part in "${parts[@]}"; do
    local siblings=("$dir"/*(/:t))
    local -i start=1
    [[ "$part" == .* ]] && start=2
    local prefix="${part:0:$((start-1))}"   # empty if start=1
    for (( len=start; len<=${#part}; len++ )); do
      prefix="${part:0:$len}"
      local matches=("${(M)siblings[@]:#${prefix}*}")
      (( ${#matches[@]} == 1 )) && break
    done
    result+="/${prefix}"
    dir+="/${part}"
  done

  result+="/${last}"
  # Trim leading / if result starts with // (edge case)
  result="${result#/}"

  local branch
  branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  [[ -n "$branch" && "$branch" != "master" ]] && result+="\ue0a0${branch}"
  printf "\e]1337;SetBadgeFormat=%s\a" "$(echo -n "$result" | base64)"
}
autoload -U add-zsh-hook
add-zsh-hook precmd _iterm2_badge_pwd

# you-should-use
[[ -f /opt/homebrew/share/zsh-you-should-use/you-should-use.plugin.zsh ]] && \
  source /opt/homebrew/share/zsh-you-should-use/you-should-use.plugin.zsh

# jenv
eval "$(jenv init -)"

# pyenv removed — using uv for Python version management

# nvm (lazy-loaded)
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# direnv
eval "$(direnv hook zsh)"

# Docker Desktop
[[ -f "$HOME/.docker/init-zsh.sh" ]] && source "$HOME/.docker/init-zsh.sh"

# flyctl
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# fzf
# fzf / completion colors (light terminal)
export FZF_DEFAULT_OPTS='--color=light'
export LS_COLORS='no=38;2;60;60;60:fi=38;2;60;60;60:di=1;38;2;0;50;200:ln=38;2;160;0;160:so=38;2;0;140;0:pi=38;2;160;120;0:ex=1;38;2;200;0;0:bd=38;2;0;50;200:cd=38;2;0;50;200:su=38;2;255;255;255;48;2;200;0;0:sg=38;2;0;0;0;48;2;200;200;0:tw=38;2;0;0;0;48;2;0;180;0:ow=1;38;2;0;50;200'

# den — universal development environment manager
eval "$("$HOME/.den/bin/den" init)"

# gg
eval "$("$HOME/.cargo/bin/gg" -i zsh)"
eval "$("$HOME/.cargo/bin/gg" -i zsh ghg github.com)"
eval "$("$HOME/.cargo/bin/gg" -i zsh gsg github.com/squz)"
eval "$("$HOME/.cargo/bin/gg" -i zsh gmg github.com/marcelocantos)"
