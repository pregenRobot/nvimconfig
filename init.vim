syntax on

" the relevant modules (add to plug-section if you already have one)
call plug#begin()
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
" Fast python completion (use ncm2 if you want type info or snippet support)
Plug 'HansPinckaers/ncm2-jedi'
" Words in buffer completion
Plug 'ncm2/ncm2-bufword'
" Filepath completion
Plug 'ncm2/ncm2-path'
Plug 'morhetz/gruvbox'
Plug 'ap/vim-buftabline'
Plug 'mhinz/vim-signify'

if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-commentary'
Plug 'mhinz/vim-startify'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

"KEY BINDINGS ======================================================
let mapleader = ","
inoremap <c-c> <ESC>

"Iterating through buffers
nmap <leader>l :bp<cr>
nmap <leader>; :bn<cr>

"Toggle Syntastic window for linting
function! ToggleSyntastic()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            lclose
            return
        endif
    endfor
    SyntasticCheck
endfunction
nnoremap <leader>sc  :call ToggleSyntastic()<CR>

"Using tab for auto completion
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

"Iterating through different warnings in Syntastic
nmap \ :lnext<cr>
nmap - :lprev<cr>

"Toggle NerdTree
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction
nmap <leader>t :NERDTreeToggle<cr>


"Close NerdTree if buffer is closed
nnoremap c :bp\|bd #<CR>

"PLUGIN SETTINGS ========================================== 

"airline
let g:airline_theme="light"
let g:tabline_theme="light"
let g:airline_powerline_fonts = 1                                                                                                         
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

"ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1, 1]]
let g:ncm2#matcher = 'substrfuzzy'

"jedi
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"

"syntastic
let g:PyFlakeOnWrite = 1
let g:PyFlakeCheckers = 'pep8,mccabe,pyflakes'
let g:PyFlakeDefaultComplexity=10
let g:syntastic_python_checkers = ["pyflakes"]
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height=5

"nerdTree
let NERDTreeShowHidden=1
au VimEnter * NERDTree

"USER INTERFACE ==============================================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set mouse=a  " change cursor per mode
set number  " always show current line number
set tw=79
set showcmd
set shortmess+=c
set expandtab
set tabstop=4
set shiftwidth=4
set fillchars+=vert:\  " remove chars from seperators
set softtabstop=4
set lbr  " wrap words
set scrolloff=3 " keep three lines between the cursor and the edge of the screen
set laststatus=2  " always slow statusline
set splitright  " i prefer splitting right and below
set splitbelow

"FUNCTIONALITY =================================================
set backspace=indent,eol,start
set fileformat=unix
set shortmess+=c
set wrapscan  " begin search from top of file when nothing is found anymore
set completeopt=menuone,noselect,noinsert
set history=1000  " remember more commands and search history
set nobackup  " no backup or swap file, live dangerously
set noswapfile  " swap files give annoying warning
set breakindent  " preserve horizontal whitespace when wrapping
set showbreak=..
set undodir=~/.vim/undodir
set undofile  " save undos
set undolevels=10000  " maximum number of changes that can be undone
set undoreload=100000  " maximum number lines to save for undo on a buffer reload
set hlsearch  " highlight search and search while typing
set incsearch
set cpoptions+=x  " stay at seach item when <esc>
set noerrorbells  " remove bells (i think this is default in neovim)
set visualbell
set t_vb=
set viminfo='20,<1000  " allow copying of more than 50 lines to other applications
set clipboard=unnamed
filetype indent on

"COLORS AND THEMES =============================================== 
set background=dark
let g:gruvbox_invert_tabline = 1
let g:gruvbox_contrast_dark = "hard"
autocmd vimenter * colorscheme gruvbox


