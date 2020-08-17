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
" Current change: not convinced that fzf through buffers is very common yet. 
" Looking through files seems more so, so make it so. 
"
" If it's really useful... we have <Leader>b for now.
nmap <Leader><Leader> :Files<CR>
nmap <Leader>b :Buffers<CR>
" ack
nmap <Leader>s :Ack! 
nmap <Leader>S :Ack! "\b<cword>\b" <CR>
" Consider x as alternative to close
nmap <Leader>q :cclose<CR> 
" Consider x as alternative for search, as close (like z)
"nmap <Leader>z :Files<CR>
" Quick reload command, nice for testing changes
nmap <Leader>r :source ~/.vimrc<CR>

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

" coc.nvim mappings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" K is nice, but \w is a little more convenient to hit; let's use both
" to show documentation for now
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> \w :call <SID>show_documentation()<CR>
" Toggle CoC (enable if disabled, and vice versa)
nmap \c :call <SID>coc_toggle()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Custom function to toggle CoC
function! s:coc_toggle()
  if get(g:, 'coc_enabled', 0) == 1
    execute "CocDisable"
  else
    execute "CocEnable"
  endif
endfunction

nnoremap <silent> <C-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <C-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <C-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>
