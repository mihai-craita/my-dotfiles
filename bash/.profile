# Environment variables {{
export PATH="$HOME/bin:$PATH"
export EDITOR="nvim"
# }}

# Aliases {{
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias gs='git status'
alias e='nvim' # quick access to editor
# }}

# Bash options {{
shopt -s histappend  # Append to history file instead of overwriting
shopt -s checkwinsize  # Check window size after each command and update LINES and COLUMNS if necessary
# }}

# Prompt setup {{
#
### color variables - theme
    MAIN_COLOR=$(tput setaf 4)  # Blue
    SECONDARY_COLOR=$(tput setaf 2)  # Green
    TERTIARY_COLOR=$(tput setaf 3)  # Yellow
    PROMPT_COLOR=$(tput setaf 6)  # Cyan
    RESET_COLOR=$(tput sgr0)

    parse_git_branch() {
        branch=$(git branch --show-current 2>/dev/null)
        if [ -n "$branch" ]; then
            echo " ($branch)"
        fi
    }

### \t is time \! is history number \w is the directory path
    PS1='\n'"$MAIN_COLOR"'\t'"$RESET_COLOR $SECONDARY_COLOR"'[\!]'"$RESET_COLOR $TERTIARY_COLOR"'\w'"$RESET_COLOR"'$(parse_git_branch)\n'"$PROMPT_COLOR"'$ '"$RESET_COLOR"
#
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
