lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "nordfox"

lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<esc>"] = ":noh<cr>"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.update_cwd = false

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "css",
  "elixir",
  "javascript",
  "json",
  "lua",
  "markdown",
  "tsx",
  "typescript",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.plugins = {
  { "/Users/johnsondenen/Code/config" },
  { "EdenEast/nightfox.nvim" },
  { 'karb94/neoscroll.nvim' },
  { 'christoomey/vim-tmux-navigator' },
  { "folke/todo-comments.nvim" },
  { "tpope/vim-surround" },
  {
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_enabled = 0
    end
  },
  { 'vim-test/vim-test', requires = { 'christoomey/vim-tmux-runner' } }
}

lvim.builtin.which_key.mappings["t"] = {
  name = "+Testing",
  a = { "<cmd>TestSuite<cr>", "all" },
  b = { "<cmd>TestFile<cr>", "buffer" },
  r = { "<cmd>TestLast<cr>", "rerun" },
  t = { "<cmd>TestNearest<cr>", "test" },
  f = { "<cmd>VtrFocusRunner<cr>", "focus" }
}

lvim.builtin.which_key.mappings["G"] = {
  "<cmd>:GitBlameToggle<cr>", "Blame"
}

lvim.builtin.which_key.mappings["y"] = {
  name = "+Yank",
  b = { "<cmd>lua require('yankem').yank_file()<CR>", "Root File" },
  B = { "<cmd>lua require('yankem').yank_line()<CR>", "Root Line" },
  u = { "<cmd>lua require('yankem').yank_app_file()<CR>", "App File" },
  U = { "<cmd>lua require('yankem').yank_app_line()<CR>", "App Line" }
}

vim.g['test#strategy'] = 'vtr'
require('todo-comments').setup()
require('neoscroll').setup()
