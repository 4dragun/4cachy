function starship_transient_prompt_func
	tput cuu1
	starship module character
end

function prompt_newline --on-event fish_postexec
	echo
end

if status is-interactive
  set -U fish_greeting
end

alias y     "yazi"
alias ls    "lsd"
alias cat   "bat"
alias gh    "~/.config/fish/scripts/git.sh"
alias s     "~/.config/fish/scripts/script.sh"
alias clear "command clear; commandline -f clear-screen"

starship init fish | source
