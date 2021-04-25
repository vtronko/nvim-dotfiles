call plug#begin('~/.local/share/nvim/plugged')

" Plug 'dense-analysis/ale'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
" Plug 'airblade/vim-rooter'
Plug 'andymass/vim-matchup'
Plug 'ap/vim-css-color'
Plug 'arcticicestudio/nord-vim'
Plug 'chrisbra/sudoedit.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'machakann/vim-highlightedyank'
Plug 'neomake/neomake'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'editorconfig/editorconfig-vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'MattesGroeger/vim-bookmarks'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'easymotion/vim-easymotion'
Plug 'gyim/vim-boxdraw'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'qpkorr/vim-bufkill'
Plug 'b4skyx/serenade'
Plug 'tpope/vim-fugitive'
Plug 'goldsborough/clang-expand'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

set encoding=UTF-8
set clipboard=unnamedplus
set path+=/usr/local/include

let mapleader = ';'

call plug#end()

" source $HOME/.config/nvim/ale.vim
source $HOME/.config/nvim/coc.vim
source $HOME/.config/nvim/terminal.vim
source $HOME/.config/nvim/bookmarks.vim
source $HOME/.config/nvim/abbrev.vim
source $HOME/.config/nvim/cpptemplates.vim
source $HOME/.config/nvim/maketemplates.vim
source $HOME/.config/nvim/cmaketemplates.vim
source $HOME/.config/nvim/shtemplates.vim

:set splitbelow
:set expandtab
:set clipboard=unnamedplus
:set copyindent
:set preserveindent
:set softtabstop=4
:set shiftwidth=4
:set tabstop=4
:set relativenumber
:set smartindent
:set cmdheight=1
" :set colorcolumn=80
:set number

:set dir=$HOME/.vimswap

:set splitbelow
:set splitright

syntax on

set mouse=a
set nowrapscan
set hidden

set cursorline

set termguicolors
" let ayucolor="mirage"
" colorscheme ayu
colorscheme nord
" colorscheme serenade

hi Normal guibg=NONE ctermbg=NONE
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#fnamemod = ':%:.'

map <Space> <Plug>(easymotion-bd-w)
"gitgutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_sign_removed = '-'
nmap <leader>ggn <Plug>(GitGutterNextHunk)
nmap <leader>ggp <Plug>(GitGutterPrevHunk)
set updatetime=100

" fzf
let g:fzf_nvim_statusline = 0 " disable statusline overwriting
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" nnoremap <space> G

nnoremap <silent><leader>nh :noh<CR>
nnoremap <silent><leader>noh :noh<CR>
nnoremap <silent><leader>conf :e ~/.config/nvim/termconf.vim<CR>
nnoremap <silent><leader>tt :NERDTreeToggle<CR>
nnoremap <silent><leader>tf :NERDTreeFind<CR>
nnoremap <silent><leader>nt :tabnew<CR>
" nnoremap <silent><leader>g :GitGutterToggle<CR>
nnoremap <silent><leader>ct :tabclose<CR>cpptemplates
nnoremap <silent><leader>' :Marks<CR>
nnoremap <silent><leader>/ :Lines<CR>
nnoremap <silent><leader>rg :Rg<CR>
nnoremap <silent><leader>fd :Fd<CR>
nnoremap <silent><leader>delm :delmarks a-zA-Z0-9[]<CR>

xmap <silent><leader>ea <Plug>(EasyAlign)
nmap <silent><leader>ea <Plug>(EasyAlign)

nmap <silent><leader>bb :Buffers<CR>
nmap <silent><leader>be :enew<CR>
nmap <silent><leader>bn :bnext<CR>
nmap <silent><leader>bp :bprevious<CR>
nmap <silent><leader>qq :BD<CR>
nmap <silent><leader>q! :BD!<CR>

fun! ReadMan()
  " Assign current word under cursor to a script variable:
  let s:man_word = expand('<cword>')
  " Open a new window:
  :exe ":wincmd n"
  " Read in the manpage for man_word (col -b is for formatting):
  :exe ":r!man " . s:man_word . " | col -b"
  " Goto first line...
  :exe ":goto"
  " and delete it:
  :exe ":delete"
endfun
" Map the K key to the ReadMan function:
nnoremap <silent><leader>man :call ReadMan()<CR>

set pastetoggle=<silent><leader>z

inoremap <C-s> <Esc>:Snippets<CR>

" inoremap <C-h> <Left>
" inoremap <C-j> <Down>
" inoremap <C-k> <Up>
" inoremap <C-l> <Right>
" cnoremap <C-h> <Left>
" cnoremap <C-j> <Down>
" cnoremap <C-k> <Up>
" cnoremap <C-l> <Right>
 
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

inoremap {<CR> {<CR>}<C-o>O
inoremap {;<CR> {<CR>};<C-o>O
inoremap {{ {  }<Left><Left>
inoremap (() ()<Left>
inoremap ((; ();<Left><Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap <<> <><Left>
inoremap [[] []<Left>
inoremap [[; [];<Left><Left>

imap <C-u> <Esc><Left>mza<C-Right><Esc>bgUiw`zi<Right><Right>
imap <c-s-t> <plug>(fzf-complete-path)

inoremap <C-k> <Up>
inoremap <C-j> <Down>

map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>

nnoremap Q <nop>
nnoremap q <nop>
nnoremap <silent>qf :cclose<CR>
" :autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

command! -bang -nargs=? -complete=dir Fd
  \ call fzf#vim#grep(
  \   'fd '.shellescape(<q-args>),
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! Fd execute 'Files' s:find_git_root()

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'options': ['--preview', 'bat -p --theme=Nord --color always {}']}, <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --hidden --fixed-strings --follow --ignore-case --glob "!.git/*" --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

nmap <silent> <leader>hh :History<CR>

let g:neoterm_autoinsert = 1

map <c-j> 4jzz
map <c-k> 4kzz

