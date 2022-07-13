local M = {
  buffer = vim.api.nvim_create_buf(false, true)
}

local function expand(wc)
  return vim.fn.expand(wc, true)
end

local function vim_yank()
  vim.cmd(":y")
end

local function yank(filename)
  vim.api.nvim_buf_set_lines(M.buffer, 0, 1, false, { filename })
  vim.api.nvim_buf_call(M.buffer, vim_yank)
end

function M.yank_file()
  local filename = expand("%")

  yank(filename)
  print(filename)
end

function M.yank_line()
  local filename = expand("%")
  local line = filename .. ":" .. unpack(vim.api.nvim_win_get_cursor(0))

  yank(line)
  print(line)
end

function M.yank_absolute()
  local filename = expand("%:p")

  yank(filename)
  print(filename)
end

return M
