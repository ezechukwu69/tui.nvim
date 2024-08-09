local M = {}

M.config = {
    command = "",
    width_margin = 2,
    height_margin = 2,
    border = 'rounded',
    editor_command = "Tui"
}

M.start_tui = function()
    -- Create a new terminal buffer
    local buf = vim.api.nvim_create_buf(false, true)

    -- Calculate the window position and size
    local width = vim.o.columns - (M.config.width_margin * 2)
    local height = vim.o.lines - (M.config.height_margin * 2)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Set up window options
    local opts = {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        border = M.config.border,
    }

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Start the TUI command in the terminal
    vim.fn.termopen(M.config.command)

    -- Optional: Set some buffer options
    vim.api.nvim_buf_set_option(buf, 'buflisted', false)
    vim.api.nvim_buf_set_option(buf, 'filetype', 'tui')

    vim.cmd("startinsert")

    -- Automatically close the popup when the TUI exits
    vim.api.nvim_create_autocmd("TermClose", {
        buffer = buf,
        once = true,
        callback = function()
            vim.api.nvim_win_close(win, true)
        end,
    })
end

M.setup = function(opts)
  M.config = vim.tbl_extend('force', M.config, opts or {})
  vim.api.nvim_create_user_command(M.config.editor_command, M.start_tui, {})
end

return M
