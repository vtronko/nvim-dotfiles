call plug#begin('~/.local/share/nvim/plugged')

Plug 'SirVer/ultisnips'
Plug 'w0rp/ale'
Plug 'ryanoasis/vim-devicons'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'

set path+=/usr/local/include

let mapleader = ';'

call plug#end()

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

nnoremap <space> G

nnoremap <silent><mapleader>nh :noh<CR>
nnoremap <silent><mapleader>noh :noh<CR>

" nnoremap <silent><mapleader>nt :tabnew<CR>
" " nnoremap <silent><mapleader>g :GitGutterToggle<CR>
" nnoremap <silent><mapleader>ct :tabclose<CR>cpptemplates
" nnoremap <silent><mapleader>' :Marks<CR>
" nnoremap <silent><mapleader>/ :Lines<CR>
" nnoremap <silent><mapleader>rg :Rg<CR>
" nnoremap <silent><mapleader>fd :Fd<CR>
" nnoremap <silent><mapleader>delm :delmarks a-zA-Z0-9[]<CR>

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

" inoremap {<CR> {<CR>}<C-o>O
" inoremap {;<CR> {<CR>};<C-o>O
" inoremap {{ {  }<Left><Left>
" inoremap (() ()<Left>
" inoremap ((; ();<Left><Left>
" inoremap "" ""<Left>
" inoremap '' ''<Left>
" inoremap <<> <><Left>
" inoremap [[] []<Left>
" inoremap [[; [];<Left><Left>

imap <C-u> <Esc><Left>mza<C-Right><Esc>bgUiw`zi<Right><Right>
imap <c-s-t> <plug>(fzf-complete-path)

inoremap <C-k> <Up>
inoremap <C-j> <Down>

nnoremap q <nop>

inoremap <silent> <expr> <c-space> rpcnotify(g:neovim_channel, 'Gui', 'triggerCommand', 'TextEditor.CompleteThis') ? '<c-o><esc>' : '<c-o><esc>'

nnoremap <silent> gt :call rpcnotify(g:neovim_channel, 'Gui', 'triggerCommand', 'QtCreator.GotoPreviousInHistory')<cr>
nnoremap <silent> gT :call rpcnotify(g:neovim_channel, 'Gui', 'triggerCommand', 'QtCreator.GotoPreviousInHistory')<cr>

nnoremap <silent> == :call rpcnotify(g:neovim_channel, 'Gui', 'triggerCommand', 'TextEditor.AutoIndentSelection')<cr>
vnoremap <silent> = :call rpcnotify(g:neovim_channel, 'Gui', 'triggerCommand', 'TextEditor.AutoIndentSelection')<cr>

nnoremap <silent> gd :call rpcnotify(g:neovim_channel, 'Gui', 'triggerCommand', 'TextEditor.FollowSymbolUnderCursor', 'TextEditor.JumpToFileUnderCursor')<cr>
nnoremap <silent> gs :call rpcnotify(g:neovim_channel, 'Gui', 'triggerCommand', 'CppTools.SwitchHeaderSource')<cr>
nnoremap <silent> gf :call rpcnotify(g:neovim_channel, 'Gui', 'triggerCommand', 'TextEditor.JumpToFileUnderCursor')<cr>
nnoremap <silent> gr :call rpcnotify(g:neovim_channel, 'Gui', 'triggerCommand', 'TextEditor.FindUsages')<cr>

nnoremap <silent> <leader>trs :call rpcnotify(g:neovim_channel, 'Gui', 'triggerCommand', 'QtCreator.ToggleRightSidebar')<cr>
