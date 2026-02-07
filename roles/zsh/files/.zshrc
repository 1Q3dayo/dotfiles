
# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/setch/.lmstudio/bin"
# End of LM Studio CLI section


. "$HOME/.local/bin/env"
eval "$(starship init zsh)"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$(npm prefix -g)/bin:$PATH"

# エイリアス
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
alias zc='zellij --layout claude'

# 補完機能
## https://qiita.com/watertight/items/2454f3e9e43ef647eb6b
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

