"" Disable VI compatibility
set nocp

set backspace=2
set number
set hlsearch
set incsearch
set visualbell
set tabstop=4
set shiftwidth=4
set expandtab
set syntax=on

" Enable pathogen package management
" See https://github.com/tpope/vim-pathogen
execute pathogen#infect()

abbr ~~~ DaLee <mail.dalee@gmail.com>

" Init spell check but deactivate it on startup
" Can be activated with :set spell
set nospell
set spelllang=en_us
hi SpellBad ctermfg=black ctermbg=red cterm=underline,bold
hi SpellLocal ctermfg=black ctermbg=yellow cterm=underline,bold
hi SpellRare ctermfg=yellow cterm=underline,bold 

" Enable code completion with ^C^O
set omnifunc=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" Enable custom status line
"│ Filename [Type] [+]│                          │ [0x0] │ L:1  │C:1 │

set noruler
set statusline+=│               " Horizontal bar
set laststatus=2    
set statusline+=\ %F\ %y        " Filename + type
set statusline+=%m              " [+] if modified
set statusline+=│               " Horizontal bar
set statusline+=%=              " Switch to the right side
set statusline+=│               " Horizontal bar
set statusline+=\ [0x%B]\       " Character code under cursor
set statusline+=│               " Horizontal bar
set statusline+=\ L\:%-04.4l    " L: LINE
set statusline+=│               " Horizontal bar
set statusline+=\ C\:%-04.4c    " C: Character
set statusline+=│               " Horizontal bar


" Styles
set fillchars+=vert:│
hi VertSplit ctermbg=2 ctermfg=0


" Key mappings
map <C-n> :NERDTreeToggle<CR>
nnoremap <C-l> :call NumberToggle()<cr>

" Autocommands
"  Close if NERDTree is the only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Functions
function! NumberToggle()
  if(&number == 1)
    set relativenumber
    set nonumber
  elseif(&relativenumber == 1)
    set norelativenumber
    set nonumber
  else
    set norelativenumber
    set number
  endif
endfunc

