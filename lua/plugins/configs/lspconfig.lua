local present1, lsp_config = pcall(require, "lspconfig")
local present2, lsp_installer = pcall(require, "nvim-lsp-installer")

if not (present1 or present2) then
   return
end

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  vim.api.nvim_set_keymap('n', '<leader>lsd', '<cmd>lua vim.lsp.diagnostic.disable()<CR>',  {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>lsde', '<cmd>lua vim.lsp.diagnostic.enable()<CR>',  {noremap = true, silent = true})

  buf_set_keymap("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "<leader>gh", "<cmd>ClangdSwitchSourceHeader<CR>", opts)
  buf_set_keymap("n", "<leader>K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<leader>gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  -- buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "<leader>ed", "<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "<leader>ed", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "<leader>ep", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "<leader>en", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  -- buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("v", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type -- For 0.6.0
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }

    server:setup(opts)
end)
