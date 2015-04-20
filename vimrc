" Don't be compatible with vi
set nocompatible
filetype off                  " required



" this is a test
" 
" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plugin 'gmarik/Vundle.vim'
"Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"Plugin 'bling/vim-airline'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
"call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""" AIRLINE
let g:airline#extensions#tabline#enabled = 1


" Call pathagen
" call pathogen#helptags()
" call pathogen#incubate()

execute pathogen#infect()

" Enable a nice big viminfo file
set viminfo='1000,f1,:1000,/1000
set history=500

" Make backspace delete lots of things
set backspace=indent,eol,start

" Create backups
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Show us the command we're typing
set showcmd

" Highlight matching parens
set showmatch

" Search options: incremental search, highlight search
set hlsearch
set incsearch
set ignorecase " searches are case-insensitive
set smartcase  " unless we type an upper-case character

" Show full tags when doing search completion
set showfulltag

" Speed up macros
set lazyredraw

" No annoying error noises
set noerrorbells

" Try to show at least three lines and two columns of context when
" scrolling
set scrolloff=3
set sidescrolloff=2

" Wrap on these
set whichwrap+=<,>,[,]

" Use the cool tab complete menu
set wildmenu
set wildignore+=*.o,*~,.lo
set suffixes+=.in,.a

" Allow edit buffers to be hidden
set hidden

" 1 height windows
set winminheight=1

" Enable syntax highlighting
if has("syntax")
    syntax on
endif

" enable virtual edit in vblock mode, and one past the end
set virtualedit=block,onemore
set background=dark
":colorscheme zenburn

" No icky toolbar, menu or scrollbars in the GUI
"if has('gui')
"    set guioptions-=m
"    set guioptions-=T
"    set guioptions-=l
"    set guioptions-=L
"    set guioptions-=r
"    set guioptions-=R
"end

" Do clever indent things. Don't make a # force column zero.
set autoindent
set smartindent
inoremap # X<BS>#

" Enable folds
if has("folding")
    set foldenable
    set foldmethod=indent
endif

" Syntax when printing
set popt+=syntax:y

" Enable filetype settings
if has("eval")
    filetype on
    filetype plugin on
    filetype indent on
endif

" Disable modelines, use securemodelines.vim instead
set nomodeline
let g:secure_modelines_verbose = 0
let g:secure_modelines_modelines = 15

" Nice statusbar
set laststatus=2
set statusline=
set statusline+=%2*%-3.3n%0*\                " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%1*%m%r%w%0*               " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding},                " encoding
set statusline+=%{&fileformat}]              " file format
if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
    set statusline+=\ %{VimBuddy()}          " vim buddy
endif
set statusline+=%=                           " right align
set statusline+=%2*0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" Nice window title
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f\                                              " file name
    set titlestring+=%h%m%r%w                                         " flags
    set titlestring+=\ -\ %{v:progname}                               " program name
    set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}  " working directory
endif

" If possible, try to use a narrow number column.
if v:version >= 700
    try
        setlocal numberwidth=3
    catch
    endtry
endif

" If possible and in gvim, use cursor row highlighting
if has("gui_running") && v:version >= 700
    set cursorline
end

" Include $HOME in cdpath
if has("file_in_path")
    let &cdpath=','.expand("$HOME").','.expand("$HOME").'/work'
endif

" Better include path handling
set fillchars=fold:-


if has("eval")

    " If we're in a wide window, enable line numbers.
    fun! <SID>WindowWidth()
        if winwidth(0) > 90
            setlocal foldcolumn=0
            setlocal number
        else
            setlocal nonumber
            setlocal foldcolumn=0
        endif
    endfun

    " Force active window to the top of the screen without losing its
    " size.
    fun! <SID>WindowToTop()
        let l:h=winheight(0)
        wincmd K
        execute "resize" l:h
    endfun

    " Update .*rc header
    fun! <SID>UpdateRcHeader()
        let l:c=col(".")
        let l:l=line(".")
        "silent 1,10s-\(Most recent update:\).*-\="Most recent update: ".strftime("%c")-e
        silent %s-\(Most recent update:\).*-\="Most recent update: ".strftime("%c")-e
        call cursor(l:l, l:c)
    endfun
endif


"-----------------------------------------------------------------------
" mappings
"-----------------------------------------------------------------------

" v_K is really really annoying
vmap K k

" Delete a buffer but keep layout
if has("eval")
    command! Kwbd enew|bw #
    nmap     <C-w>!   :Kwbd<CR>
endif

" Make <space> in normal mode go down a page rather than left a
" character
noremap <space> <C-f>

" Useful things from inside imode
inoremap <C-z>w <C-o>:w<CR>
inoremap <C-z>q <C-o>gq}<C-o>k<C-o>$

" Kill line
noremap <C-k> "_dd

" Select everything
noremap <Leader>gg ggVG

" Reformat everything
noremap <Leader>gq gggqG

" Reformat paragraph
noremap <Leader>gp gqap

" Clear lines
noremap <Leader>clr :s/^.*$//<CR>:nohls<CR>

" Delete blank lines
noremap <Leader>dbl :g/^$/d<CR>:nohls<CR>

" Enclose each selected line with markers
noremap <Leader>enc :<C-w>execute
            \ substitute(":'<,'>s/^.*/#&#/ \| :nohls", "#", input(">"), "g")<CR>


"-----------------------------------------------------------------------
" abbreviations
"-----------------------------------------------------------------------

"-----------------------------------------------------------------------
" special less.sh and man modes
"-----------------------------------------------------------------------

"-----------------------------------------------------------------------
" plugin / script / app settings
"-----------------------------------------------------------------------

"-----------------------------------------------------------------------
" final commands
"-----------------------------------------------------------------------


"----------------------------------------------------------------------
" comments
"----------------------------------------------------------------------
" single-line comments:
map <silent> ,# :s/^/#/<CR><Esc>:nohlsearch<CR>
map <silent> ,/ :s/^/\/\//<CR><Esc>:nohlsearch<CR>
map <silent> ,> :s/^/> /<CR><Esc>:nohlsearch<CR>
map <silent> ," :s/^/\"/<CR><Esc>:nohlsearch<CR>
map <silent> ,% :s/^/%/<CR><Esc>:nohlsearch<CR>
map <silent> ,! :s/^/!/<CR><Esc>:nohlsearch<CR>
map <silent> ,; :s/^/;/<CR><Esc>:nohlsearch<CR>
map <silent> ,- :s/^/--/<CR><Esc>:nohlsearch<CR>
map <silent> ,d :s/^/dnl /<CR><Esc>:nohlsearch<CR>
map <silent> ,. :s/^/.\\" /<CR><Esc>:nohlsearch<CR>
" uncomment
map <silent> ,c :s:\(^\s*\)\(//\\|--\\|> \\|[#"%!;]\\|dnl \):\1:e<CR><Esc>:nohlsearch<CR>

" multi-line comments:
map <silent> ,* :s/^\(.*\)$/\/\* \1 \*\//<CR><Esc>:nohlsearch<CR>
map <silent> ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR><Esc>:nohlsearch<CR>
map <silent> ,< :s/^\(.*\)$/<!-- \1 -->/<CR><Esc>:nohlsearch<CR>
" uncomment
map <silent> ,u :s:\(^\s*\)\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$:\1\3:e<CR><Esc>:nohlsearch<CR>



"-----------------------------------------------------------------------
" Spell
"-----------------------------------------------------------------------
map <F6> <Esc>:setlocal spell spelllang=en<CR>
map <F7> <Esc>:setlocal spell spelllang=fr<CR>
map <F8> <Esc>z=
map <F9> <Esc>:setlocal nospell<CR>

"-----------------------------------------------------------------------
" tab and buffer navigation
"-----------------------------------------------------------------------
map <silent>  ! gT
:nnoremap $ :bnext<CR>

"-----------------------------------------------------------------------
" Clear search
"-----------------------------------------------------------------------
map <silent> 0 :let @/=""<CR>


"-----------------------------------------------------------------------
" Move between visible lines and not between real lines
"-----------------------------------------------------------------------
map <silent> <Up> gk
map <silent> <Down> gj
map <silent> <home> g<home>
map <silent> <end> g<end>
:imap <silent> <Up> <C-o>gk
:imap <silent> <Down> <C-o>gj
:imap <silent> <home> <C-o>g<home>
:imap <silent> <end> <C-o>g<end>

"-----------------------------------------------------------------------
" tabulation
"-----------------------------------------------------------------------

set tabstop=4
set shiftwidth=4
set softtabstop=4
set listchars=tab:>-,trail:~,extends:>,precedes:<
set list
set expandtab





"-----------------------------------------------------------------------
" Simple tricks
"-----------------------------------------------------------------------
" display as many lines as possible
set display=lastline

" coorectly paste tabulation
:set pastetoggle=<F10>

" do not cut text
set textwidth=0

" set number toogle
" map <F12> :set number!<Bar>set number?<CR>
"map <F11> :set tw=72
"map <F12> :set fo+t



"-----------------------------------------------------------------------
" Graphic undo
"-----------------------------------------------------------------------
nnoremap 9 :GundoToggle<CR>
nnoremap 8 :NERDTreeToggle<CR>
nnoremap 7 :GitGutterLineHighlightsToggle<CR>
nnoremap 6 :Thumbnail<CR>
nnoremap 5 :Scratch<CR>

"-----------------------------------------------------------------------
" Reindent file
"-----------------------------------------------------------------------
"map <silent> = gg=G<CR>
"
"
"-----------------------------------------------------------------------
" UTF-8
"-----------------------------------------------------------------------
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

"----------------------------------------------------------------------
" fonts
" ---------------------------------------------------------------------
set guifont=ProggyCleanTT\ 12


"if &term =~ "xterm\\|rxvt-unicode-256color"
"  " use an orange cursor in insert mode
"  let &t_SI = "\<Esc>]12;orange\x7"
"  " use a red cursor otherwise
"  let &t_EI = "\<Esc>]12;red\x7"
"  silent !echo -ne "\033]12;red\007"
"  " reset cursor when vim exits
"  autocmd VimLeave * silent !echo -ne "\033]112\007"
"  " use \003]12;gray\007 for gnome-terminal
"endif


"echo -e "\033[4 q"
"echo -e "\033[? 25 t"

"CSI 1 Sp q  == blinking block
"CSI 2 Sp q  == solid block
"CSI 3 Sp q  == blinking underbar
"CSI 4 Sp q  == solid underbar

if &term =~ "xterm\\|rxvt-unicode-256color"
  " solid underscore
  let &t_SI .= "\<Esc>[3 q" 
  let &t_SI .= "\<Esc>]12;orange\x7"
  " solid block
  let &t_EI .= "\<Esc>[1 q"
  let &t_EI .= "\<Esc>]12;green\x7"
endif
set t_Co=256

" ---- MUTT ---- "
au BufRead /tmp/mutt-* set tw=72
au BufRead /tmp/mutt-* setlocal fo+=aw

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
set laststatus=2


" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar


