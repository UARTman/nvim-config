local guifont_size = 11.0
vim.o.guifont = "Iosevka Nerd Font:h" .. tostring(guifont_size)

vim.keymap.set('i', '<C-V>', '<C-r>+')

vim.g.neovide_position_animation_length = 0.01
vim.g.neovide_cursor_animation_length = 0.01
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_scroll_animation_far_lines = 0
vim.g.neovide_scroll_animation_length = 0.00

vim.keymap.set({ 'n', 'i', 'v' }, '<C-ScrollWheelDown>', function()
  guifont_size = guifont_size - 0.5
  vim.o.guifont = "Iosevka Nerd Font:h" .. tostring(guifont_size)
end)

vim.keymap.set({ 'n', 'i', 'v' }, '<C-ScrollWheelUp>', function()
  guifont_size = guifont_size + 0.5
  vim.o.guifont = "Iosevka Nerd Font:h" .. tostring(guifont_size)
end)
