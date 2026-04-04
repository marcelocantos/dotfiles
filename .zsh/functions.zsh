# Shell startup docs: ~/CLAUDE.md § "Shell Startup Scripts"
pycat() {
  python3 -c "import pickle, sys, pprint; pprint.pprint(pickle.load(open('$1', 'rb')))"
}

cal() {
  local args=("$@")
  if [ -z "$1" ]; then
    args=("-3")
  fi
  script -q /dev/null /usr/bin/cal "$args[@]" \
  | sed -e 's/ \x1b\[7m/\x1b[35m▐\x1b[1;37;45m/' -e 's/\x1b\[27m /\x1b[0;35m▌\x1b[0m/'
}

mcd() {
  mkdir "$1" && cd "$1"
}

c() { IS_SANDBOX=1 ~/.local/bin/claude --dangerously-skip-permissions "$@"; }
claude() { c "$@"; }
