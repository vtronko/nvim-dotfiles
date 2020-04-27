let g:terminal_buffer = -1

" function! FunctionCloseTerminal()
function! FunctionCloseAllTerminals()
    function! CheckAndClose(win_nr)
        let l:winid = win_getid(a:win_nr)
        let l:bufid = nvim_win_get_buf(l:winid)
        let l:buftype = nvim_buf_get_option(l:bufid, 'buftype')
        if (l:buftype == 'terminal')
            execute a:win_nr.'wincmd c'
        endif
    endfunction
    tabdo windo call CheckAndClose(winnr())
endfunction

function! FunctionOpenTerminal()
    call FunctionCloseAllTerminals()
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

nnoremap <silent>tt :call FunctionOpenTerminal()<CR>i
tnoremap <silent><Esc> <C-\><C-n>:call FunctionCloseAllTerminals()<Cr>
