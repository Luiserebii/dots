" Minimum needed for netrw and probably some other stuff
set nocompatible
filetype plugin on

" Create convenient mappings for window switching
nnoremap <C-Left> <C-w>h
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-w>l

" For whatever reason, tmux needs this
set background=dark

" blorp will this really not cause a need to :bufdo e ++enc=sjis %???
" ... probably not, but screw it
set fileencodings+=sjis

" Convenient for :argdo, and I guess this kind of behavior is fine.
" Will we break something? Are we running into a wall by doing this?
" I don't know, but I guess it's worth a try
set hidden

" Expand to active buffer directory with %%
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Set equalprg to clang-format for `=` operator so we can get fun time format
autocmd FileType c,cpp setlocal equalprg=clang-format

" Custom leader mappings (follow the leader, beep beep)
" fzf
nmap <Leader>\ :Buffers<CR>
nmap <Leader>f :Files<CR>
" ack
nmap <Leader>s :Ack! 
nmap <Leader>S :Ack! "\b<cword>\b" <CR>
" Consider x as alternative to close
nmap <Leader>q :cclose<CR> 
" Consider x as alternative for search, as close (like z)
"nmap <Leader>z :Files<CR>

" ~ ~ ~ ~ Plugins ~ ~ ~ ~"
"
call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'

call plug#end()

" fzf mappings
nnoremap <C-p> :<C-u>FZF<CR>

" ack.vim settings
let g:ackprg = 'ag --vimgrep'

" vim-tmux-navigator mappings
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <C-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <C-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>
