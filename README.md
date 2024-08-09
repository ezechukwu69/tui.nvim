# **TUI.nvim**
A minimal neovim plugin for wrapping cli TUI plugins and opening them within neovim
Examples of plugins use cases include:

- ***LazyGit***
- ***Ranger***
- ***NNN***
- ***Yazi***

Use your favourite command line TUI within neovim  
All TUIs mentioned above have been tested

### Installation
<details>
    <summary>Lazy</summary>
    
    Example wrapping lazygit
   ```lua
        {
            "ezechukwu69/tui.nvim",
            config = function()
                require("tui").setup({
                    name = "LazyGitTUI",
                    command = "lazygit",
                    width_margin = 10,
                    height_margin = 10,
                    border = 'rounded',
                })
            end,
            keys = {
                { "<leader>tg", "<cmd>LazyGitTUI<cr>", desc = "LazyGitTUI" },
            }
        }
```
</details>


### Config documentation

| Title        | Description |
| -------------| ----------- |
| `name`         | Name of TUI also the Command to be called in the editor e.g ***:{{name}}*** |
| `command`      | Name of the tui command as run in the terminal |
| `width_margin` | margin between left and right of the editor |
| `height_margin`| margin between top and bottom of the editor |
| `border`       | Border style e.g `rounded` |

