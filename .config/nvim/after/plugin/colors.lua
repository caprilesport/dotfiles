function ColorThatBitch()
    vim.cmd.colorscheme("dracula")
    -- vim.cmd.colorscheme("tokyonight-night")
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorThatBitch()
