-- install packer from github if is not found on the system
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'
  -- make sure to add this line to let packer manage itself
  use 'wbthomason/packer.nvim'

  use { 'scrooloose/nerdtree', cmd = { 'NERDTree', 'NERDTreeFind', 'NERDTreeFocus', 'NERDTreeToggle' } }
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/nvim-cmp'
  use ({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"})
  use 'sheerun/vim-polyglot'
  use 'junegunn/vim-easy-align'
  use 'mhinz/vim-startify'

  -- neovim completion library for lua language
  use 'ii14/emmylua-nvim'

  use 'rafamadriz/friendly-snippets'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- show context up
  use 'nvim-treesitter/nvim-treesitter-context'

  -- statusline
  use 'feline-nvim/feline.nvim'

  -- colors packs, find more on http://vimcolors.com/
  use 'ellisonleao/gruvbox.nvim'
  use 'sainnhe/sonokai'
  use 'mhartington/oceanic-next'
  use 'savq/melange'
  use 'ishan9299/nvim-solarized-lua'
  use 'marko-cerovac/material.nvim'

  -- fonts
  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-web-devicons'
  use 'bryanmylee/vim-colorscheme-icons'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
