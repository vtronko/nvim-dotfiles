let g:terminal_buffer = -1

function! FunctionCloseTerminal()
    function! CheckAndClose(winid)
        if (a:winid == g:terminal_buffer)
            echo "close"
            execute a:winid.'wincmd c'
        endif
    endfunction
    tabdo windo call CheckAndClose(winnr())
endfunction

function! FunctionOpenTerminal()
    call FunctionCloseTerminal()
    if !bufexists(g:terminal_buffer)
        :16 split term://zsh
        let g:terminal_buffer = bufnr('%')
        set nobuflisted
    else
        :16 split
        call nvim_win_set_buf(0, g:terminal_buffer)
        call nvim_win_set_height(0, 16)
    endif
endfunction

nnoremap tt :call FunctionOpenTerminal()<CR>i
tnoremap <silent><Esc> <C-\><C-n>:call FunctionCloseTerminal()<Cr>
