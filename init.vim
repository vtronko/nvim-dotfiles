call plug#begin('~/.local/share/nvim/plugged')

Plug 'chrisbra/sudoedit.vim'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'ayu-theme/ayu-vim'
Plug 'Yggdroot/indentLine'
Plug 'w0rp/ale'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
Plug 'neomake/neomake'
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'rhysd/vim-clang-format'
Plug 'gillyb/stable-windows'

call plug#end()

source $HOME/.config/nvim/terminal.vim
source $HOME/.config/nvim/ale.vim

:set expandtab
:set copyindent
:set preserveindent
:set softtabstop=4
:set shiftwidth=4
:set tabstop=4
:set relativenumber
:set smartindent
:set colorcolumn=80
:set number

:set splitbelow
:set splitright

syntax on

set mouse=a
set nowrapscan
set hidden

set termguicolors
let ayucolor="mirage"
colorscheme ayu

hi Normal guibg=NONE ctermbg=NONE
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

"gitgutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_sign_removed = '-'
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

nnoremap <space> G

let mapleader = ';'
nnoremap <leader>nh :noh<CR>
nnoremap <leader>conf :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>tt :NERDTreeToggle<CR>
nnoremap <leader>tf :NERDTreeFind<CR>
" nnoremap <leader>g :GitGutterToggle<CR>
nnoremap <leader>nt :tabnew<CR>
nnoremap <leader>ct :tabclose<CR>
nnoremap <leader>' :Marks<CR>
nnoremap <leader>/ :Lines<CR>
nnoremap <leader>rg :Rg<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>gd :ALEGoToDefinition<CR>
nnoremap <leader>gt :ALEGoToDefinitionInTab<CR>
nnoremap <leader>ah :ALEHover<CR>
nnoremap <leader>ne :ALENext<cr>
nnoremap <leader>pe :ALEPrevious<cr>
nnoremap <leader>fr :ALEFindReferences<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <leader>ea <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <leader>ea <Plug>(EasyAlign)

nmap <leader>bb :Buffers<CR>
nmap <leader>be :enew<CR>
nmap <leader>bn :bnext<CR>
nmap <leader>bp :bprevious<CR>
nmap <leader>bd :bdelete<CR>

set pastetoggle=<leader>z

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

inoremap {<CR> {<CR>}<C-o>O
inoremap {;<CR> {<CR>};<C-o>O
inoremap {{ {  }<Left><Left>
inoremap (() ()<Left>
inoremap ((; ();<Left><Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap <> <><Left>
inoremap [[] []<Left>
inoremap [[; [];<Left><Left>

imap <c-s-t> <plug>(fzf-complete-path)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --hidden --fixed-strings --follow --ignore-case --no-ignore --glob "!.git/*" --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <leader>rg :Rg<CR>
