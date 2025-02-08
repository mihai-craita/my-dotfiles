#
# .bash_profile file
# .bash_profile is loaded for login shells.
#
# It's generally a good practice to put:
# Environment variables and login-specific configurations in .bash_profile
# Aliases, functions, and interactive shell configurations in .bashrc
#
#
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.bashrc" ]] && source "$HOME/.bashrc"
export PATH="/usr/local/sbin:$PATH"
