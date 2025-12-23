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
bind "set enable-bracketed-paste on"

# History search with arrow keys
bind '"\e[A": history-search-backward'  # Up arrow
bind '"\e[B": history-search-forward'   # Down arrow

# Aliases {{
# Directory navigation
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'

# Git shortcuts
alias gs='git status'

# Editor
alias e='nvim' # quick access to editor

# Color grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Utility aliases
alias df='df -h'
alias du='du -h'

# Safety aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# }}

# Bash options {{
shopt -s histappend  # Append to history file instead of overwriting
shopt -s checkwinsize  # Check window size after each command and update LINES and COLUMNS if necessary
# }}

# History settings {{
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth:erasedups
# }}

# Prompt setup {{
#
    ### color variables - theme
    MAIN_COLOR=$(tput setaf 4)  # Blue
    SECONDARY_COLOR=$(tput setaf 2)  # Green
    TERTIARY_COLOR=$(tput setaf 3)  # Yellow
    GIT_BRANCH_COLOR=$(tput setaf 5)  # Magenta
    PROMPT_COLOR=$(tput setaf 6)  # Cyan
    RESET_COLOR=$(tput sgr0)

    parse_git_branch() {
        branch=$(git branch --show-current 2>/dev/null)
        if [ -n "$branch" ]; then
            echo " on "$GIT_BRANCH_COLOR" $branch"$RESET_COLOR
        fi
    }

    is_remote() {
        if [ -n "$SSH_CONNECTION" ] || [ -n "$SSH_CLIENT" ]; then
            host=$(hostname)
            echo "🚀 $host"  # Remote machine indicator
        else
            echo "🏠"  # Local machine indicator
        fi
    }
    REMOTE_INDICATOR=$(is_remote)

    ### \h is hostname \t is time \! is history number \w is the directory path
    PS1='\n$REMOTE_INDICATOR \['"$MAIN_COLOR"'\]\t\['"$RESET_COLOR"'\] \['"$SECONDARY_COLOR"'\][\!]\['"$RESET_COLOR"'\] \['"$TERTIARY_COLOR"'\]\w\['"$RESET_COLOR"'\]$(parse_git_branch)\n\['"$PROMPT_COLOR"'\]❯\['"$RESET_COLOR"'\] '
#
# }}

# Bash completion setup {{
setup_bash_completion() {
    # Skip if bash completion is already loaded
    if [[ -n "${BASH_COMPLETION_VERSINFO:-}" ]]; then
        return 0
    fi

    # completion for make command
    if [[ -f Makefile ]] || [[ -f makefile ]] || [[ -f GNUmakefile ]]; then
        complete -W "$(make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split($1,A,/ /);print A[1]}' | sort -u)" make
    fi

    local completion_paths=(
        "/usr/local/etc/profile.d/bash_completion.sh"     # macOS (Homebrew Intel)
        "/opt/homebrew/etc/profile.d/bash_completion.sh"  # macOS (Homebrew)
        "/usr/share/bash-completion/bash_completion"      # Linux (CentOS, Fedora, RHEL)
        "/etc/bash_completion"                            # Linux (Ubuntu, Debian)
    )

    for path in "${completion_paths[@]}"; do
        if [[ -r "$path" ]]; then
            . "$path"
            return 0
        fi
    done

    echo "Warning: bash-completion not found. You may want to install it."
    return 1
}

setup_bash_completion

# Check if bash-completion loaded successfully (only show once)
if [[ -n "${BASH_COMPLETION_VERSINFO:-}" && -z "${BASH_COMPLETION_ANNOUNCED:-}" ]]; then
    echo "Bash completion v${BASH_COMPLETION_VERSINFO[0]}.${BASH_COMPLETION_VERSINFO[1]} loaded successfully"
    export BASH_COMPLETION_ANNOUNCED=1
fi
# }}

# FZF history search {{
if command -v fzf &> /dev/null; then
    # Ctrl+R for fuzzy history search
    __fzf_history() {
        local selected
        selected=$(HISTTIMEFORMAT= history | fzf --tac --tiebreak=index --no-sort | sed 's/^[[:space:]]*[0-9]*[[:space:]]*//')
        READLINE_LINE="$selected"
        READLINE_POINT=${#READLINE_LINE}
    }
    bind -x '"\C-r": __fzf_history'
fi
# }}

alias claude="/Users/mihai/.claude/local/claude"
