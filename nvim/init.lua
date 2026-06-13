-- ======================== --
-- BASIC SETTINGS           --
-- ======================== --

local opt = vim.opt

opt.relativenumber = true       -- relative line numbers
opt.number = true               -- absolute line numbers
opt.showmatch = true            -- show matching brackets
opt.ignorecase = true           -- case insensitive searching
opt.hlsearch = true             -- highlight search results
opt.incsearch = true            -- incremental searching
opt.tabstop = 4                 -- tabs occupy 4 columns
opt.softtabstop = 4             -- edit as if tabs are 4 spaces
opt.expandtab = true            -- convert tabs to spaces
opt.shiftwidth = 4              -- width for autoindents
opt.autoindent = true           -- copy autoindent from current line
opt.mouse = 'a'                 -- enable mouse support
opt.clipboard = 'unnamedplus'   -- use system clipboard
opt.termguicolors = true        -- true color support
opt.wildmode = 'longest,list'   -- bash-like tab completion
opt.switchbuf = "newtab,usetab"  -- use existing tab if available, otherwise create new tab


-- GLOBAL VARIABLES
vim.g.loaded_netrw = 1         -- Disable netrw for nvim-tree
vim.g.loaded_netrwPlugin = 1
vim.g.rustfmt_on_save = 1      -- Rustfmt setting

-- REQUIRE
require('user.escape')

-- ========================================================================== --
-- ==                         BOOTSTRAP LAZY.NVIM                          == --
-- ========================================================================== --

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ========================================================================== --
-- ==                             PLUGINS                                  == --
-- ========================================================================== --

require("lazy").setup({
  -- 1. Basics & Formatting
  'tpope/vim-sensible',
  'alx741/vim-rustfmt',

  -- 2. Autoclose (Now with its config inside the plugin block)
  {
    'm4xshen/autoclose.nvim',
    config = function()
      require('autoclose').setup()
    end
  },

  -- 3. Theme
  {
    'nordtheme/vim',
    lazy = false, -- Load this immediately
    priority = 1000,
    config = function()
      vim.cmd('colorscheme nord')
    end
  },

  -- 4. File Tree
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("nvim-tree").setup({
        sort = { sorter = "case_sensitive" },
        view = { width = 30 },
        renderer = { group_empty = true },
        filters = { dotfiles = false },
      })
    end
  },
    
  {
      'catgoose/nvim-colorizer.lua',
      config = function()
          require('colorizer').setup({
              '*',          -- highlight all files
              '!vim',       -- exclude vim files
              '!markdown'   -- exclude markdown files
          })
      end
  },

})

-- ========================================================================== --
-- ==                            APPEARANCE                                == --
-- ========================================================================== --

-- Transparent Background (Applied after plugins load)
local custom_highlights = {
    'NonText', 'Normal', 'NormalNC', 'SignColumn', 
    'Pmenu', 'FloatBorder', 'NormalFloat', 'TabLine'
}
for _, group in ipairs(custom_highlights) do
    vim.api.nvim_set_hl(0, group, { bg = 'NONE', ctermbg = 'NONE' })
end

-- ========================================================================== --
-- ==                            KEYBINDINGS                               == --
-- ========================================================================== --

local keymap = vim.keymap.set

keymap('n', '<C-Up>', ':NvimTreeToggle<CR>', { silent = true })
keymap('n', '<C-Down>', ':NvimTreeFocus<CR>', { silent = true })

