let g:ale_enabled = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
" let g:ale_completion_enabled = 1
let g:ale_completion_enabled = 0
" let g:ale_c_parse_makefile = 1
" let g:ale_c_parse_makefile = 0
let g:ale_c_gcc_executable= 'gcc'
let g:ale_cpp_clang_executable= 'clang'
" let g:ale_c_clang_options = '-std=gnu11 -Wall -Wextra -Wundef -Wpointer-arith -Wconversion -Wunreachable-code -Wunused-variable -Wcast-align -Wstrict-overflow=5 -Wshadow -Wfloat-equal -Wswitch-enum -fpie'
" let g:ale_cpp_clang_options = '-std=gnu++1z -Wall -Wextra -Wunused-variable -Wundef -Wpointer-arith -Wconversion -Wunreachable-code -Wcast-align -Wstrict-overflow=5 -Wshadow -Wfloat-equal -Wswitch-enum -fpie'

let g:ale_linters = {
            \ 'asm' : ['nasm'],
            \  'c': ['clang-tidy'],
            \  'cpp': ['clang-tidy'],
            \  'ruby': ['standardrb'],
            \  'shell': ['shellcheck'],
            \}
let g:ale_c_build_dir_names =  ['build/Debug']

" nnoremap <silent><leader>gd :ALEGoToDefinition<CR>
" nnoremap <silent><leader>gt :ALEGoToDefinitionInTab<CR>
" nnoremap <silent><leader>ah :ALEHover<CR>
nnoremap <silent><leader>ad :ALENext<cr>
nnoremap <silent><leader>ef :ALENext<cr>
nnoremap <silent><leader>eb :ALEPrevious<cr>
" nnoremap <silent><leader>fr :ALEFindReferences<cr>
