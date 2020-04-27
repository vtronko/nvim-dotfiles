call plug#begin('~/.local/share/nvim/plugged')

" Plug 'ayu-theme/ayu-vim'
Plug 'w0rp/ale'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'andymass/vim-matchup'
Plug 'ap/vim-css-color'
Plug 'arcticicestudio/nord-vim'
Plug 'chrisbra/sudoedit.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'machakann/vim-highlightedyank'
Plug 'mechatroner/minimal_gdb'
Plug 'neoclide/coc.nvim', { 'do' : { -> coc#util#install() } }
Plug 'neomake/neomake'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'

set path+=/usr/local/include

let mapleader = ';'

call plug#end()

source $HOME/.config/nvim/ale.vim
source $HOME/.config/nvim/coc.vim
source $HOME/.config/nvim/terminal.vim
source $HOME/.config/nvim/abbrev.vim
source $HOME/.config/nvim/cpptemplates.vim
source $HOME/.config/nvim/maketemplates.vim
source $HOME/.config/nvim/cmaketemplates.vim
source $HOME/.config/nvim/shtemplates.vim

:set expandtab
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

:set splitbelow
:set splitright

syntax on

set mouse=a
set nowrapscan
set hidden

set termguicolors
" let ayucolor="mirage"
" colorscheme ayu
colorscheme nord

hi Normal guibg=NONE ctermbg=NONE
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" let g:airline_powerline_fonts = 1

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

nnoremap <silent><leader>nh :noh<CR>
nnoremap <silent><leader>noh :noh<CR>
nnoremap <silent><leader>conf :e ~/.config/nvim/init.vim<CR>
nnoremap <silent><leader>tt :NERDTreeToggle<CR>
nnoremap <silent><leader>tf :NERDTreeFind<CR>
nnoremap <silent><leader>nt :tabnew<CR>
" nnoremap <silent><leader>g :GitGutterToggle<CR>
nnoremap <silent><leader>ct :tabclose<CR>cpptemplates
nnoremap <silent><leader>' :Marks<CR>
nnoremap <silent><leader>/ :Lines<CR>
nnoremap <silent><leader>rg :Rg<CR>
nnoremap <silent><leader>ff :Files<CR>
nnoremap <silent><leader>delm :delmarks a-zA-Z0-9[]<CR>

xmap <silent><leader>ea <Plug>(EasyAlign)
nmap <silent><leader>ea <Plug>(EasyAlign)

nmap <silent><leader>bb :Buffers<CR>
nmap <silent><leader>be :enew<CR>
nmap <silent><leader>bn :bnext<CR>
nmap <silent><leader>bp :bprevious<CR>
nmap <silent><leader>qq :bdelete<CR>

set pastetoggle=<silent><leader>z

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
imap <C-u> _<Esc>mza<C-Right><Esc>bgUiw`zi<Del>
imap <c-s-t> <plug>(fzf-complete-path)
nnoremap q <nop>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --hidden --fixed-strings --follow --ignore-case --glob "!.git/*" --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <silent><leader>rg :Rg<CR>cpptemplates
