-- 1. Bootstrap de Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

--  Opciones
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
-- Mover líneas en Modo Normal
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = "Bajar línea" })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = "Subir línea" })

-- Mover líneas en Modo Visual (seleccionar y arrastrar bloques)
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = "Bajar bloque" })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = "Subir bloque" })

-- Plugins
require("lazy").setup({
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
  { "williamboman/mason.nvim", opts = {} },
  { "williamboman/mason-lspconfig.nvim", opts = { ensure_installed = { "pyright" } } },
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false }, 
        panel = { enabled = false },      
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" }, 
    },
    opts = {
      show_help = "yes", -- Ayuda del chat
      
    },
    keys = {
      -- Un atajo rápido: <Leader> + c + c para abrir/cerrar el chat
      { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat" },
    },
  },
})



local cmp = require('cmp')
cmp.setup({
  snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- IMPORTANTE: Guion bajo
  })
})


local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')


lspconfig.pyright.setup({
  capabilities = capabilities,
})

vim.cmd[[colorscheme tokyonight]]
