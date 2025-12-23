# my-dotfiles

Cross-platform dotfiles configuration for macOS, Linux, and Windows (WSL/Git Bash).

Inspired by http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html

## Platform Support

These configurations are designed to work across multiple platforms:
- **macOS** - Full support with native tools
- **Linux** - Full support (all distributions)
- **Windows** - Use with WSL (Windows Subsystem for Linux), Git Bash, or Cygwin

GNU Stow is available on all platforms via package managers (brew, apt, pacman, choco, etc.)

```sh
cd ~/my-dotfiles
stow nvim
stow tmux
```

### How to add a new folder for dotfiles
Add a new folder with the name of the package

```sh
cd ~/my-dotfiles
mkdir nvim
```

make a path exactly like in the home directory eg. .config/nvim/ where you add all the dot files.

### NVIM

install language servers, eg. npm i intelephense -g

