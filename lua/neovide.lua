local guifont_size = 11.0
vim.o.guifont = "Iosevka Nerd Font:h" .. tostring(guifont_size)

vim.keymap.set('i', '<C-V>', '<C-r>+')

vim.g.neovide_cursor_trail_size = 0.0

vim.keymap.set({ 'n', 'i', 'v' }, '<C-ScrollWheelDown>', function()
  guifont_size = guifont_size - 0.5
  vim.o.guifont = "Iosevka Nerd Font:h" .. tostring(guifont_size)
end)

vim.keymap.set({ 'n', 'i', 'v' }, '<C-ScrollWheelUp>', function()
  guifont_size = guifont_size + 0.5
  vim.o.guifont = "Iosevka Nerd Font:h" .. tostring(guifont_size)
end)
