# .profile file
# settings that should apply to all shells, not just bash
#
#
# Environment variables {{
export PATH="$HOME/bin:$PATH"
export EDITOR="nvim"
# }}

# External tools setup {{
# Homebrew setup
if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)" > /dev/null
fi

# Cargo setup
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env" > /dev/null 2>&1
fi
# }}
