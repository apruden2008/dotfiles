" TODO 

" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
" filetype off

" Initialize Pathogen package manager
execute pathogen#infect()

" Load plugins here (pathogen or vundle)
filetype plugin on

" Turn on syntax highlighting
syntax enable

" For plugins to load correctly
filetype plugin indent on

" Enable fuzzy finder in VIM
set rtp+=~/.fzf

" Set a leader key
let mapleader = ","

" Set a local leader key
let maplocalleader = "\\"

" Security
set modelines=0

" Show line numbers relative to the line you are on
" set relativenumber

" If you want to set absolute, uncomment following line
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=90
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
" nnoremap j gj
" nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" Clear search
map <leader><space> :let @/=''<cr> 

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default

" Color scheme (terminal)
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
" let g:seoul256_background = 235
colo solarized
" colorscheme seoul256

" let g:airline_theme = 'simple'   " or 'luna', 'base16', etc.

" ALEX CUSTOMIZATION

" Initialize the status line (replaced w/ Airline plugin)
" set statusline=%f   " Path to file on LHS
" set statusline+=%=  " Move to RHS
" set statusline+=%l  " Show current line 
" set statusline+=/   " Separator
" set statusline+=%L  " Show total lines

" TODO: Fix this later
" Create toggle to show fold column
" nnoremap <leader>F :call FoldColumnToggle()<cr>

" function! FoldColumnToggle() 
"   if &foldcolumn setlocal foldcolumn=0 
"   else setlocal foldcolumn=4 
"   endif 
" endfunction

" Toggle to show the Quickfix Window

" Copy line to system register

" Adjust textwidth to allow for easier buffer copying from Vim
nnoremap <leader>tw :call ToggleTextWidth()<cr>

function! ToggleTextWidth() 
  if &textwidth==90 
    setlocal textwidth=900 
  else 
    setlocal textwidth=90
  endif 
  normal! gggqG
endfunction

nnoremap <leader>y "+yy

" Cut to system register
nnoremap <leader>d "+d

" Paste from system register
nnoremap <leader>p "+p

nnoremap <leader>q :call <SID>QuickfixToggle()<CR>

nnoremap ,t :echo "vimrc is working!"<CR>

let g:quickfix_is_open = 0

function! s:QuickfixToggle()
  if g:quickfix_is_open
    cclose
    let g:quickfix_is_open = 0
    execute g:quickfix_return_to_window . "wincmd w"
  else
    let g:quickfix_return_to_window = winnr()
    copen
    let g:quickfix_is_open = 1
  endif
endfunction

" Set default grepprg as ripgrep
set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow

" Key Remapping ----------------------------- {{{
" Toggle search highlighting
" nnoremap <Space> :set hlsearch!<CR>

" Toggle line numbers
nnoremap <leader>N :setlocal number!<CR>

" Toggle tabs and EOL
nnoremap <leader>lc :set list!<CR> 

" Delete line and paste below/above in one keystroke
nnoremap - ddp
nnoremap _ ddkP

" Delete/change to end of line
nnoremap ds d$
nnoremap cs c$

" Toggle upper/lower case for a word in insert mode 
inoremap <c-l> <esc>viwui inoremap <c-u> <esc>viwUi

" Open and update vimrc while editing a file
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Easy window switch
nnoremap <leader>w <c-w>w
" TODO - create a quick keystroke for rotating windows <c-w>r

" Open last buffer in a horizontal split [TODO]
nnoremap <leader>l :<c-u>execute "rightbelow split " . bufname("#")<cr>
"
" Create a new buffer and open it in a vertical split
nnoremap <leader>vs :rightbelow vnew<CR>

" Easy return to normal mode from insert mode
inoremap jk <esc>
vnoremap jk <esc>

" Motion to next parentheses / delete last parentheses, brackets, etc

onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap il[ :<c-u>normal! F]vi[<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F}vi{<cr>

" TODO create an operator mapping to delete a function

" Highlight trailing whitespace as an error

nnoremap <leader>s :<c-u>execute "mat Error " . '/\v\s$/'<cr> 
nnoremap <leader>S :<c-u>execute "mat none"<cr>

" Increase / decrease window width

nnoremap <leader>1 :let &columns = &columns + 40<cr><c-w>=
nnoremap <leader>2 :let &columns = &columns - 40<cr><c-w>=

" Increase / decrease window height

nnoremap <leader>3 :let &lines = &lines + 10<cr><c-w>=
nnoremap <leader>4 :let &lines = &lines - 10<cr><c-w>=

" Open NERDTree for FS navigation

nnoremap <leader>nt :NERDTree<cr>

" Jump to last edited buffer
nnoremap <leader>B :ls<cr>:b<space>
" }}}

iabbrev asig -- <cr>Alex<cr>apruden2008@gmail.com
iabbrev __rocket 🚀
iabbrev __green_check ✅

" AUTOCOMMANDS

" Automatically save new files
" autocmd BufNewFile * :write

" vim-gutentags configuration ----------------- {{{
" --- VIM-GUTENTAGS CONFIGURATION ---

" 1. Tell Gutentags to use a central cache directory
" This prevents 'tags' files from cluttering every project root.
" It will store tags in ~/.cache/tags
let g:gutentags_cache_dir = expand('~/.cache/tags')

" 2. Always generate/update tags when a file is written/saved (recommended)
let g:gutentags_generate_on_write = 1

" 3. Show the status in the Vim status line (optional, but helpful)
set statusline+=%{gutentags#statusline()}

" }}}

" Language-specific settings ----------------- {{{
" Easy comments for Javascript and Python files
augroup filetype_js
  autocmd!
  autocmd FileType javascript nnoremap <buffer> <localleader>c I//<space><esc>
  autocmd FileType javascript nnoremap <buffer> <localleader>C ^xxx<esc>
  
  " Auto create an if block by using the iff abbrev in js files
  autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
augroup END

augroup filetype_py
  autocmd!  
  autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>
  autocmd FileType python     nnoremap <buffer> <localleader>C ^x<esc>
  autocmd Filetype python     set textwidth=80
augroup END

augroup filetype_rs
  autocmd!  
  " Comment and uncomment
  autocmd FileType rust       nnoremap <buffer> <localleader>c I//<space><esc>
  autocmd FileType rust       nnoremap <buffer> <localleader>C ^xxx<esc>

  " Doc comment and un-doc comment
  autocmd FileType rust       nnoremap <buffer> <localleader>d I///<space><esc>
  autocmd FileType rust       nnoremap <buffer> <localleader>D ^xxxx<esc>

  " Set the compiler to cargo, run commands using :make + whatever cargo cmd
  autocmd FileType rust       compiler cargo

  " Shorthand for print line and assert_eq! macros
  autocmd Filetype rust       iabbrev pr println!
  autocmd Filetype rust       iabbrev ae assert_eq!

augroup END
" }}}

" Text and Markdown file settings ----------------------- {{{
augroup filetype_txt
  autocmd! 
  
  " Turn of relative number for text files
  autocmd BufNewFile,BufRead *.txt setlocal nonumber spell
  autocmd BufNewFile,BufRead *.md setlocal nonumber spell

  " Keyboard shortcut to access section headers for markdown
  autocmd FileType text onoremap ik :<c-u>execute "normal! ?^#\\+\r:nohlsearch\rwhv$bbe"<cr> 
  autocmd FileType text onoremap ak :<c-u>execute "normal! ?^#\\+\r:nohlsearch\rV"<cr>

  autocmd FileType markdown onoremap ik :<c-u>execute "normal! ?^#\\+\r:nohlsearch\rwhv$bbe"<cr> 
  autocmd FileType markdown onoremap ak :<c-u>execute "normal! ?^#\\+\r:nohlsearch\rV"<cr>

  " Abbreviation to create headings
  autocmd FileType text iabbrev h1 #
  autocmd FileType text iabbrev h2 ##
  autocmd FileType text iabbrev h3 ###
  autocmd FileType text iabbrev h4 ####
  autocmd FileType text iabbrev h5 #####

  autocmd FileType markdown iabbrev h1 #
  autocmd FileType markdown iabbrev h2 ##
  autocmd FileType markdown iabbrev h3 ###
  autocmd FileType markdown iabbrev h4 ####
  autocmd FileType markdown iabbrev h5 #####
  
 " Create horizontal rule 
  autocmd FileType markdown iabbrev hr <cr>---<esc>
  
  "TODO highlight list items
  " autocmd FileType text nnoremap <leader>li <esc>I<li>
  " autocmd FileType markdown nnoremap <leader>li <esc>I<li>

  " Markdown surround for italics and bold (TODO - make this like grep plugin)
  autocmd FileType text vnoremap <leader>i <esc>a*<esc>Bi*<esc>lE
  autocmd FileType markdown vnoremap <leader>i <esc>a*<esc>Bi*<esc>lE
  autocmd FileType text vnoremap <leader>s <esc>a**<esc>Bi**<esc>lE
  autocmd FileType markdown vnoremap <leader>s <esc>a**<esc>Bi**<esc>lE

  autocmd FileType markdown set makeprg=pandoc\ -f\ markdown\ -t\ docx\ %\ -o\ %:h/$*

 " Reformat paragraph with space bar
  autocmd FileType markdown nnoremap <SPACE> gqap
  autocmd FileType text nnoremap <SPACE> gqap

 " Reformat document for export
  autocmd Filetype markdown nnoremap <leader>tw gggqG
  autocmd Filetype text nnoremap <leader>tw gggqG

augroup END
" }}}

" Vimwiki file settings --------------- {{{

augroup vimwiki_vim
" Initialize wikis

  let wiki_personal = {}
  let wiki_personal.path = '~/vimwiki/'
  let wiki_personal.syntax = 'markdown'
  let wiki_personal.ext = '.wiki' 

  let wiki_aleo = {}
  let wiki_aleo.path = '~/Desktop/Career/Aleo/'
  let wiki_aleo.syntax = 'markdown'
  let wiki_aleo.ext = '.wiki' 

  let wiki_classnotes = {}
  let wiki_classnotes.path = '~/vimwiki/classnotes'
  let wiki_classnotes.syntax = 'markdown'
  let wiki_classnotes.ext = '.wiki'

  let wiki_p11 = {}
  let wiki_p11.path = '~/vimwiki/p11'
  let wiki_p11.syntax = 'markdown'
  let wiki_p11.ext = '.wiki'

  let g:vimwiki_list = [wiki_personal, wiki_aleo, wiki_classnotes, wiki_p11]

  " Don't force all .md files to be vimwiki
  let g:vimwiki_global_ext = 0 

  " Keep custom header motions from markdown/text section
  autocmd FileType vimwiki onoremap ik :<c-u>execute "normal! ?^#\\+\r:nohlsearch\rwhv$bbe"<cr> 
  autocmd FileType vimwiki onoremap ak :<c-u>execute "normal! ?^#\\+\r:nohlsearch\rV"<cr>

  " Abbreviation to create headings
  autocmd FileType vimwiki iabbrev h1 #
  autocmd FileType vimwiki iabbrev h2 ##
  autocmd FileType vimwiki iabbrev h3 ###
  autocmd FileType vimwiki iabbrev h4 ####
  autocmd FileType vimwiki iabbrev h5 #####

  autocmd FileType vimwiki iabbrev h1 #
  autocmd FileType vimwiki iabbrev h2 ##
  autocmd FileType vimwiki iabbrev h3 ###
  autocmd FileType vimwiki iabbrev h4 ####
  autocmd FileType vimwiki iabbrev h5 #####
  
 " Reformat paragraph with space bar
  autocmd FileType vimwiki nnoremap <SPACE> gqap
  
 " Reformat for export
  autocmd Filetype text nnoremap <leader>tw gggqG
  
 " Create horizontal rule 
  autocmd FileType vimwiki iabbrev hr <cr>---
  
  autocmd FileType vimwiki set makeprg=pandoc\ -f\ markdown\ -t\ docx\ %\ -o\ %:h/$*

" Initial formatting when creating or opening a .wiki file
  autocmd BufNewFile,BufRead *.wiki setlocal nonumber spell
  
 " Automatically write the buffer every 60 seconds
  autocmd BufWritePre * :wa
  autocmd CursorHold * call feedkeys("\<C-\>\<C-n>")
  set updatetime=60000 

augroup END
" }}}

" Vimscript file settings --------------- {{{
augroup filetype_vim
  autocmd!
" Set folding for Vimscript files
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}"

" work-specific -------------- {{{

" Aleo
autocmd BufNewFile  *_update.wiki 0r ~/Desktop/Career/Aleo/update_template.md
autocmd BufNewFile  *_jd.md 0r ~/Desktop/Career/Aleo/Recruiting/jd_template.md
autocmd BufNewFile  *_prd.md 0r ~/Desktop/Career/Aleo/Product/prd_template.md
autocmd BufNewFile  *_interview.wiki 0r ~/Desktop/Career/Aleo/Recruiting/interview_template.md
autocmd BufNewFile  *_leader_weekly.wiki 0r ~/Desktop/Career/Aleo/leader_weekly.md
autocmd BufNewFile  *_call_notes.wiki 0r ~/Desktop/Career/Aleo/call_notes.md

" P11
autocmd BufNewFile  *_init.wiki 0r ~/Desktop/Career/P11/initial_counseling_template.md

iabbrev update_item ### Item ###<cr>* **Summary**: <cr><bs>* **Next Steps**: <cr><bs>* **Recommendation**: 

" }}}
