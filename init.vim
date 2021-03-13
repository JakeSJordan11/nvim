" ===========================================================================
"                               SHELL
" ===========================================================================
" done withing windows terminal preferences so not needed here
"
" make terminal run powershell without info at top
" let &shell = has('wsl') ? 'zsh' : 'pwsh'
" set shellquote= shellpipe=\| shellxquote=
" set shellredir=\|\ Out-File\ -Encoding\ UTF8
"   
" ===========================================================================
"                               GENERAL
" ===========================================================================

set number				        " show line numbers
set relativenumber		        " show relative number with padding
set nohlsearch			        " only highlight current search result
set nowrap				        " do not wrap text
set scrolloff=8                 " keep cursor in the middle when scrolling
set tabstop=4 softtabstop=4     " ======================
set shiftwidth=4                " set better tab spacing
set expandtab                   " ======================
set colorcolumn=80              " set width column reminder
set splitbelow                  " make split open on bottom
set updatetime=50               " snappier feel and better performance
set noshowmode                  " hide mode showing int the command section
set termguicolors               " allows custom highlight colors
set hidden                      " unhides terminal buffers that are closed

"may need sets the auto complete menu in insert mode to behave cleaner
"set completeopt=menuone,preview,noinsert,noselect

" ===========================================================================
"                               VIM-PLUG
" ===========================================================================

call plug#begin('~/AppData/Local/nvim/plugged')

Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
" Plug 'kevinoid/vim-jsonc'
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
" Plug 'machakann/vim-sandwich'
" Plug 'luochen1990/rainbow'
Plug 'alvan/vim-closetag'
Plug 'prettier/vim-prettier', { 'do': 'yarn install'  }
call plug#end()



" ===========================================================================
"                               THEME
" ===========================================================================

colorscheme gruvbox                 " set general color theme
set background=dark                 " set the background color for the theme
let g:airline_theme='night_owl'     " sets the airline theme
highlight Normal guibg=none         " remove the background color of the theme
highlight LineNr guifg=#5eacd3      " set the color of the line numbers
highlight Comment guifg=#5eacd3     " set the color of comments
highlight CursorLineNr guibg=none   " remove relative line number highlight

" ===========================================================================
"                           PLUGIN SETTINGS
" ===========================================================================
"                           ===VIM-CLOSETAG===
let g:closetag_filenames = '*.html, *.xhtml, *.phtml, *.jsx, *.tsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx, *.tsx'
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'
"
"
"                           ===RAINBOW===
"set to 0 if you want to enable it later via :RainbowToggle"
" let g:rainbow_active = 1
"                           ===PRETTIER===
" autocmd BufWritePre *.tsx,*.ts Prettier

"                           ===NERDTREE===

" Open nerd tree when no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:NERDTreeMinimalUI = 1             " remove help menu on startup
let g:NERDTreeDirArrowExpandable = ''   " remove expandaple arrows
let g:NERDTreeDirArrowCollapsible = ''  " remove collapsible arrows
let g:NERDTreeQuitOnOpen = 1            " close NERDTree after selecting a file

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, guifg)
exec 'autocmd filetype nerdtree highlight ' . a:extension .' guifg='. a:guifg
exec 'autocmd filetype nerdtree syn match '
            \ . a:extension .' #^\s\+.*'.a:extension .'$#'
endfunction

" change file extension colors
call NERDTreeHighlightFile('ts',    '#5EACD3')
call NERDTreeHighlightFile('js',    '#5EACD3')
call NERDTreeHighlightFile('tsx',   '#5EACD3')
call NERDTreeHighlightFile('jsx',   '#5EACD3')
call NERDTreeHighlightFile('json',  '#83DCC8')
call NERDTreeHighlightFile('lock',  '#5EACD3')
call NERDTreeHighlightFile('md',    '#5EACD3')
call NERDTreeHighlightFile('log',   '#5EACD3')
call NERDTreeHighlightFile('rs',    '#AFD75F')


" ===========================================================================
"                           KEYBINDINGS
" ===========================================================================

" set leader and local leader
nnoremap <space> <nop>
let mapleader = ' '
let maplocalleader = ' '

" do not allow Ctrl Z to suspend on windows
if has('win32')
    nmap <C-z> <Nop>
endif

" edit and source init.vim bindings
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" set NERDTree toggle binding
nnoremap <c-b> :NERDTreeToggle<cr>

" use alt+hjkl to move between split/vsplit panels
tnoremap <a-h> <c-\><c-n><c-w>h
tnoremap <a-j> <c-\><C-n><c-w>j
tnoremap <a-k> <c-\><c-n><c-w>k
tnoremap <a-l> <c-\><c-n><c-w>l
nnoremap <a-h> <c-w>h
nnoremap <a-j> <c-w>j
nnoremap <a-k> <c-w>k
nnoremap <a-l> <c-w>l

" use ctrl+hjkl to resize split/vsplit panels
tnoremap <c-h> <c-\><c-n><c-w><
tnoremap <c-j> <c-\><C-n><c-w>-
tnoremap <c-k> <c-\><c-n><c-w>+
tnoremap <c-l> <c-\><c-n><c-w>>
nnoremap <c-h> <c-w><
nnoremap <c-k> <c-w>-
nnoremap <c-j> <c-w>+
nnoremap <c-l> <c-w>>

" move current line up or down
nnoremap - :move +1<CR>
nnoremap = :move -2<CR>

" TODO toggle comments on and off
" TODO should be using autocommand groups augroup
" function! ToggleComment()
    " if exists(ToggleComment)
        " command Ihey <esc>
    " else
        " command I <esc> d3l<space><space><space>
    " endif
" endfunction

" comment line
augroup vim
    autocmd!
    autocmd FileType vim nnoremap <localleader>/ I" <esc>
augroup END

augroup javascriptreact
    autocmd!
    autocmd FileType javascriptreact nnoremap <buffer> <localleader>/ I//<esc>
augroup END

augroup javascript
    autocmd!
    autocmd FileType javascript nnoremap <buffer> <localleader>/ I//<esc>
augroup END

augroup tyepscript
    autocmd!
    autocmd FileType typescript nnoremap <buffer> <localleader>/ I//<esc>
augroup END

augroup typescriptreact
    autocmd!
    autocmd FileType typescriptreact nnoremap <buffer> <localleader>/ I//<esc>
augroup END

augroup rust
    autocmd!
    autocmd FileType rust nnoremap <buffer> <localleader>/ I//<esc>
augroup END

augroup python
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>/ I#<esc>
augroup END

augroup c#
    autocmd!
    autocmd FileType c# nnoremap <buffer> <localleader>/ I//<esc>
augroup END

augroup json
    autocmd!
    autocmd FileType json nnoremap <buffer> <localleader>/ I//<esc>
augroup END

" ===========================================================================
"                       CONQUER OF COMPLETION
" ===========================================================================

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <tab>
    \ pumvisible() ? "\<c-n>" :
    \ <sid>check_back_space() ? "\<tab>" :
    \ coc#refresh()
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <cr> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<c-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics
" of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <sid>show_documentation()<cr>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" ===========================================================================
"                   LEARN VIMSCRIPT BOOK EXAMPLES
" ===========================================================================
nnoremap <leader>f :call FoldColumnToggle()<cr>

function! FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=4
    endif
endfunction

nnoremap <leader>q :call QuickfixToggle()<cr>

let g:quickfix_is_open = 0

function! QuickfixToggle()
    if g:quickfix_is_open
    cclose
    let g:quickfix_is_open = 0
    execute g:quickfix_return_to_window . 'wincmd w'
else
    let g:quickfix_return_to_window = winnr()
    copen
    let g:quickfix_is_open = 1
endif
endfunction

" terminal testing crap
autocmd TermOpen * setlocal nonumber norelativenumber | startinsert

let s:terminal1_buffer_name = -1
" OpenTerminal()
" if terminal is open then do nothing
" if terminal is in the buffer but is not open then open terminal from buffer
" if terminal is not open and does not exist in the buffer then create one
function! OpenTerminal1()
    if !bufexists(s:terminal1_buffer_name)
        split
        terminal pwsh -NoLogo
        resize 10
        file Terminal 1
        let s:terminal1_buffer_name = bufname('%')
    else
        split
        buffer Terminal 1
        resize 10
    endif
endfunction

" CloseTerminal()
" if a terminal is open then hide it
" if a terminal is in the buffer but is not open do nothing
" if terminal is not open and does not exist in buffer do nothing
function! CloseTerminal1()
    if bufexists(s:terminal1_buffer_name)
        hide
    endif
endfunction

" ToggleTerminal()
" if there is an open terminal then hide it
" if there is a terminal in the buffer that is not open then open it
function! ToggleTerminal1()
    if &buftype == 'terminal'
        call CloseTerminal1()
    else
        call OpenTerminal1()
    endif
endfunction
        
nnoremap <leader>`1 :call ToggleTerminal1()<cr>
tnoremap <leader>`1 <c-\><c-n>:call ToggleTerminal1()<cr>

let s:terminal2_buffer_name = -1
" OpenTerminal()
" if terminal is open then do nothing
" if terminal is in the buffer but is not open then open terminal from buffer
" if terminal is not open and does not exist in the buffer then create one
function! OpenTerminal2()
    if !bufexists(s:terminal2_buffer_name)
        split
        terminal pwsh -NoLogo
        resize 10
        file Terminal 2
        let s:terminal2_buffer_name = bufname('%')
    else
        split
        buffer Terminal 2
        resize 10
    endif
endfunction

" CloseTerminal()
" if a terminal is open then hide it
" if a terminal is in the buffer but is not open do nothing
" if terminal is not open and does not exist in buffer do nothing
function! CloseTerminal2()
    if bufexists(s:terminal2_buffer_name)
        hide
    endif
endfunction

" ToggleTerminal()
" if there is an open terminal then hide it
" if there is a terminal in the buffer that is not open then open it
function! ToggleTerminal2()
    if &buftype == 'terminal'
        call CloseTerminal2()
    else
        call OpenTerminal2()
    endif
endfunction
        
nnoremap <leader>`2 :call ToggleTerminal2()<cr>
tnoremap <leader>`2 <c-\><c-n>:call ToggleTerminal2()<cr>

" ========================= TERMINAL TESTING ==================================

" let s:terminal_buffer_name = -1
" OpenTerminal()
" if terminal is open then do nothing
" if terminal is in the buffer but is not open then open terminal from buffer
" if terminal is not open and does not exist in the buffer then create one
" function! OpenTerminal(terminal_number)
    " if !bufexists(s:terminal_buffer_name)
        " split
        " terminal pwsh -NoLogo
        " resize 10
        " file "Terminal" a:terminal_number
        " let s:terminal_buffer_name = bufname("%")
    " else
        " split
        " buffer "Terminal" a:terminal_number
        " resize 10
    " endif
" endfunction

" CloseTerminal()
" if a terminal is open then hide it
" if a terminal is in the buffer but is not open do nothing
" if terminal is not open and does not exist in buffer do nothing
" function! CloseTerminal()
    " if bufexists(s:terminal_buffer_name)
        " hide
    " endif
" endfunction

" ToggleTerminal()
" if there is an open terminal then hide it
" if there is a terminal in the buffer that is not open then open it
" function! ToggleTerminal(terminal_number)
    " if &buftype == 'terminal'
        " call CloseTerminal()
    " else
        " call OpenTerminal(a:terminal_number)
    " endif
" endfunction

" nnoremap <leader>`3 :call ToggleTerminal(3)<cr>
" tnoremap <leader>`3 <c-\><c-n>:call ToggleTerminal(3)<cr>

" nnoremap <leader>`4 :call ToggleTerminal("4")<cr>
" tnoremap <leader>`4 <c-\><c-n>:call ToggleTerminal("4")<cr>
