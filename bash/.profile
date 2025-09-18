# .profile file
# settings that should apply to all shells, not just bash
#
#
# Environment variables {{
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# OS-specific paths
case "$(uname -s)" in
    Darwin*)
        # macOS paths
        if [ -d "$HOME/nvim-macos/bin" ]; then
            export PATH="$HOME/nvim-macos/bin:$PATH"
        elif [ -d "/usr/local/bin" ]; then
            export PATH="/usr/local/bin:$PATH"
        fi
        ;;
    Linux*)
        # Linux paths
        if [ -d "$HOME/nvim-linux64/bin" ]; then
            export PATH="$HOME/nvim-linux64/bin:$PATH"
        fi
        if [ -d "/usr/local/go/bin" ]; then
            export PATH="$PATH:/usr/local/go/bin"
        fi
        ;;
esac

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
