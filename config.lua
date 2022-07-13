--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<esc>"] = ":noh<cr>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "elixir",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
  { "/Users/johnson/Code/yankem.nvim" },
  { "TimUntersberger/neogit" },
  {
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_enabled = 0
    end
  }
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

Testing = {
  buffer = vim.api.nvim_create_buf(false, true),
  command = nil
}

NeoYank = {}

vim.api.nvim_buf_set_keymap(Testing.buffer, "n", "q", "<cmd>lua vim.api.nvim_win_close(0, false)<CR>", {})
vim.api.nvim_buf_set_keymap(Testing.buffer, "n", "m", "<cmd>lua Testing.show_window_max()<CR>", {})

Testing.clear_buffer = function()
  vim.api.nvim_buf_set_lines(Testing.buffer, 0, -1, true, {})
  vim.api.nvim_buf_set_lines(Testing.buffer, -1, -1, true, { Testing.command })
end

Testing.show_window_max = function()
  local ui = vim.api.nvim_list_uis()[1]
  local width = ui.width - 20
  local height = ui.height - 15

  vim.api.nvim_win_close(0, false)

  vim.api.nvim_open_win(Testing.buffer, true,
    { relative = "editor", anchor = "NW", row = 5, col = 10, width = width, height = height, border = "double" })
end

Testing.show_window = function()
  local ui = vim.api.nvim_list_uis()[1]
  local width = math.floor(ui.width / 2) - 10
  local height = ui.height - 15
  local column = math.floor(ui.width / 2) + 8

  vim.api.nvim_open_win(Testing.buffer, true,
    { relative = "editor", anchor = "NW", row = 5, col = column, width = width, height = height,
      border = "double" })
end

Testing.run_tests = function(mode)
  local cwd = vim.lsp.buf.list_workspace_folders()[1]
  local Job = require('plenary.job')

  if mode == "all" then
    Testing.command = "mix test"
  elseif mode == "buffer" then
    local file = vim.fn.expand('%')
    Testing.command = "mix test " .. file
  elseif mode == "cursor" then
    local file = vim.fn.expand('%')
    local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
    Testing.command = "mix test " .. file .. ":" .. line
  end

  Testing.clear_buffer()
  Testing.show_window()

  local job = Job:new({
    command = "/bin/zsh",
    args = { "-c", Testing.command },
    cwd = cwd,
    -- env = { PATH = vim.env.PATH, ASDF_DIR = "/Users/johnson/.asdf" },
    enable_recording = false,
    on_stdout = vim.schedule_wrap(function(_, line)
      vim.api.nvim_buf_set_lines(Testing.buffer, -1, -1, true, { line })
    end),
    on_stderr = vim.schedule_wrap(function(_, line)
      vim.api.nvim_buf_set_lines(Testing.buffer, -1, -1, true, { line })
    end),
    on_exit = function(_, _)
      vim.notify("Tests Completed", "info")
    end,
  })

  job:start()
end

lvim.builtin.which_key.mappings["t"] = {
  name = "+Testing",
  a = { "<cmd>lua Testing.run_tests('all')<CR>", "all" },
  b = { "<cmd>lua Testing.run_tests('buffer')<CR>", "buffer" },
  r = { "<cmd>lua Testing.run_tests('rerun')<CR>", "rerun" },
  s = { "<cmd>lua Testing.show_window()<CR>", "show results" },
  t = { "<cmd>lua Testing.run_tests('cursor')<CR>", "test" },
}

lvim.builtin.which_key.mappings["g"] = {
  name = "+Git",
  g = { "<cmd>:Neogit<cr>", "Status" },
  b = { "<cmd>:GitBlameToggle<cr>", "Blame" }
}

lvim.builtin.which_key.mappings["y"] = {
  name = "+Yank",
  b = { "<cmd>lua require('yankem').yank_file()<CR>", "File" },
  B = { "<cmd>lua require('yankem').yank_line()<CR>", "Line" }
}
