-- Lazy nvim install
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- HACK FOR NEOTREE, DO NOT DELETE
_G.__cached_neo_tree_selector = nil
_G.__get_selector = function()
  return _G.__cached_neo_tree_selector
end

if vim.g.neovide then
  require("neovide")
end

vim.o.background = "dark"
vim.opt.number = true
vim.opt.spelllang = "en,ru"
vim.opt.signcolumn = "auto:1-4"
vim.opt.smoothscroll = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 8
vim.opt.softtabstop = 2

vim.g.editorconfig = true

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "gruvbox" } },
})


vim.lsp.config("lua_ls", {
})

vim.lsp.config("tinymist", {
  settings = {
    formatterMode = "typstyle",
    compileStatus = "enable",
  },
})

vim.lsp.config("nixd", {
  settings = {
    nixd = {
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
})

vim.lsp.config("clangd", {})
vim.lsp.config("cmake", {})
vim.lsp.config("qmlls", {})

vim.lsp.enable("lua_ls")
vim.lsp.enable("tinymist")
vim.lsp.enable("nixd")
vim.lsp.enable("clangd")
vim.lsp.enable("cmake")
vim.lsp.enable("qmlls")

require("which-key").add({
  { 'grf',       function() vim.lsp.buf.format() end,        desc = "Format buffer", },
  { '<leader>k', function() vim.diagnostic.open_float() end, desc = "Open diagnostic" },
})

-- vim.api.nvim_set_keymap('t', '<Esc><Esc>', [[<C-\><C-n>]], { noremap = true })
vim.api.nvim_set_keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], {noremap = true})
vim.api.nvim_set_keymap('t', '<S-Esc>', [[<C-\><C-n>]], {noremap = true})

vim.api.nvim_create_user_command('EditConfig', 'e ~/.config/nvim/', {})

require("telescope").load_extension("ui-select")
require("telescope").load_extension("scope")

vim.diagnostic.config({
  underline = true,
  signs = true,
  virtual_text = true,
  float = {
    show_header = true,
    source = true,
    border = 'rounded',
    focusable = true,
  },
})

-- Wrapped
vim.cmd [[
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
]]

vim.keymap.set('n', '<X1Mouse>', "<C-o>")
vim.keymap.set('n', '<X2Mouse>', "<C-i")

local Terminal  = require('toggleterm.terminal').Terminal
local jjui = Terminal:new({ cmd = "jjui", hidden = true, direction = "float" })

require("which-key").add({
  {"<leader>jj", function() jjui:toggle() end, desc = "Toggle JJUI"},
})

-- vim.api.nvim_set_keymap("n", "<leader>jj", function() jjui:toggle() end, {noremap})
