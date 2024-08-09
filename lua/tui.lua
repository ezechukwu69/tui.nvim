local M = {
    configs = {},
    commands = {}
}

M.start_tui = function(config)
    -- Create a new terminal buffer
    local buf = vim.api.nvim_create_buf(false, true)

    -- Calculate the window position and size
    local width = vim.o.columns - (config.width_margin * 2)
    local height = vim.o.lines - (config.height_margin * 2)
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
        border = config.border,
    }

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Start the TUI command in the terminal
    vim.fn.termopen(config.command)

    -- Optional: Set some buffer options
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

local defaultConfig = {
    width_margin = 3,
    height_margin = 3,
    border = 'rounded',
}

M.setup = function(opts)
    local command_name = opts.name
    opts.name = command_name

    -- Set default options
    opts = vim.tbl_deep_extend("force", defaultConfig, opts)

    -- Store the configuration
    table.insert(M.configs, opts)

    -- Register the command if not already registered
    if not M.commands[command_name] then
        vim.api.nvim_create_user_command(command_name, function()
            M.start_tui(opts)
        end, {})
        M.commands[command_name] = true
    end
end


return M
