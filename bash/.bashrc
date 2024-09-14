#
# .bashrc file
# .bashrc is loaded for interactive non-login shells.
#
# It's generally a good practice to put:
# Environment variables and login-specific configurations in .bash_profile
# Aliases, functions, and interactive shell configurations in .bashrc
# These are bash-specific configurations
#
#

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

# Bash completion setup {{
setup_bash_completion() {
    local completion_paths=(
        "/opt/homebrew/etc/profile.d/bash_completion.sh"  # macOS (Homebrew)
        "/usr/local/etc/profile.d/bash_completion.sh"     # macOS (Homebrew Intel)
        "/etc/bash_completion"                            # Linux (Ubuntu, Debian)
        "/usr/share/bash-completion/bash_completion"      # Linux (CentOS, Fedora)
    )

    for path in "${completion_paths[@]}"; do
        if [[ -r "$path" ]]; then
            . "$path"
            # echo "Bash completion loaded from $path"
            return 0
        fi
    done

    echo "Warning: bash-completion not found. You may want to install it."
    return 1
}

setup_bash_completion

# Optional: Check if bash-completion is working
if ! type _completion_loader &>/dev/null; then
    if type complete &>/dev/null && complete -p | grep -q "_completion_loader"; then
        echo "Bash-completion is working, but _completion_loader is not directly accessible."
    else
        echo "Note: Advanced bash-completion features might not be available."
        echo "Basic completion should still work."
    fi
fi
# }}
