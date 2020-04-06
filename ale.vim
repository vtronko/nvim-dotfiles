let g:ale_enabled = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_c_parse_makefile = 1
let g:ale_c_gcc_executable= 'gcc'
let g:ale_cpp_gcc_executable= 'gcc'
let g:ale_c_gcc_options = '-std=gnu11 -Wall -Wextra -Wundef -Wpointer-arith -Wconversion -Wunreachable-code -Wcast-align -Wstrict-overflow=5 -Wshadow -Wfloat-equal -Wswitch-enum -fpie'
let g:ale_cpp_gcc_options = '-std=gnu++1z -Wall -Wextra -Wundef -Wpointer-arith -Wconversion -Wunreachable-code -Wcast-align -Wstrict-overflow=5 -Wshadow -Wfloat-equal -Wswitch-enum -fpie'

let g:ale_linters = {
            \   'c': ['gcc', 'clangtidy', 'ccls' ],
            \   'cpp': ['g++', 'clangtidy', 'ccls' ],
            \}
let g:ale_c_ccls_init_options = {
	\ 'cacheDirectory': '/tmp/ccls/c-cache',
	\ 'cacheFormat': 'binary',
	\}

let g:ale_cpp_ccls_init_options = {
	\ 'cacheDirectory': '/tmp/ccls/cpp-cache',
	\ 'cacheFormat': 'binary',
	\}
