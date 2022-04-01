local utils = require "core.utils"

local dap = require('dap')

dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode-12', -- adjust as needed
    name = "lldb",
}

dap.adapters.python = {
  type = 'executable';
  command = 'python3';
  args = { '-m', 'debugpy.adapter' };
}

local map = utils.map

dap.configurations.cpp = 
{
    {
        name = "Run",
        type = "lldb",
        request = "launch",
        args = { '9' },
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,

        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
        runInTerminal = false,
    },
    {
        name = "Attach to process",
        type = 'lldb',  -- Adjust this to match your adapter name (`dap.adapters.<name>`)
        request = 'attach',
        pid = require('dap.utils').pick_process,
        args = {},
        runInTerminal = false,
    },
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      return '/usr/bin/python3'
    end;
  },
}

-- vim.cmd [[ autocmd BufWritePost :luafile % ]]

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

vim.fn.sign_define('DapBreakpoint', {text='', texthl='DapBreakpoint', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='', texthl='DapStopped', linehl='', numhl=''})

map('n', '<leader>dd', '<cmd>lua require"dap".continue()<CR>')
map('n', '<leader>dn', '<cmd>lua require"dap".step_over()<CR>')
map('n', '<leader>di', '<cmd>lua require"dap".step_into()<CR>')
map('n', '<leader>do', '<cmd>lua require"dap".step_out()<CR>')
map('n', '<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
map('n', '<leader>drl', '<cmd>lua require"dap".run_last()<CR>')

map('n', '<leader>dh', '<cmd>lua require"dap.ui.widgets".hover()<CR>')
map('n', '<leader>ds', "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")
-- map('n', '<leader>df', "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.frames)<CR>")
map('n', '<leader>dfu', '<cmd>lua require"dap".up()<CR>')
map('n', '<leader>dfd', '<cmd>lua require"dap".down()<CR>')

map('n', '<leader>dq', '<cmd>lua require"dap".close()<CR>')
map('n', '<leader>dc', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
-- map('n', '<leader>dlb', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
map('n', '<leader>dr', '<cmd>lua require"dap".repl.open()<CR>')
-- map('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>')
