local M = {
  buffer = vim.api.nvim_create_buf(false, true),
  command = nil
}

vim.api.nvim_buf_set_keymap(M.buffer, "n", "q", "<cmd>lua vim.api.nvim_win_close(0, false)<CR>", {})
vim.api.nvim_buf_set_keymap(M.buffer, "n", "m", "<cmd>lua M.show_window_max()<CR>", {})

function M.clear_buffer()
  vim.api.nvim_buf_set_lines(M.buffer, 0, -1, true, {})
  vim.api.nvim_buf_set_lines(M.buffer, -1, -1, true, { M.command })
end

function M.show_window_max()
  local ui = vim.api.nvim_list_uis()[1]
  local width = ui.width - 20
  local height = ui.height - 15

  vim.api.nvim_win_close(0, false)

  vim.api.nvim_open_win(M.buffer, true,
    { relative = "editor", anchor = "NW", row = 5, col = 10, width = width, height = height, border = "double" })
end

function M.show_window()
  local ui = vim.api.nvim_list_uis()[1]
  local width = math.floor(ui.width / 2) - 10
  local height = ui.height - 15
  local column = math.floor(ui.width / 2) + 8

  vim.api.nvim_open_win(M.buffer, true,
    { relative = "editor", anchor = "NW", row = 5, col = column, width = width, height = height,
      border = "double" })
end

function M.run_tests(mode)
  local cwd = vim.lsp.buf.list_workspace_folders()[1]
  local Job = require('plenary.job')

  if mode == "all" then
    M.command = "mix test"
  elseif mode == "buffer" then
    local file = vim.fn.expand('%')
    M.command = "mix test " .. file
  elseif mode == "cursor" then
    local file = vim.fn.expand('%')
    local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
    M.command = "mix test " .. file .. ":" .. line
  end

  M.clear_buffer()
  M.show_window()

  local job = Job:new({
    command = "/bin/zsh",
    args = { "-c", M.command },
    cwd = cwd,
    -- env = { PATH = vim.env.PATH, ASDF_DIR = "/Users/johnson/.asdf" },
    enable_recording = false,
    on_stdout = vim.schedule_wrap(function(_, line)
      vim.api.nvim_buf_set_lines(M.buffer, -1, -1, true, { line })
    end),
    on_stderr = vim.schedule_wrap(function(_, line)
      vim.api.nvim_buf_set_lines(M.buffer, -1, -1, true, { line })
    end),
    on_exit = function(_, _)
      vim.notify("Tests Completed", "info")
    end,
  })

  job:start()
end

return M
