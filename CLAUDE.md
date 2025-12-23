# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository managed with GNU Stow. Configuration files for various tools (nvim, tmux, bash, wezterm, alacritty, fish, zellij, etc.) are organized in separate directories that mirror the home directory structure.

## Managing Dotfiles with Stow

To deploy configurations:
```sh
cd ~/my-dotfiles
stow nvim    # deploys nvim/.config/nvim to ~/.config/nvim
stow tmux    # deploys tmux/.tmux.conf to ~/.tmux.conf
stow bash    # deploys bash shell configurations
stow wezterm # deploys wezterm configuration
```

To add new dotfiles:
1. Create a directory with the package name
2. Inside, recreate the path structure as it appears in `$HOME`
3. Add configuration files at the correct path

## Neovim Configuration

**Plugin Manager:** lazy.nvim (bootstrapped in nvim/.config/nvim/lua/extra.lua:54-68)

**Entry Point:** nvim/.config/nvim/init.lua loads nvim/.config/nvim/lua/extra.lua

**Configuration Structure:**
- `lua/extra.lua` - Core settings, keymaps, lazy.nvim bootstrap, colorscheme, and loads config modules
- `lua/plugins.lua` - Plugin specifications for lazy.nvim
- `lua/config/` - Individual plugin configurations:
  - `lsp.lua` - LSP setup using lsp-zero.nvim with Mason
  - `cmp.lua` - Autocompletion with nvim-cmp
  - `telescope.lua` - Fuzzy finder configuration
  - `lualine.lua` - Statusline
  - `luasnip.lua` - Snippet engine
  - `startify.lua` - Start screen

**Key Plugins:**
- LSP: lsp-zero.nvim (v4.x), mason.nvim, nvim-lspconfig
- Completion: nvim-cmp, LuaSnip
- UI: telescope.nvim, NERDTree, lualine.nvim
- Git: vim-fugitive, gitsigns.nvim
- AI: avante.nvim
- Treesitter for syntax highlighting

**Leader Key:** `,` (comma)

**Notable Custom Features:**
- `:CopyPath` - Copy current file path to clipboard
- `:CopyLine` - Copy file path with line number (file.lua:42)
- `<leader>x` - Save and source current Lua/Vim file
- Special Symfony support: `gd` in YAML files navigates to controller actions using Telescope
- PHP: `$` removed from `iskeyword` for better word motions

**LSP Installation:**
Language servers must be installed separately (e.g., `npm i -g intelephense` for PHP)

## Bash Configuration

**Files:**
- `.profile` - Shell-agnostic environment variables, PATH setup, external tools (Homebrew, Cargo)
- `.bash_profile` - Login shell config, sources `.profile` and `.bashrc`
- `.bashrc` - Interactive shell config, aliases, prompt, bash completion

**Custom Prompt:** Shows time, history number, current directory, git branch, and remote/local indicator (🚀 for SSH, 🏠 for local)

**Bash Completion:** Automatically loads from multiple common paths, with custom Make target completion

## Tmux Configuration

**File:** tmux/.tmux.conf

**Notable Settings:**
- Mouse support enabled
- 256 color + true color support
- Vim-style pane navigation: `prefix h/j/k/l`
- 1-indexed windows and panes
- Custom status bar with session name and window list

## Wezterm Configuration

**File:** wezterm/.config/wezterm/wezterm.lua

**Settings:**
- Font: JetBrains Mono 16pt
- Custom dark gray color scheme
- 95% window opacity
- 10000 line scrollback

## Cross-Platform Support

**Platform Compatibility:** These dotfiles are designed to work across macOS, Linux, and Windows (via WSL, Git Bash, or Cygwin).

**OS Detection:** The `.profile` file includes OS detection logic for macOS and Linux with platform-specific PATH configurations for tools like nvim and Go installations.

**Cross-Platform Design Principles:**
- Configuration files use portable paths and tools where possible
- Shell configs (bash/.profile, bash/.bashrc) use OS detection for platform-specific customizations
- Neovim, tmux, and terminal emulator configs are platform-agnostic
- GNU Stow works identically on macOS (via Homebrew), Linux (via package managers), and Windows (via WSL/package managers)

**Windows Considerations:**
- WSL recommended for full compatibility
- Git Bash and Cygwin can work but may need adjustments for some features
- Windows paths may need translation for some tools
