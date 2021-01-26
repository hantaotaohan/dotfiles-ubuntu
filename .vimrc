" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

if exists('$TMUX')
  set termguicolors
  set term=xterm-256color
endif

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"----------------------------------------------------------------------
" 防止tmux下vim的背景色显示异常
"----------------------------------------------------------------------
if &term =~ '256color' && $TMUX != ''
	" disable Background Color Erase (BCE) so that color schemes
	" render properly when inside 256-color tmux and GNU screen.
	" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
	set t_ut=
endif

"----------------------------------------------------------------------
" 有 tmux 何没有的功能键超时（毫秒）
"----------------------------------------------------------------------
"if $TMUX != ''
"	set ttimeoutlen=30
"elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
"	set ttimeoutlen=80
"endif


"-----------------------------------------------------------------o--------------------------------------------------------------o
"
"                                                                GUI
"
"-----------------------------------------------------------------o--------------------------------------------------------------o

if has("gui_running")
set guioptions=M                                                         " 去除VIN得GUI版本中得菜单栏
set guioptions=T                                                         " 去除VIN得GUI版本中得工具栏
set guioptions-=m
set guioptions-=T
nnoremap <silent> <S-F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>
endif

"-----------------------------------------------------------------o--------------------------------------------------------------o
"                                                                                                                                
"                                                              General                                                          
"                                                                                                                                
"-----------------------------------------------------------------o--------------------------------------------------------------o

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Vim Compatible
" ----------------------------------------------------------------o--------------------------------------------------------------o
if &compatible
	set nocompatible
endif

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Auto breakindent
" ----------------------------------------------------------------o--------------------------------------------------------------o
if exists('&breakindent')
	set breakindentopt=shift:4,min:20
endif

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Clipborad Settings
" ----------------------------------------------------------------o--------------------------------------------------------------o
if has('clipboard') && has('vim_starting') && has('unnamedplus')
	set clipboard& clipboard^=unnamed,unnamedplus
	xnoremap <silent> p p:let @+=@0<CR>:let @"=@0<CR>
endif

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Abbreviation = Alias
" ----------------------------------------------------------------o--------------------------------------------------------------o
"abbreviate 所有模式
"iabbrev    插入模式
"cabbrev    命令行模式
cabbrev tab Tabularize

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Leader & LocalLeader Settings
" ----------------------------------------------------------------o--------------------------------------------------------------o
let mapleader="\\"
let maplocalleader = ";"

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Q > nop
" ----------------------------------------------------------------o--------------------------------------------------------------o
nnoremap q <nop>
vnoremap q <nop>

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Keep search pattern at the center of the screen.
" ----------------------------------------------------------------o--------------------------------------------------------------o
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

nnoremap <silent> { {zz
nnoremap <silent> } }zz

nnoremap <silent> ( (zz
nnoremap <silent> ) )zz

nnoremap <silent> [[ [[zz
nnoremap <silent> ]] ]]zz

nnoremap <silent> <C-u> <C-u>zz
nnoremap <silent> <C-d> <C-d>zz

nnoremap <silent> <C-b> <C-b>zz
nnoremap <silent> <C-f> <C-f>zz

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Clear highlighted search
" ----------------------------------------------------------------o--------------------------------------------------------------o
nnoremap <silent> <ESC><ESC> :nohlsearch<Return>

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Yank
" ----------------------------------------------------------------o--------------------------------------------------------------o
nnoremap Y y$

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Go to home and end using capitalized directions
" ----------------------------------------------------------------o--------------------------------------------------------------o
nnoremap <C-a> ^
nnoremap <C-e> $

" ----------------------------------------------------------------o--------------------------------------------------------------o
" SuperF/f-T/t
" ----------------------------------------------------------------o--------------------------------------------------------------o
nnoremap <CR> ;
nnoremap <BS> ,

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Mapping %
" ----------------------------------------------------------------o--------------------------------------------------------------o
nnoremap <Space> %

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Scroll step sideways
" ----------------------------------------------------------------o--------------------------------------------------------------o
nnoremap zl z4l
nnoremap zh z4h

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Yank buffer's relative/absolute path to clipboard
" ----------------------------------------------------------------o--------------------------------------------------------------o
nnoremap <Leader>Y :let @+=
            \expand("%:~:.")<CR>:echo 'Yanked relative path'<CR>
nnoremap <Leader>y :let @+=
            \expand("%:p")<CR>:echo 'Yanked absolute path'<CR>

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Re-select blocks after indenting in visual/select mode
" ----------------------------------------------------------------o--------------------------------------------------------------o
xnoremap << <gv
xnoremap >> >gv|

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Jumps
" ----------------------------------------------------------------o--------------------------------------------------------------o
nnoremap g; g;zz
nnoremap g, g,zz

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Allow misspellings
" ----------------------------------------------------------------o--------------------------------------------------------------o
cnoreabbrev qw wq
cnoreabbrev qq wq
cnoreabbrev wQ wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Qa qa
cnoreabbrev q1 q!

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Auto Read Filechanges
" ----------------------------------------------------------------o--------------------------------------------------------------o
augroup AutoRead
    autocmd!
    autocmd CursorHold * silent! checktime
augroup END

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Timeing
" ----------------------------------------------------------------o--------------------------------------------------------------o
set timeout ttimeout
set timeoutlen=500   " 映射超时
set ttimeoutlen=10   " 按键密码超时
set updatetime=400   " 空闲时间以写入交换并触发CursorHold
set redrawtime=2000  " 停止显示重绘的时间（以毫秒为单位）

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Wildmenu 
" ----------------------------------------------------------------o--------------------------------------------------------------o
if has('wildmenu')
    if ! has('nvim')
    	set nowildmenu
        set wildmode=list:longest,full
    endif
    set wildignorecase
    set wildignore+=
        \.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
    set wildignore+=
        \*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
    set wildignore+=
        \**/node_modules/**,**/bower_modules/**,*/.sass-cache/*
    set wildignore+=
        \__pycache__,*.egg-info,.pytest_cache,.mypy_cache/**
    set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class
    set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib 
    set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
    set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz 
    set wildignore+=*DS_Store*,*.ipch
    set wildignore+=*.gem
    set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
    set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
    set wildignore+=*/.nx/**,*.app,*.git,.git
    set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
    set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
    set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
    set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
    set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
    set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
    set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
    set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android
endif

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Vim Directories
" ----------------------------------------------------------------o--------------------------------------------------------------o
let $DATA_PATH = 
    \ expand(($XDG_CACHE_HOME ? $XDG_CACHE_HOME : '~').'/.vim')
    
set directory=$DATA_PATH/swap//,$DATA_PATH,~/tmp,/var/tmp,/tmp
set undodir=$DATA_PATH/undo//,$DATA_PATH,~/tmp,/var/tmp,/tmp
set backupdir=$DATA_PATH/backup/,$DATA_PATH,~/tmp,/var/tmp,/tmp
set viewdir=$DATA_PATH/view/
set viewoptions=folds,cursor,curdir,slash,unix

" ----------------------------------------------------------------o--------------------------------------------------------------o
" History saving
" ----------------------------------------------------------------o--------------------------------------------------------------o
set history=2000

if has('nvim') && ! has('win32') && ! has('win64')
    set shada=!,'100,<20,@100,s10,h,r/tmp,r/private/var
else
    set viminfo='100,<20,@50,h,n$DATA_PATH/viminfo
endif

augroup user_persistent_undo
    autocmd!
    au BufWritePre /tmp/*          setlocal noundofile
    au BufWritePre COMMIT_EDITMSG  setlocal noundofile
    au BufWritePre MERGE_MSG       setlocal noundofile
    au BufWritePre *.tmp           setlocal noundofile
    au BufWritePre *.bak           setlocal noundofile
augroup END
" ----------------------------------------------------------------o--------------------------------------------------------------o
" If sudo, disable vim swap/backup/undo/shada/viminfo writing
if $SUDO_USER !=# '' && $USER !=# $SUDO_USER
		\ && $HOME !=# expand('~'.$USER, 1)
		\ && $HOME ==# expand('~'.$SUDO_USER, 1)

	set noswapfile
	set nobackup
	set nowritebackup
	set noundofile
	if has('nvim')
		set shada="NONE"
	else
		set viminfo="NONE"
	endif
endif
" ----------------------------------------------------------------o--------------------------------------------------------------o
" Secure sensitive information, disable backup files in temp directories
if exists('&backupskip')
	set backupskip+=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*
	set backupskip+=.vault.vim
endif
" ----------------------------------------------------------------o--------------------------------------------------------------o
" Disable swap/undo/viminfo files in temp directories or shm
augroup user_secure
	autocmd!
	silent! autocmd BufNewFile,BufReadPre
		\ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim
		\ setlocal noswapfile noundofile
		\ | set nobackup nowritebackup
		\ | if has('nvim') | set shada= | else | set viminfo= | endif
augroup END

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Disable vim distribution plugins
" ----------------------------------------------------------------o--------------------------------------------------------------o
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_matchit = 1
let g:loaded_2html_plugin = 1
let g:loaded_logiPat = 1
let g:loaded_rrhelper = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1
let g:no_mail_maps = 1
" let g:loaded_matchparen = 1

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Quickly close the current window
" ----------------------------------------------------------------o--------------------------------------------------------------o
function! BufferClose()
	let buffer_id = '%'
	let winnr = winnr('$')
	let buffer_count_all = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
	let is_empty_buffer = (bufname(buffer_id) == '') && !getbufvar(buffer_id, '&modified')
	let is_qflist =  get(getqflist({'winid':0}), 'winid', 0)
	let is_loclist = get(getloclist(0, {'winid':0}), 'winid', 0)
	let is_filetype =  getbufvar(bufnr('$'), '&filetype')
	let is_filetype_cur =  getbufvar(bufnr('%'), '&filetype')
	let is_modified_all = len(filter(getbufinfo(), 'v:val.changed == 1'))

	if is_loclist > 1
		execute "lclose"
	elseif is_qflist > 1
		execute "cclose"
	elseif is_filetype == 'nerdtree' || is_loclist > 1 || is_qflist > 1
		execute "NERDTreeClose"
	elseif is_filetype == 'tagbar' || is_loclist > 1 || is_qflist > 1
		execute "TagbarClose"
	elseif winnr > 1 && is_filetype == 'help' && is_filetype_cur == 'vim'
		execute "close"
	elseif buffer_count_all >= 2 && is_modified_all >= 1
		execute "silent bm!" | redraw
		let file = expand('%:P')
		try
			if (confirm("将改变保存到 "  . file . '？' , "&Yes\n&No" , 2)==1) |redraw
				execute "w!"
				execute "silent bnext!"
				execute "bdelete#"
			else
				execute "silent bm!"
				execute "edit!"
			endif
		endtry
	elseif buffer_count_all >= 2 && is_modified_all == 0
		execute "bnext!"
		execute "bdelete#"
	elseif buffer_count_all == 1 && is_modified_all >= 1
		execute "confirm q"
	elseif buffer_count_all == 1 && is_modified_all == 0
		execute "q"
	endif
endfunction

nnoremap <silent><localleader>q :call BufferClose()<cr>
inoremap <silent><localleader>q <Esc>:call BufferClose()<cr>
vnoremap <silent><localleader>q <Esc>:call BufferClose()<cr>


"=================================================================================================================================
" function! BufferClose()
" 	" 寻找Lockquickfix窗口并关闭
" 	if get(getloclist(0, {'winid':0}), 'winid', 0)
" 		execute "lclose"
" 	" 寻找quickfix窗口并关闭
" 	elseif get(getqflist({'winid':0}), 'winid', 0)
" 		execute "cclose"
" 	" 当前buffer数量大于1的时候并当前buffer的类型为help的时候执行关闭
" 	elseif winnr('$') > 1 && getbufvar(bufnr('%'), '&filetype') == "help" 
" 		execute "q"
" 	" 当前buffer数量大于1的时候并当前buffer的类型为vim的时候执行关闭
" 	elseif winnr('$') > 1 && getbufvar(bufnr('%'), '&filetype') == "vim" 
" 		execute "close"
" 	" 循环查找所有buffer,如果buffer数量等于1并且处于已经修改状态的时候
" 	elseif len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1 && getbufvar(winbufnr('%'), '&mod') == 1
" 		execute "confirm q"
" 	" 循环查找所有buffer,如果buffer数量等于1并且处于未修改状态的时候
" 	elseif len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1 && getbufvar(winbufnr('%'), '&mod') == 0
" 		execute "q"
" 	" 循环查找所有buffer,如果buffer数量大于1并且处于已经修改状态的时候
" 	elseif len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1 && getbufvar(winbufnr('%'), '&mod') == 1
" 		execute "bnext"
" 		execute "confirm  bdelete#"
" 	" 循环查找所有buffer,如果buffer数量大于1并且处于未修改状态的时候
" 	elseif len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1 && getbufvar(winbufnr('%'), '&mod') == 0
" 		execute "bnext"
" 		execute "bdelete#"
" 	endif
" endfunction

" nnoremap <silent><localleader>q :call BufferClose()<cr>
" inoremap <silent><localleader>q <Esc>:call BufferClose()<cr>
" vnoremap <silent><localleader>q <Esc>:call BufferClose()<cr>


" ----------------------------------------------------------------o--------------------------------------------------------------o
" Quickly Save the current window
" ----------------------------------------------------------------o--------------------------------------------------------------o
function! MySave()
let cantSave = "redraw | echohl ErrorMsg | echo \"Can't save the file: \" . v:exception | return | echohl None"
let notSaved = "redraw | echohl ErrorMsg | echo 'This buffer was NOT saved!' | return | echohl None"
try
silent w
catch /:E45:\|:E505:\|:E212:/
if (confirm("This Buffer is read only! Wanna save it anyway?", "&Yes\n&No", 2)==1) | redraw
redraw
try
silent w!
catch /:E212:/
if (confirm("Can't open the file, do you want to save it as Root?", "&Yes\n&No", 2)==1) | redraw
redraw
try
" w !sudo tee % > /dev/null
execute 'silent! write !sudo tee % >/dev/null' 
edit!
catch
exe cantSave
endtry
else
exe notSaved
endif
catch
exe cantSave
endtry
else
exe notSaved
endif
catch
exe cantSave
endtry
let time = strftime("%T")
let file = expand('%:P')
let permissions = getfperm(file)
redraw
echom '"' . file . '"' . " Save Done" . ' ' . time
redraw
echohl None
redraw
endfunction

nnoremap <silent><localleader>w :call MySave()<CR>
vnoremap <silent><localleader>w <ESC>:call MySave()<CR>
inoremap <silent><localleader>w <ESC>:call MySave()<CR>

" ----------------------------------------------------------------o--------------------------------------------------------------o
" Simple zoom toggle
" ----------------------------------------------------------------o--------------------------------------------------------------o
nnoremap <silent><LocalLeader>z  :<C-u>call <SID>zoom()<CR>
function! s:zoom()
	if exists('t:zoomed')
		unlet t:zoomed
		wincmd =
	else
		let t:zoomed = { 'nr': bufnr('%') }
		vertical resize
		resize
		normal! ze
	endif
endfunction

" ----------------------------------------------------------------o--------------------------------------------------------------o
" FileType Settings
" ----------------------------------------------------------------o--------------------------------------------------------------o
autocmd FileType qf setlocal nonumber

"-----------------------------------------------------------------o--------------------------------------------------------------o
"                                                                                                                                
"                                                              基础设置                                                          
"                                                                                                                                
"-----------------------------------------------------------------o--------------------------------------------------------------o

"=================================================================================================================================
" Vim-Plug-AutoSync 
"=================================================================================================================================
au VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | qa!
            \| endif
	    
"=================================================================================================================================
" Vim-Plug-Config   
"=================================================================================================================================

let g:plug_url_format = 'https://hub.fastgit.org/%s.git'

call plug#begin('$HOME/.vim/plugged')
Plug 'joshdick/onedark.vim'                                              " 主题文件
Plug 'vim-airline/vim-airline'                                           " 状态栏
Plug 'tpope/vim-fugitive'                                                " git插件
Plug 'tpope/vim-commentary'                                              " 快速注释插件
Plug 'tpope/vim-surround'                                                " 成对更改删除括号等
Plug 'tpope/vim-rsi'                                                     " 更改编辑方式为Emac模式
Plug 'junegunn/fzf.vim'                                                  " 为vim安装fzf插件
Plug 'junegunn/fzf' , { 'dir': '~/.fzf', 'do': './install --all' }       " 为系统安装fzf工具
Plug 'junegunn/goyo.vim'                                                 " 专注模式
Plug 'junegunn/limelight.vim'                                            " 专注模式辅助
Plug 'scrooloose/nerdtree' , { 'on': 'NERDTreeToggle' }                  " 文件树插件
Plug 'godlygeek/tabular'                                                 " 文本对齐插件
Plug 'dhruvasagar/vim-table-mode'                                        " 表格模式
Plug 'majutsushi/tagbar' , { 'on': 'TagbarToggle' }                      " Tag浏览
Plug 'skywind3000/asyncrun.vim'                                          " 配合调测python插件
Plug 'christoomey/vim-tmux-navigator'                                    " 同步vim与tmux快捷键
Plug 'Yggdroot/indentLine' , { 'on': 'IndentLinesToggle'}                " 缩进线显示插件
Plug 'mhinz/vim-startify'                                                " 定制vim开始页面
Plug 'SirVer/ultisnips'                                                  " 代码片段管理器
Plug 'hantaotaohan/vim-snippets'                                         " 代码片段仓库
Plug 'iamcco/markdown-preview.nvim' , { 'do': 'cd app && yarn install' } " MarkdownPreview插件
Plug 'jszakmeister/markdown2ctags'                                       " Tags的Toc插件
Plug 'vim-scripts/fcitx.vim'                                             " 输入法自动切换Fcitx
Plug 'ferrine/md-img-paste.vim'                                          " Markdown截图自动粘贴
Plug 'vimwiki/vimwiki' , { 'branch': 'dev' }                             " Vimwiki插件
Plug 'michal-h21/vim-zettel'                                             " 配合vimwiki的功能插件
Plug 'liuchengxu/vim-which-key'                                          " Leader辅助
Plug 'arcticicestudio/nord-vim'                                          " Themes
Plug 'kshenoy/vim-signature'                                             " 书签插件
Plug 'yianwillis/vimcdoc'                                                " 中文帮助
Plug 'Yggdroot/LeaderF'                                                  " 模糊搜索
Plug 'voldikss/vim-floaterm'                                             " 终端插件
Plug 'hotoo/pangu.vim'                                                   " 中文排版
Plug 'chriskempson/base16-vim'                                           " Themes
Plug 'jiangmiao/auto-pairs'                                              " 成对添加括号等
"Plug 'rhysd/clever-f.vim'                                                " 增强搜索功能
"Plug 'neoclide/coc.nvim', {'branch': 'release'}                          " 补全插件
"Plug 'Lenovsky/nuake'                                                    " 快速启动命令行工具
"Plug 'ludovicchabant/vim-gutentags'                                      " Tags管理
"Plug 'MattesGroeger/vim-bookmarks'                                       " 书签插件
"Plug 'vim-airline/vim-airline-themes'                                    " 状态栏主题
"Plug 'Neur1n/neuims'                                                     " 输入法自动切换 
"Plug 'arecarn/vim-auto-autoread'                                         " 自动Autoread插件
"Plug 'brooth/far.vim'                                                    " 全局查找替换插件
"Plug 'junegunn/vim-easy-align'                                           " 自动对齐插件
"Plug 'mg979/vim-visual-multi'                                            " 多光标插件
"Plug 'morhetz/gruvbox'                                                   " Themes
"Plug 'rakr/vim-one'                                                      " Themes
"Plug 'tyrannicaltoucan/vim-deep-space'                                   " Themes
"Plug 'terryma/vim-multiple-cursors'                                      " 多光标插件
"Plug 'edkolev/tmuxline.vim'                                              " Vim同步tmux配色
"Plug 'scrooloose/nerdcommenter'                                          " 快速注释插件
call plug#end()


"=================================================================================================================================
" Display Config  
"=================================================================================================================================
if !empty(glob('$HOME/.vim/plugged/onedark.vim'))
colorscheme onedark                                                      " 终端配色方案
endif
set number                                                               " 显示行号
set laststatus=2                                                         " 启用状态栏信息
set cmdheight=1                                                          " 设置命令行的高度为2，默认为1
set cursorline                                                           " 突出显示当前行
set nowrap                                                               " 设置不自动换行
set showtabline=2                                                        " 永远显示标签页
set pumheight=15                                                         " 弹出窗口高度
set t_Co=256                                                             " 设置终端显示颜色
set scrolloff=5                                                          " 光标上下两侧最少保留的屏幕行数
set showcmd                                                              " 显示命令
set diffopt=filler,internal,algorithm:histogram,indent-heuristic         " 更新diff配置
set guifont=Saber\ Bold\ 10.5                                            " 设置GUI字体
let &showbreak='↳  '                                                     " 设置换行符号
"set clipboard=unnamed                                                   " 共享剪贴板
"syntax enable                                                           " 开启语法高亮
"set guifont=DejaVu\ Sans\ Mono\ 10                                      " 设置字体
"set termguicolors                                                       " 终端模式 自动转换256真色彩 
"set diffopt=filler,context:9999                                         " 禁止VIMDIFF折叠

hi Search                 term=standout ctermfg=235 ctermbg=204 guifg=#282C34 guibg=#E06C75   " 搜索高亮自定义
hi IncSearch              term=standout ctermfg=235 ctermbg=204 guifg=#282C34 guibg=#E06C75   " 搜索行高亮自定义
hi Folded                 term=standout ctermfg=0   ctermbg=5   guifg=#282c34 guibg=#ABB2BF   " 折叠提示颜色
hi QuickFixLine           term=standout ctermfg=235 ctermbg=180 guifg=#ABB2BF guibg=#282C34   " 快速栏颜色
hi SignColumn             term=standout ctermfg=2   ctermbg=2   guifg=#E06C75 guibg=#282C34   " 标签栏颜色
hi DiffDelete             term=standout ctermfg=235 ctermbg=204 guifg=#E06C75 guibg=#E06C75   " 差异删除颜色
hi CursorLineNr           term=standout ctermfg=145 ctermbg=236 guifg=#61AFEF guibg=#282C34   " 当前光标行序号栏颜色
" hi FoldColumn             term=standout ctermfg=0   ctermbg=5   guifg=#282c34 guibg=#ABB2BF   " 折叠提示颜色

"=================================================================================================================================
" Base Config 
"=================================================================================================================================
filetype on                                                              " 启用文件类型侦测
filetype plugin on                                                       " 针对不同的文件类型加载对应的插件
filetype plugin indent on                                                " 启用缩进
set fileencodings=utf-8,cp936,gb18030,big5,latin1                        " 探测即将打开的文件的字符编码
set fileencoding=utf-8                                                   " 打开文件的字符编码
set encoding=utf-8                                                       " Vim 内部使用的字符编码方式
set textwidth=80                                                         " 换行前文字宽度最大字符
set autoindent                                                           " 换行时候代码自动缩进
set softtabstop=-1                                                       " 自动与shiftwidth保持同步
set shiftround                                                           " 将缩进舍入为shiftwidth的倍数
set smartindent                                                          " 启用智能对齐方式
set noexpandtab                                                          " 不要将制表符扩展到空格
set tabstop=4                                                            " 设置Tab键的宽度，可以更改，如：宽度为2
set shiftwidth=4                                                         " 换行时自动缩进宽度，可更改（宽度同tabstop）
set smarttab                                                             " 指定按一次backspace就删除shiftwidth宽度
set helplang=cn                                                          " 双字宽
set showmatch                                                            " 匹配模式,括号匹配
set backspace=indent,eol,start                                           " 设置退格键的工作方式
set hlsearch                                                             " 高亮搜索的关键字
set pythondll=                                                           " python3.6支持
set writebackup                                                          " 保存文件前建立备份，保存成功后删除该备份
set nobackup                                                             " 设置无备份文件
set undofile                                                             " 开启撤销功能
set autoread                                                             " 当文件在外部被修改，自动更新该文件
set ignorecase                                                           " 搜索模式里忽略大小写
set smartcase                                                            " 如果搜索模式包含大写字符，不使用 'ignorecase' 选项
set autochdir                                                            " 自动切换目录 
set noswapfile                                                           " 设置无临时文件
set noshowmode                                                           " 任务栏不显示状态
set ambiwidth=single                                                     " 设置为双字宽显示默认值double
set incsearch                                                            " 查找输入时动态增量显示查找结果
set hidden                                                               " 针对buffer不保存即可切换
" set nocompatible                                                       " 去掉有关vi一致性模式
" set ttimeout                                                           " 打开功能键超时检测（终端下功能键为一串 ESC 开头的字符串）
" set ttimeoutlen=50                                                     " 功能键超时检测 50 毫秒
" set undodir=~/.vim/                                                    " 开启撤销功能的目录
" set backupdir=/etc/vim/.vim/                                           " 备份文件目录  
" set directory=/etc/vim/.vim/                                           " 交换文件目录  
" set vb t_vb=                                                           " 关闭提示音
" set expandtab                                                          " 将Tab键转换为空格
" set noincsearch                                                        " 在输入要搜索的文字时，取消实时匹配

"=================================================================================================================================
" Other Config 
"=================================================================================================================================
set matchtime=2                                                          " 显示括号匹配的时间
set display=lastline                                                     " 显示最后一行
set wildmenu                                                             " 允许下方显示目录
set lazyredraw                                                           " 延迟绘制（提升性能）
set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m                              " 错误格式
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<                      " 设置分隔符可视
set formatoptions+=B                                                     " 合并两行中文时，不在中间加空格
set ffs=unix,dos,mac                                                     " 文件换行符，默认使用 unix 换行符
set ruler                                                                " 显示光标位置
set ttyfast                                                              " 刷新更快
set ttyscroll=3                                                          " 鼠标滚轮速度
set tags=./.tags;,.tags                                                  " 设置Tags
" set wildmode=list:full                                                 " 长列表补全
set completeopt=menuone,menu,longest,preview                             " 自动补全
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

"=================================================================================================================================

" 打开文件时恢复上一次光标所在位置
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \    exe "normal! g`\"" |
    \ endif
    
"=================================================================================================================================

"----------------------------------------------------------------------
" 终端下允许 ALT
" 记得设置 ttimeout （见 init-basic.vim） 和 ttimeoutlen （上面）
"----------------------------------------------------------------------

" Fix meta-keys <M-A> ... <M-Z> which generate <Esc>a ... <Esc>z
" let s:alpha = 'a'
" while s:alpha <= 'z'
"   execute "set <M-" . toupper(s:alpha) . ">=\e" . s:alpha
"   execute "imap \e" . s:alpha . " <M-" . toupper(s:alpha) . ">"
"   let s:alpha = nr2char(1+char2nr(s:alpha))
" endwhile
" unlet s:alpha

"----------------------------------------------------------------------

if has('nvim') == 0 && has('gui_running') == 0
	function! s:metacode(key)
		exec "set <M-".a:key.">=\e".a:key
	endfunc
	for i in range(10)
		call s:metacode(nr2char(char2nr('0') + i))
	endfor
	for i in range(26)
		call s:metacode(nr2char(char2nr('a') + i))
		call s:metacode(nr2char(char2nr('A') + i))
	endfor
	for c in [',', '.', '/', ';', '{', '}']
		call s:metacode(c)
	endfor
	for c in ['?', ':', '-', '_', '+', '=', "'"]
		call s:metacode(c)
	endfor
endif


"----------------------------------------------------------------------
" 终端下功能键设置
"----------------------------------------------------------------------
function! s:key_escape(name, code)
	if has('nvim') == 0 && has('gui_running') == 0
		exec "set ".a:name."=\e".a:code
	endif
endfunc


"----------------------------------------------------------------------
" 功能键终端码矫正
"----------------------------------------------------------------------
call s:key_escape('<F1>', 'OP')
call s:key_escape('<F2>', 'OQ')
call s:key_escape('<F3>', 'OR')
call s:key_escape('<F4>', 'OS')
call s:key_escape('<S-F1>', '[1;2P')
call s:key_escape('<S-F2>', '[1;2Q')
call s:key_escape('<S-F3>', '[1;2R')
call s:key_escape('<S-F4>', '[1;2S')
call s:key_escape('<S-F5>', '[15;2~')
call s:key_escape('<S-F6>', '[17;2~')
call s:key_escape('<S-F7>', '[18;2~')
call s:key_escape('<S-F8>', '[19;2~')
call s:key_escape('<S-F9>', '[20;2~')
call s:key_escape('<S-F10>', '[21;2~')
call s:key_escape('<S-F11>', '[23;2~')
call s:key_escape('<S-F12>', '[24;2~')


"=================================================================================================================================
" 折叠设置 
"=================================================================================================================================
set foldmethod=manual                                                    " 启用手动折叠zf
" set viewdir=~/.vim/                                                      " view视图文件目录设定
" nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>         " 空格打开关闭折叠视图
" vnoremap <Space> zf                                                      " 空格打开关闭折叠视图
"---------------------------------------------------------------------------------------------------------------------------------
" augroup AutoSaveFolds
" autocmd!
" au BufWinLeave .* mkview                                                 " 关闭时自动保存折叠视图
" au BufWinEnter .* silent loadview                                        " 打开时自动读取折叠视图
" augroup END

au BufWinLeave *.* silent mkview                                            " 关闭时自动保存折叠视图
au BufWinEnter *.* silent loadview                                          " 打开时自动读取折叠视图

"=================================================================================================================================
" 跨终端粘贴 
"=================================================================================================================================
nnoremap <silent><localleader>y "+yy
vnoremap <silent><localleader>y "+yy

nnoremap <silent><localleader>p "+p
vnoremap <silent><localleader>p "+p
inoremap <silent><localleader>p <Esc>"+p


"-----------------------------------------------------------------o--------------------------------------------------------------o
"                                                                                                                                
"                                                            各类插件设置                                                       
"                                                                                                                                
"-----------------------------------------------------------------o--------------------------------------------------------------o


"=================================================================================================================================
" Airline
"=================================================================================================================================
if !empty(glob('$HOME/.vim/plugged/vim-airline'))
let g:airline_theme='onedark'                                            " 设置状态栏主题默认powerlineish
let g:airline#extensions#tabline#enabled= 1                              " 开启tabline
let g:airline#extensions#tabline#show_tabs = 0                           " 显示Tabls文字
let g:airline#extensions#tabline#buffer_nr_show = 0                      " tabline中buffer显示编号
let g:airline#extensions#tabline#fnamemod = ':t'                         " 只显示文件名称
let g:airline_powerline_fonts= 1                                         " 使用powerline打过补丁的字体
let g:airline#extensions#whitespace#enabled = 0                          " 取消计数
let g:airline#extensions#tabline#buf_label_first = 1                     " 在第一个位置显示缓冲区标签"
let g:airline#extensions#tabline#buffers_label = 'Buffers'               " airline右上角定制
let g:airline#extensions#tabline#tabs_label = 'Tabs'                     " Tabs定制
let g:airline#extensions#tabline#buffer_nr_format = '%s: '               " Buffer 格式
let g:airline#extensions#wordcount#enabled = 1                           " 开启字数统计
let g:airline#extensions#wordcount#filetypes = ['all']                   " 开启字数统计文件类型
let g:airline#extensions#wordcount#formatter#default#fmt = '%s words'    " 自定义字数统计格式
let g:airline_inactive_collapse=0                                        " 确定不活动的窗口是否应将左侧部分折叠到该缓冲区的文件名
let g:airline_inactive_alt_sep=0                                         " 对非活动窗口的状态行使用替代分隔符
let g:airline_highlighting_cache = 0                                     " 将更改缓存到突出显示组中，因此应更快。如果遇到缓慢的Vim，请将其设置为1
let g:airline_focuslost_inactive = 1                                     " 使用FocusLost自动命令禁用航空公
let g:airline_stl_path_style = 'short'                                   " 在状态栏显示短路经
let g:airline#extensions#fzf#enabled = 1                                 " 启用FZF集成
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'             " 配置快速修复缓冲区的标题文本
let g:airline#extensions#quickfix#location_text = 'Location'             " 配置位置列表缓冲区的标题文本
let g:airline#extensions#tabline#show_close_button = 1                   " 是否显示关闭按钮
let g:airline#extensions#tabline#close_symbol = 'X'                      " 关闭按钮的符号
let airline#extensions#tabline#disable_refresh = 0                       " 在| BufAdd |上启用Tabline缓冲区的刷新自动命令
let airline#extensions#tabline#middle_click_preserves_windows = 1        " 从缓冲区关闭时保留窗口
let g:airline#extensions#tabline#show_splits = 1                         " 启用/禁用显示每个选项卡的打开拆分（仅在打开选项卡时）
let g:airline#extensions#tabline#exclude_preview = 1                     " 在选项行中启用/禁用显示预览窗口缓冲区。
let g:airline_skip_empty_sections = 0
let g:airline_focuslost_inactive = 1
let g:airline#extensions#tabline#alt_sep = 0
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#tabnr_formatter = 'tabnr'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#buffer_idx_format = {
    \ '0': '0 ',
    \ '1': '1 ',
    \ '2': '2 ',
    \ '3': '3 ',
    \ '4': '4 ',
    \ '5': '5 ',
    \ '6': '6 ',
    \ '7': '7 ',
    \ '8': '8 ',
    \ '9': '9 '
    \}
" let g:airline_statusline_ontop = 1                                     " 在状态栏中显示状态行（第一行)
" let g:airline_disable_statusline = 1                                   " 禁用每个缓冲区

"定义要显示的名称集，而不是特定的文件类型
let g:airline_filetype_overrides = {
  \ 'coc-explorer':  [ 'CoC Explorer', '' ],
  \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
  \ 'fugitive': ['fugitive', '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'],
  \ 'gundo': [ 'Gundo', '' ],
  \ 'help':  [ 'Help', '%f' ],
  \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
  \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
  \ 'startify': [ 'startify', '' ],
  \ 'vim-plug': [ 'Plugins', '' ],
  \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
  \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
  \ 'vaffle' : [ 'Vaffle', '%{b:vaffle.dir}' ],
  \ }

"---------------------------------------------------------------------------------------------------------------------------------
" 自定义airline c x z 区域的各项功能
let g:airline_section_c = airline#section#create(['readonly','  ','%{getcwd()}/','file'])
let g:airline_section_x = " "
let g:airline_section_y = airline#section#create(['file'])
let g:airline_section_z = airline#section#create(['%3p%',' %%  ', '%l' , ':%3v'])
" let g:airline_section_z='%3p%% %#__accent_orange#%4l% :%3v'
" let g:airline_section_y = '%{strftime("%c")}'                          " 显示时间
" let g:airline_section_x = airline#section#create(['%{&filetype}'])
"---------------------------------------------------------------------------------------------------------------------------------
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = 'RO'
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty = ' ●'
endif


"=================================================================================================================================
" NERDTree 插件配置
"=================================================================================================================================
nnoremap <F8> :NERDTreeToggle<CR>                                         " F8开启关闭NERDTree
inoremap <F8> <Esc>:NERDTreeToggle<CR>                                    " F8开启关闭NERDTree
nnoremap <localleader>e :NERDTreeToggle<CR>                               " ;e开启关闭NERDTree
inoremap <localleader>e <Esc>:NERDTreeToggle<CR>                          " ;e开启关闭NERDTree
"---------------------------------------------------------------------------------------------------------------------------------
let NERDTreeShowBookmarks=1                                              " 显示书签
let NERDTreeChDirMode=2                                                  " 是否改变PWD目录路径
let NERDTreeQuitOnOpen=0                                                 " 打开后是否关闭NT窗口
let NERDTreeMinimalUI=1                                                  " 不显示帮助面板
let NERDTreeWinSize=35                                                   " 窗口宽度
let g:NERDTreeHidden=0                                                   " 是否显示隐藏文件
let NERDTreeIgnore=['\.pyc','\~$','\.swp','_gsdata_']                    " 过滤所有指定的文件和文件夹
let g:NERDTreeShowLineNumbers=1                                          " 是否显示行号
let g:NERDTreeDirArrowExpandable = '▸'                                   " 设置树的显示图标
let g:NERDTreeDirArrowCollapsible = '▾'                                  " 设置树的显示图标
" let NERDTreeSortOrder=[1]                                              " 排序设置0 or 1
"autocmd vimenter * NERDTree                                             " 自动开启Nerdtree
"---------------------------------------------------------------------------------------------------------------------------------
"当NERDTree为剩下的唯一窗口时自动关闭
"---------------------------------------------------------------------------------------------------------------------------------
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"=================================================================================================================================
" MarkdownPreview插件配置
"=================================================================================================================================
" 设置为 1 可以在打开 markdown 文件的时候自动打开浏览器预览，只在打开  markdown 文件的时候打开一次
" default: 0
let g:mkdp_auto_start = 0

" 在切换 buffer 的时候自动关闭预览窗口，设置为 0 则在切换 buffer 的时候不  自动关闭预览窗口
" default: 1
let g:mkdp_auto_close = 1

" 设置为 1 则只有在保存文件，或退出插入模式的时候更新预览，默认为 0，实时  更新预览
" default: 0
let g:mkdp_refresh_slow = 0

" 设置为 1 则所有文件都可以使用 MarkdownPreview 进行预览，默认只有 markdown  文件可以使用改命令
" default: 0
let g:mkdp_command_for_global = 1

" 设置为 1, 在使用的网络中的其他计算机也能访问预览页面  默认只监听本地（127.0.0.1），其他计算机不能访问
" default: 0
let g:mkdp_open_to_the_world = 1

" 使用自定义IP打开预览页面在远程vim中工作并在本地浏览器上预览时很有用
" default empty
let g:mkdp_open_ip = ''

" 指定浏览器以打开预览页面
" default: ''
let g:mkdp_browser = ''

" 设置为1时，打开预览页时在命令行中回显预览页网址
" default is 0
let g:mkdp_echo_preview_url = 1

" 自定义vim函数名称以打开预览页面 此函数将接收url作为参数
" default is empty
let g:mkdp_browserfunc = ''

" 渲染的选项
" mkit：markdown-it渲染选项
" katex：数学的katex选项
" uml：markdown-it-plantuml选项
" maid：美人鱼的选择
" disable_sync_scroll：如果禁用同步滚动，则默认为0
" sync_scroll_type：
"       middle：表示光标位置始终显示在预览页面的中间
"       top：表示总是在预览页面顶部显示的vim top视口
"       relative：表示光标位置始终显示在预览页面的相对位置
" hide_yaml_meta：如果隐藏yaml元数据，则默认为1
" sequence_diagrams：js-sequence-diagrams选项
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {}
    \ }

" 设置markdowncss和highdark paht
let g:mdpath='/home/saber/dotfiles/setup/vim_preview_markdown/onedark/'

" use a custom markdown style must be absolute path
let g:mkdp_markdown_css = g:mdpath . 'onedark.css'

" use a custom highlight style must absolute path
let g:mkdp_highlight_css = g:mdpath . 'highdark.css'

" 使用自定义端口启动服务器，或使用随机端口将其清空
let g:mkdp_port = '8888'

" “预览页面标题 ${name} 将被替换为文件名
let g:mkdp_page_title = '「${name}」'

" MarkdownPreviewToggle
nmap <Leader>e <Plug>MarkdownPreviewToggle

"=================================================================================================================================
" Vim-table-mode 插件配置
"=================================================================================================================================
" 快速制作表格
" <Leader> = \
" <Leader>tm  table mode 开关
" <Leader>tdd 删除一行
" <Leader>tdc 删除一列
" <Leader>tt 使用定义的分隔符插入表格
" <Leader>T 使用用户输入的分隔符插入表格
" <Leader>tr 重新对齐
" <Leader>|| 插入表头边框
" let g:table_mode_border=0
" let g:table_mode_fillchar=' '
" let g:table_mode_delimiter = ' '                                       " 定义分隔符插入表格
let g:table_mode_corner = '|'


"=================================================================================================================================
" Tagbar   
"=================================================================================================================================
nnoremap <F9> :TagbarToggle<CR>                                           " F9打开关闭Tagbar
inoremap <F9> <Esc>:TagbarToggle<CR>                                      " F9打开关闭Tagbar
nnoremap <localleader>t :TagbarToggle<CR>                                 " ;t打开关闭Tagbar
inoremap <localleader>t <Esc>:TagbarToggle<CR>                            " ;t打开关闭Tagbar
let g:tagbar_autofocus = 1                                                " 焦点自动聚焦到Tagbar
let g:tagbar_autoclose = 0
let g:tagbar_autopreview = 0
let g:tagbar_no_autocmds = 1
let g:tagbar_jump_lazy_scroll = 1
let g:tagbar_sort = 0
let g:tagbar_case_insensitive = 1
let g:tagbar_compact = 1
let g:tagbar_show_balloon = 0
let g:tagbar_show_data_type = 0
let g:tagbar_show_visibility = 1
let g:tagbar_expand = 1
let g:tagbar_autoshowtag = 2
let g:no_status_line = 1
let g:tagbar_silent = 1
let g:tagbar_scrolloff = 10
let g:tagbar_hide_nonpublic = 1
let g:tagbar_map_preview = '<SPACE>'
let g:tagbar_map_showproto = "d"


"=================================================================================================================================
" Markdown2-Ctags
"=================================================================================================================================
" 让Tagbar支持markdown格式的Tags
"---------------------------------------------------------------------------------------------------------------------------------
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '$HOME/.vim/plugged/markdown2ctags/markdown2ctags.py', 
    \ 'ctagsargs' : '-f - --sort=yes --sro=»',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '»',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

let g:tagbar_type_vimwiki = {
          \   'ctagstype':'vimwiki'
          \ , 'kinds':['h:header']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{'h':'header'}
          \ , 'sort':0
          \ , 'ctagsbin':'$HOME/.vim/vimwiki2ctags.py'
          \ , 'ctagsargs': 'markdown'
          \ }



"=================================================================================================================================
" FZF.vim 
"=================================================================================================================================
nnoremap <silent><Leader>ff :Files /<CR>
nnoremap <silent><Leader>fl :BLines<CR>
nnoremap <silent><Leader>fo :Colors<CR>
nnoremap <silent><Leader>ft :BTags<CR>
nnoremap <silent><Leader>fb :Buffers<CR>


"=================================================================================================================================
" asyncru
"=================================================================================================================================
nnoremap <F7> :call asyncrun#quickfix_toggle(6)<cr>
inoremap <F7> <esc> :call asyncrun#quickfix_toggle(6)<cr>


"=================================================================================================================================
" indentLine
"=================================================================================================================================
let g:indentLine_enabled = 0
let g:indentLine_defaultGroup = 'SpecialKey'
nnoremap <LocalLeader>l :IndentLinesToggle<CR>
inoremap <LocalLeader>l <esc> :IndentLinesToggle<CR>


"=================================================================================================================================
" vim-startify
"=================================================================================================================================
let g:startify_session_delete_buffers = 1
let g:startify_files_number = 20
let g:startify_change_to_dir = 1
let g:startify_enable_special = 1
let g:startify_change_cmd = 'lcd'

let g:startify_custom_header = [
		\'                                         ',
		\'                                         ',
		\'  _____                 _____            ',
		\' |_   _|_ _  ___       |_   _|_ _  ___   ',
		\'   | |/ _` |/ _ \        | |/ _` |/ _ \  ',
		\'   | | (_| | (_) |  _    | | (_| | (_) | ',
		\'   |_|\__,_|\___/  (_)   |_|\__,_|\___/  ',
		\'                                         ',
		\'                                         ',
		\ ]

let g:startify_list_order = [
    \ ['   Files:'],
    \ 'files',
    \ ['   Bookmarks:'],
    \ 'bookmarks',
    \ ]

" let g:startify_list_order = [
"     \ ['   Recent files in this directory:'],
"     \ 'dir',
"     \ ['   Recent files:'],
"     \ 'files',
"     \ ['   Bookmarks:'],
"     \ 'bookmarks',
"     \ ]

let g:startify_skiplist = [
    \ 'COMMIT_EDITMSG',
    \ ]

let g:startify_bookmarks = [
    \ { 'v': '$HOME/.vimrc' },
    \ { 'i': '$HOME/.config/i3/config' },
    \ { 'a': '$HOME/.config/alacritty/alacritty.yml' },
    \ { 'b': '$HOME/.config/i3blocks/config' },
    \ { 'p': '$HOME/.config/picom/picom.conf' },
    \ { 's': '$HOME/.bashrc' },
    \ ]

let g:startify_custom_footer = [
    \ '    +------------------------------+',
    \ '    |     Keep an open mind!       |',
    \ '    +----------------+-------------+',
    \]

nnoremap <silent><LocalLeader>s :Startify <CR>
inoremap <silent><LocalLeader>s <Esc>:Startify <CR>

"-----------------------------------------------------------------o--------------------------------------------------------------o
"                                                                                                                                
"                                                             快捷键设置                                                         
"                                                                                                                                
"-----------------------------------------------------------------o--------------------------------------------------------------o


"=================================================================================================================================
" Leader(\)+ 123....  切换Buffers快捷键设置
"=================================================================================================================================
nnoremap <LocalLeader>a          :badd<Space>
" nnoremap <LocalLeader>d          :bdelete<Space>
" nnoremap <silent><Leader>1     :b1<cr>
" nnoremap <silent><Leader>2     :b2<cr>
" nnoremap <silent><Leader>3     :b3<cr>
" nnoremap <silent><Leader>4     :b4<cr>
" nnoremap <silent><Leader>5     :b5<cr>
" nnoremap <silent><Leader>6     :b6<cr>
" nnoremap <silent><Leader>7     :b7<cr>
" nnoremap <silent><Leader>8     :b8<cr>
" nnoremap <silent><Leader>9     :b9<cr>
" nnoremap <silent><Leader>0     :b10<cr>
" nnoremap <silent><Leader><tab> :bnext<CR>
" inoremap <silent><Leader><tab> <ESC>:bnext<CR>

"=================================================================================================================================
" Leader(\)+ 123....  切换Tabs快捷键设置 
"=================================================================================================================================
" nnoremap <silent><LocalLeader>a     :tabnew<cr>
" nnoremap <silent><LocalLeader>d     :tabclose<cr>
" nnoremap <silent><LocalLeader>1     :tabn1<cr>
" nnoremap <silent><LocalLeader>2     :tabn2<cr>
" nnoremap <silent><LocalLeader>3     :tabn3<cr>
" nnoremap <silent><LocalLeader>4     :tabn4<cr>
" nnoremap <silent><LocalLeader>5     :tabn5<cr>
" nnoremap <silent><LocalLeader>6     :tabn6<cr>
" nnoremap <silent><LocalLeader>7     :tabn7<cr>
" nnoremap <silent><LocalLeader>8     :tabn8<cr>
" nnoremap <silent><LocalLeader>9     :tabn9<cr>
" nnoremap <silent><LocalLeader>0     :tabn10<cr>
" nnoremap <silent><LocalLeader><tab> :tabnext<CR>
" inoremap <silent><LocalLeader><tab> <ESC>:tabnext<CR>


"=================================================================================================================================
" Airline  切换Buffers/Tabs快捷键设置 
"=================================================================================================================================
nmap <silent><LocalLeader>1       <Plug>AirlineSelectTab1
nmap <silent><LocalLeader>2       <Plug>AirlineSelectTab2
nmap <silent><LocalLeader>3       <Plug>AirlineSelectTab3
nmap <silent><LocalLeader>4       <Plug>AirlineSelectTab4
nmap <silent><LocalLeader>5       <Plug>AirlineSelectTab5
nmap <silent><LocalLeader>6       <Plug>AirlineSelectTab6
nmap <silent><LocalLeader>7       <Plug>AirlineSelectTab7
nmap <silent><LocalLeader>8       <Plug>AirlineSelectTab8
nmap <silent><LocalLeader>9       <Plug>AirlineSelectTab9
nmap <silent><LocalLeader><tab>   <Plug>AirlineSelectNextTab
nmap <silent><LocalLeader><S-tab> <Plug>AirlineSelectPrevTab
imap <silent><Localleader><tab>   <Esc><Plug>AirlineSelectNextTab
imap <silent><Localleader><S-tab> <Esc><Plug>AirlineSelectNextTab


"================================================================================================================================= 
" Ctrl + n 切换buff快捷键 
"=================================================================================================================================
" nnoremap <c-e> :bp!<CR>
" inoremap <c-e> <esc> :bp!<CR>


"=================================================================================================================================
" Ctrl + h j k l 切换窗口快捷键设置  
"=================================================================================================================================
" 设置Alt快捷方式为 进入编辑模式后 ctrl+v 再按 alt+某键即可
"=================================================================================================================================
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
inoremap <C-h> <ESC><C-w>h
inoremap <C-l> <ESC><C-w>l
inoremap <C-j> <ESC><C-w>j
inoremap <C-k> <ESC><C-w>k
tnoremap <C-h> <C-w><C-h>
tnoremap <C-j> <C-w><C-j>
tnoremap <C-k> <C-w><C-k>
tnoremap <C-l> <C-w><C-l>


"================================================================================================================================= 
" 快速移动光标快捷键 
"=================================================================================================================================
" 编辑模式下:光标移动及删除
" inoremap <C-b> <Left>
" inoremap <C-f> <Right>
" inoremap <C-a> <Home>
" inoremap <C-e> <End>
" inoremap <C-w> <C-\><C-o>dB
" inoremap <M-d> <C-\><C-o>dw
" inoremap <M-b> <S-Left>
" inoremap <M-f> <S-Right>

" 普通模式下:Shift+HJKL快速移动
" nnoremap K <Esc>5<up>
" nnoremap J <Esc>5<down>
" nnoremap H <Esc>0
" nnoremap L <Esc>$

" 可视化模式下:Shift+HJKL快速移动
" vnoremap K 5<up>
" vnoremap J 5<down>
" vnoremap H 0
" vnoremap L $


"=================================================================================================================================
" Shift + - = , . 调整窗口高低宽窄快捷键 
"=================================================================================================================================
"nnoremap <silent><leader>j <C-W>:resize           +5<CR>
"nnoremap <silent><leader>k <C-W>:resize           -5<CR>
"nnoremap <silent><leader>h <C-W>:vertical resize  +5<CR>
"nnoremap <silent><leader>l <C-W>:vertical resize  -5<CR>


"=================================================================================================================================
" Ctrl + n 开关显示绝对/相对行号显示
" 设定相对行号和绝对行号显示问题 编辑模式=绝对行号 普通模式=相对行号 Ctrl+n 切换
" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
"=================================================================================================================================
"set relativenumber number
"au FocusLost * :set norelativenumber number
"au FocusGained * :set relativenumber
"" 插入模式下用绝对行号, 普通模式下用相对
"autocmd InsertEnter * :set norelativenumber number
"autocmd InsertLeave * :set relativenumber
"function! NumberToggle()
"if(&relativenumber == 1)
"set norelativenumber number
"else
"set relativenumber
"endif
"endfunc
"nnoremap <C-n> :call NumberToggle()<cr>


"=================================================================================================================================
"function! NumberToggle()
"if(&relativenumber == 1)
"set norelativenumber
"else
"set relativenumber
"endif
"endfunc
"nnoremap <C-n> :call NumberToggle()<cr>


"=================================================================================================================================
" F2 行号开关，用于鼠标复制代码用
" 为方便复制，用<F2>开启/关闭行号显示:
"=================================================================================================================================
function! HideNumber()
if(&relativenumber == &number)
set relativenumber! number!
elseif(&number)
set number!
else
set relativenumber!
endif
set number?
endfunc
nnoremap <F2> :call HideNumber()<CR>


"=================================================================================================================================
" F3 语法开关，关闭语法可以加快大文件的展示
"=================================================================================================================================
nnoremap <silent><F3>
    \ : if exists("syntax_on") <BAR>
    \    syntax off <BAR>
    \ else <BAR>
    \    syntax enable <BAR>
    \ endif<CR>


"=================================================================================================================================
" F4 粘贴模式开关
"=================================================================================================================================
set pastetoggle=<F4>                                                     " 设置粘贴模式 <F4>切换


"=================================================================================================================================
" Quit Term Alt+Q 
"=================================================================================================================================
"tnoremap <leader>q <c-\><c-n>


"================================================================================================================================= 
" 非root权限保存快捷命令 命令模式下输入:W
"=================================================================================================================================
" command W w !sudo tee % > /dev/null
" nnoremap <localleader>w :execute 'silent! write !sudo tee % >/dev/null' <bar> edit!<CR>


"-----------------------------------------------------------------o--------------------------------------------------------------o
"                                                                                                                                
"                                                              其他设置                                                          
"                                                                                                                                
"-----------------------------------------------------------------o--------------------------------------------------------------o


"=================================================================================================================================
" Python
"-----------------------------------------------------------------o--------------------------------------------------------------o
" F5 开启Quitfix 调测
" F6 开启Term    调测


"=================================================================================================================================
" 窗口位置参数可选 leftabove aboveleft rightbelow belowright topleft botright
" 分割位置参数 vert splitbelow
" autocmd BufRead *.py nmap <F5> :rightbelow vert term python3 "%"<CR>


"=================================================================================================================================
" autocmd BufRead *.py nmap <F5> :botright term exec "w" python3 "%"<CR>
" autocmd BufRead *.py nmap <F6> :make<CR>
" autocmd BufRead *.py :cclose


"=================================================================================================================================
" nnoremap <F5> :call CompileRunGcc1()<cr>
" func! CompileRunGcc1()
"     exec "w"
"     if &filetype == 'python'
"         if search("@profile")
"             exec "AsyncRun kernprof -l -v %"
"             exec "copen"
"             exec "wincmd p"
"         elseif search("set_trace()")
"             exec "!python3 %"
"         else
"             exec "AsyncRun -raw python3 %"
"             exec "copen"
"             exec "wincmd p"
"         endif
"     endif
" endfunc


"=================================================================================================================================
" map <F6> :call CompileRunGcc2()<CR>
" func! CompileRunGcc2()
"     exec "w"
"     if &filetype == 'python'
"         exec "!clear"
"         exec "!time python3 %"
"     elseif &filetype == 'sh'
"         :!time bash %
"     endif
" endfunc


"=================================================================================================================================
nnoremap <F5> :call CompileRunGcc1()<cr>
nnoremap <silent><localleader>r :call CompileRunGcc1()<cr>
inoremap <silent><localleader>r <esc>:call CompileRunGcc1()<cr>
vnoremap <silent><localleader>r <esc>:call CompileRunGcc1()<cr>
func! CompileRunGcc1()
    exec "w"
    if &filetype == 'python'
        exec "AsyncRun -mode=term -pos=bottom -rows=10 -focus=0 python3 %"
        exec "wincmd p"
    elseif &filetype == 'sh'
        exec "AsyncRun -mode=term -pos=bottom -rows=10 -focus=0 time bash %"
    elseif &filetype == 'java'
        execute 'AsyncRun -mode=term -pos=bottom -rows=10 -focus=0 -cwd=<root> javac "$(VIM_RELNAME)" ; java $(VIM_FILENOEXT)'
    elseif &filetype == 'javascript'
        exec "AsyncRun -mode=term -pos=bottom -rows=10 -focus=0 time node %"
    elseif &filetype == 'markdown'
        MarkdownPreview
    endif
endfunc


"=================================================================================================================================
" 自动切换目录为当前编辑文件所在目录
"=================================================================================================================================
" au BufRead,BufNewFile,BufEnter * cd %:p:h


"=================================================================================================================================
" 输入法自动切换
"=================================================================================================================================
" function! IMtoEng()
"     call system('/$HOME/.vim/plugged/neuims/bin/win_ims.exe 0x0409')
" endfunction

" function! IMtoCN()
"     call system('$HOME/.vim/plugged/neuims/bin/win_ims.exe 0x0804')
" endfunction

" autocmd InsertEnter * call IMtoCN()
" autocmd InsertLeave * call IMtoEng()


"=================================================================================================================================
" 输入法自动切换 - IM-SELECT.exe Config
"=================================================================================================================================
"function! IMtoEng()
"    call system('/$HOME/.vim/plugged/neuims/bin/im-select.exe 1033')
" endfunction
"
"function! IMtoCN()
"    call system('/$HOME/.vim/plugged/neuims/bin/im-select.exe 2052')
"endfunction
"
"autocmd InsertEnter * call IMtoCN()
"autocmd InsertLeave * call IMtoEng()   


"=================================================================================================================================
" Markdown截图自动粘贴设置
"=================================================================================================================================
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
" there are some defaults for image directory and image name, you can change them
" let g:mdip_imgdir = 'img'
" let g:mdip_imgname = 'image'


"=================================================================================================================================
" 
"
"
"
"                                                        
"      __     ___                   _ _    _ 
"      \ \   / (_)_ __ _____      _(_) | _(_)
"       \ \ / /| | '_ ` _ \ \ /\ / / | |/ / |
"        \ V / | | | | | | \ V  V /| |   <| |
"         \_/  |_|_| |_| |_|\_/\_/ |_|_|\_\_|
"                                            
"
"
"
"
"
"=================================================================================================================================

"=================================================================================================================================
" Vimwiki Zettel settings
"=================================================================================================================================
" let g:zettel_format = "%Y%m%d%H%M"
let g:zettel_format = "%title"
let g:zettel_link_format="[%title](%link)"
let g:zettel_options = [{"template":"$HOME/dotfiles/extras/zettelnew.tpl", "disable_front_matter": 1}]

"=================================================================================================================================
" Vimwiki settings
"=================================================================================================================================
autocmd FileType vimwiki nnoremap <leader>wv :VimwikiUISelect<CR>
autocmd FileType vimwiki nnoremap <leader>ws :call VWS()<CR>
autocmd FileType vimwiki nnoremap <leader>wf :execute "VWS /" . expand("<cword>") . "/" <Bar> :lopen<CR>
autocmd FileType vimwiki nnoremap <silent><localleader>p :call GitPush()<cr>

function! VWS()
    execute ":VimwikiSearch " . input("VimwikiSearch:")
    :lopen
endfunction

"-----------------------------------------------------------------o--------------------------------------------------------------o
let wiki_1 = {}
let wiki_1.name= '<Hugo   >'
let wiki_1.auto_export= 1
let wiki_1.auto_tags= 1
let wiki_1.auto_generate_tags= 1
let wiki_1.auto_generate_links= 1
let wiki_1.automatic_nested_syntaxes= 1
let wiki_1.path= '$HOME/blog/content/posts/'
let wiki_1.path_html= '$HOME/blog/public'
let wiki_1.syntax= 'markdown'
let wiki_1.ext= '.md'
let wiki_1.index = 'inbox'
let wiki_1.custom_wiki2html= '$HOME/dotfiles/extras/wiki2html.sh'
let wiki_1.nested_syntaxes= {'python': 'python','bash': 'sh'}
let wiki_1.html_filename_parameterization= 1
let wiki_1.vimwiki_auto_chdir= 1
"-----------------------------------------------------------------o--------------------------------------------------------------o
let wiki_2 = {}
let wiki_2.name= '<Vimwiki>'
let wiki_2.auto_export= 1
let wiki_2.auto_tags= 1
let wiki_2.auto_generate_tags= 0
let wiki_2.auto_generate_links= 0
let wiki_2.automatic_nested_syntaxes= 1
let wiki_2.path= '$HOME/vimwiki/src'
let wiki_2.path_html= '$HOME/vimwiki/docs/'
let wiki_2.template_path= '$HOME/vimwiki/templates/'
let wiki_2.template_default= 'default'
let wiki_2.template_ext= '.tpl'
let wiki_2.css_file= '$HOME/vimwiki/templates/style.css'
let wiki_2.syntax= 'markdown'
let wiki_2.ext= '.md'
let wiki_2.custom_wiki2html= 'vimwiki_markdown'
let wiki_2.nested_syntaxes= {'python': 'python','bash': 'sh'}
let wiki_2.html_filename_parameterization= 1
let wiki_1.vimwiki_auto_chdir= 1
"-----------------------------------------------------------------o--------------------------------------------------------------o
let g:vimwiki_list = [wiki_1, wiki_2]
"-----------------------------------------------------------------o--------------------------------------------------------------o
let g:vimwiki_CJK_length = 1
let g:vimwiki_hl_cb_checked = 2
let g:vimwiki_global_ext = 1 " make sure vimwiki doesn't own all .md files
let g:vimwiki_use_mouse = 1
let g:vimwiki_conceallevel=1
let g:vimwiki_markdown_link_ext = 0
let g:list_margin=0
let g:vimwiki_user_htmls = '404.html,search.html,books.html,todo,html,contact.html,tags.html,inbox.html'
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1,nav,body,aside'
let g:vimwiki_tag_format = {'pre': 'tags:.*', 'pre_mark': '\[', 'post_mark': '\]', 'sep': ','}
"-----------------------------------------------------------------o--------------------------------------------------------------o
" 自动插入YAML 并自动改写filename
autocmd BufEnter    ~/blog/content/posts/*.md :2d
autocmd BufEnter    ~/blog/content/posts/*.md :1r! echo title: %:t:r
autocmd BufNewFile ~/blog/content/posts/*.md :0r !echo ---
autocmd BufNewFile ~/blog/content/posts/*.md :r! echo title: %:t:r
autocmd BufNewFile ~/blog/content/posts/*.md :r! echo "date: `date +'\%Y-\%m-\%dT\%H:\%M:\%S+08:00'`"
autocmd BufNewFile ~/blog/content/posts/*.md :r! echo draft: false
autocmd BufNewFile ~/blog/content/posts/*.md :r! echo categories: []
autocmd BufNewFile ~/blog/content/posts/*.md :r! echo tags: []
autocmd BufNewFile ~/blog/content/posts/*.md :r! echo ---
autocmd BufNewFile ~/blog/content/posts/*.md :$r !echo   
"-----------------------------------------------------------------o--------------------------------------------------------------o
" 改变Shift+Enter映射
autocmd FileType vimwiki inoremap <silent><buffer> <localleader><CR> <Esc>:VimwikiReturn 2 2<CR>

"-----------------------------------------------------------------o--------------------------------------------------------------o
hi VimwikiHeader1 guifg=#e5c07b
hi VimwikiHeader2 guifg=#98c379
hi VimwikiHeader3 guifg=#c678dd
hi VimwikiHeader4 guifg=#8096BF
hi VimwikiHeader5 guifg=#8096BF
hi VimwikiHeader6 guifg=#8096BF
hi VimwikiH1Folding guifg=#e5c07b
hi VimwikiH2Folding guifg=#98c379
hi VimwikiH3Folding guifg=#c678dd
hi VimwikiH4Folding guifg=#8096BF
hi VimwikiH5Folding guifg=#8096BF
hi VimwikiH6Folding guifg=#8096BF
hi VimwikiLink guifg=#61afef
hi VimwikiLink guifg=#61afef
hi VimwikiBold term=reverse cterm=underline ctermfg=204 gui=underline guifg=#E06C75

"=================================================================================================================================
" 自动添加Backlinks
" autocmd BufWritePost ~/blog/content/posts/*.md if bufname() !='inbox.md' | call s:backlinks()
function! s:backlinks()
    let fw = search('Backlinks')
	let bf = bufname()
	if bf != "inbox.md" && fw == 0
		exec ":ZettelBackLinks"
    endif
endfunction
"-----------------------------------------------------------------o--------------------------------------------------------------o
" 方案三(异步) - 最终方案
func GitPull()
    " 获取云端最新版
    exec "w"
    exec ":cd %:h"
    .normal ^L
    exec ":AsyncStop"
    exec ":AsyncRun git pull origin master"
    autocmd User AsyncRunStop exec ":ccl"
    autocmd User AsyncRunStop exec ":e %"
    let g:asyncrun_exit = "echom 'Sync Done'"
endfunc

func GitCommit()
    " 提交到本地
    " call system("git add --all")
	" call system("git commit -m \"`whoami` @  `hostname` in `date +%Y-%m-%d=%H:%M:%S`\"")
	call s:backlinks()
	exec "w"
	exec ":AsyncRun git add --all"
	exec ":AsyncRun git add -m\"Update `whoami` at `hostname` in `date +%Y-%m-%d` `date +%H:%M:%S`\""
    let g:asyncrun_exit = "echom 'Git Add and Commit Done'"
endfunc

func GitPush()
    " 上传到云端
    call system("git add --all")
	call system("git commit -m \"Update `whoami` at `hostname` in `date +%Y-%m-%d` `date +%H:%M:%S`\"")
	exec ":AsyncRun -mode=hide git push origin master"
    exec ":AsyncStop"
    let g:asyncrun_exit = "echom 'Done'"
endfunc

autocmd BufReadPost $HOME/blog/content/posts/inbox.md call GitPull()
autocmd BufWritePost $HOME/blog/content/posts/*.md call GitCommit()
autocmd VimLeavePre inbox.md call GitPush() 

autocmd BufReadPost $HOME/vimwiki/src/index.md call GitPull()
autocmd BufWritePost $HOME/vimwiki/src/*.md call GitCommit()
autocmd VimLeavePre index.md call GitPush() 


"=================================================================================================================================
" 自定义airline同步通知颜色
function! AirlineThemePatch(palette)
  " [ guifg, guibg, ctermfg, ctermbg, opts ].
  " See "help attr-list" for valid values for the "opt" value.
  " http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
  let a:palette.accents.running = [ '#c678dd', '' , '', '', '' ]
  let a:palette.accents.success = [ '#61afef', '' , '', '', '' ]
  let a:palette.accents.failure = [ '#e06c75', '' , '', '', '' ]
endfunction
let g:airline_theme_patch_func = 'AirlineThemePatch'

" Change color of the relevant section according to g:asyncrun_status, a global variable exposed by AsyncRun
" 'running': default, 'success': green, 'failure': red
let g:asyncrun_status = ''
let g:async_status_old = ''
function! Get_asyncrun_running()
  let async_status = g:asyncrun_status
  if async_status != g:async_status_old
    if async_status == 'running'
      call airline#parts#define_accent('asyncrun_status', 'running')
    elseif async_status == 'success'
      call airline#parts#define_accent('asyncrun_status', 'success')
    elseif async_status == 'failure'
      call airline#parts#define_accent('asyncrun_status', 'failure')
    endif
    let g:airline_section_x = airline#section#create(['asyncrun_status'])
    AirlineRefresh
    let g:async_status_old = async_status
  endif
  return async_status
endfunction

try 
call airline#parts#define_function('asyncrun_status', 'Get_asyncrun_running')
let g:airline_section_x = airline#section#create(['asyncrun_status'])
catch
endtry

"=================================================================================================================================
" 使用wd删除markdown时自动删除相对应不使用的HTML文件
function! VimwikiDeleteClean()
  let htmlfile = expand('%:r') . '.html'
  lcd ${HOME}/vimwiki/docs/
  call delete(htmlfile)
  lcd %:p:h
  call vimwiki#base#delete_link()
endfunction
autocmd filetype vimwiki nnoremap <buffer> <leader>wd :call VimwikiDeleteClean()<CR>


""=================================================================================================================================
"" 
""
""
""
""
"" Vimwiki HUGO Settings
""
""
""
""
""
""
""=================================================================================================================================
""=================================================================================================================================
"" Vimwiki Zettel settings
""=================================================================================================================================
"let g:zettel_dir = "$HOME/blog/content/en/docs"
"let g:zettel_format = "%Y%m%d%H%M"
"let g:zettel_link_format="[%title](%link)"
"let g:zettel_disable_front_matter=1
"let g:zettel_options = [{},{"front_matter" :
"            \[["draft","false"]],
"            \"template" :  "$HOME/dotfiles/extras/zettelnew.tpl"}]

""=================================================================================================================================
"" Vimwiki settings
""=================================================================================================================================
"autocmd FileType vimwiki nmap <Leader>ws :VWS<Space>
"autocmd FileType vimwiki nmap <Plug>VimwikiUISelect <nop>
"autocmd FileType vimwiki nmap <silent><localleader>p :call GitPush()<cr>

"let g:vimwiki_list = [{
"        \ 'auto_export': 1,
"        \ 'auto_tags': 1,
"        \ 'auto_generate_tags': 1,
"        \ 'auto_generate_links': 1,
"        \ 'automatic_nested_syntaxes': 1,
"        \ 'path': '$HOME/blog/content/en/docs/',
"        \ 'path_html': '$HOME/blog/public',
"        \ 'syntax': 'markdown',
"        \ 'ext': '.md',
"        \ 'index' : '_index',
"        \ 'custom_wiki2html': '$HOME/dotfiles/extras/wiki2html.sh',
"        \ 'let wiki.nested_syntaxes': {'python': 'python', 'bash': 'sh'},
"        \ 'html_filename_parameterization': 1
"        \ }]

"let g:vimwiki_hl_cb_checked = 2
"let g:vimwiki_global_ext = 1 " make sure vimwiki doesn't own all .md files
"let g:vimwiki_use_mouse = 1
"let g:vimwiki_conceallevel=1
"let g:vimwiki_markdown_link_ext = 0
"let g:list_margin=0
"let g:vimwiki_user_htmls = '404.html,search.html,books.html,todo,html,contact.html,tags.html'
"let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1,nav,body,aside'

"hi VimwikiHeader1 guifg=#e5c07b
"hi VimwikiHeader2 guifg=#98c379
"hi VimwikiHeader3 guifg=#c678dd
"hi VimwikiHeader4 guifg=#8096BF
"hi VimwikiHeader5 guifg=#8096BF
"hi VimwikiHeader6 guifg=#8096BF

"hi VimwikiH1Folding guifg=#e5c07b
"hi VimwikiH2Folding guifg=#98c379
"hi VimwikiH3Folding guifg=#c678dd
"hi VimwikiH4Folding guifg=#8096BF
"hi VimwikiH5Folding guifg=#8096BF
"hi VimwikiH6Folding guifg=#8096BF

"hi VimwikiLink guifg=#61afef
"hi VimwikiLink guifg=#61afef
"hi VimwikiBold term=reverse cterm=underline ctermfg=204 gui=underline guifg=#E06C75

""=================================================================================================================================
"" 方案三(异步) - 最终方案
"func GitPull()
"    " 获取云端最新版
"    exec "w"
"    exec ":cd %:h"
"    .normal ^L
"    exec ":AsyncStop"
"    exec ":AsyncRun git pull origin master"
"    autocmd User AsyncRunStop exec ":ccl"
"    autocmd User AsyncRunStop exec ":e %"
"    let g:asyncrun_exit = "echom 'Sync Done'"
"endfunc

"func GitCommit()
"    " 提交到本地
"    call system("git add --all")
"	call system("git commit -m \"`whoami` @  `hostname` in `date +%Y-%m-%d=%H:%M:%S`\"")
"	exec ":AsyncRun git push origin master"
"    let g:asyncrun_exit = "echom 'Git Push Done'"
"endfunc

"func GitPush()
"    " 上传到云端
"    call system("git add --all")
"	call system("git commit -m \"`whoami` @  `hostname` in `date +%Y-%m-%d=%H:%M:%S`\"")
"	exec ":AsyncRun -mode=hide git push origin master"
"    exec ":AsyncStop"
"    let g:asyncrun_exit = "echom 'Done'"
"endfunc

"autocmd BufReadPost $HOME/blog/content/en/docs/_index.md call GitPull()
"autocmd BufWritePost $HOME/blog/contet/en/docs/_index.md call GitCommit()
"autocmd VimLeave $HOME/blog/* call GitPush() 

""=================================================================================================================================
"" 自定义airline同步通知颜色
"function! AirlineThemePatch(palette)
"  " [ guifg, guibg, ctermfg, ctermbg, opts ].
"  " See "help attr-list" for valid values for the "opt" value.
"  " http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
"  let a:palette.accents.running = [ '#c678dd', '' , '', '', '' ]
"  let a:palette.accents.success = [ '#61afef', '' , '', '', '' ]
"  let a:palette.accents.failure = [ '#e06c75', '' , '', '', '' ]
"endfunction
"let g:airline_theme_patch_func = 'AirlineThemePatch'

"" Change color of the relevant section according to g:asyncrun_status, a global variable exposed by AsyncRun
"" 'running': default, 'success': green, 'failure': red
"let g:asyncrun_status = ''
"let g:async_status_old = ''
"function! Get_asyncrun_running()
"  let async_status = g:asyncrun_status
"  if async_status != g:async_status_old
"    if async_status == 'running'
"      call airline#parts#define_accent('asyncrun_status', 'running')
"    elseif async_status == 'success'
"      call airline#parts#define_accent('asyncrun_status', 'success')
"    elseif async_status == 'failure'
"      call airline#parts#define_accent('asyncrun_status', 'failure')
"    endif
"    let g:airline_section_x = airline#section#create(['asyncrun_status'])
"    AirlineRefresh
"    let g:async_status_old = async_status
"  endif
"  return async_status
"endfunction

"try 
"call airline#parts#define_function('asyncrun_status', 'Get_asyncrun_running')
"let g:airline_section_x = airline#section#create(['asyncrun_status'])
"catch
"endtry

""=================================================================================================================================
"" 使用wd删除markdown时自动删除相对应不使用的HTML文件
"function! VimwikiDeleteClean()
"  let htmlfile = expand('%:r') . '.html'
"  lcd ${HOME}/vimwiki/docs/
"  call delete(htmlfile)
"  lcd %:p:h
"  call vimwiki#base#delete_link()
"endfunction
"autocmd filetype vimwiki nnoremap <buffer> <leader>wd :call VimwikiDeleteClean()<CR>

""=================================================================================================================================
"" 
""
""
""
""
""
"" Vimwiki DEFAULT  settings
""
""
""
""
""
""
""=================================================================================================================================
""=================================================================================================================================
"" Vimwiki Zettel settings
""=================================================================================================================================
"let g:zettel_dir = "$HOME/vimwiki/src"
"let g:zettel_format = "%Y-%m-%d-%H-%M"
"let g:zettel_link_format="[%title](%link)"
"let g:zettel_options = [{"template" :  "$HOME/vimwiki/templates/zettelnew.tpl"}]

""=================================================================================================================================
"" Vimwiki settings
""=================================================================================================================================
"" Vimwiki 快捷键设置
"" autocmd FileType vimwiki nmap <Leader>wg <Plug>Vimwiki2HTMLBrowse
"" autocmd FileType vimwiki nmap <Leader>wh :VimwikiAll2HTML<cr>
"" autocmd FileType vimwiki nmap <Leader>wb :ZettelBackLinks<cr>
"" autocmd FileType vimwiki nmap <Leader>wn :ZettelNew<cr>
"" autocmd FileType vimwiki nmap <Leader>wl :VimwikiBacklinks<cr>
"autocmd FileType vimwiki nmap <Leader>ws :VWS<Space>
"autocmd FileType vimwiki nmap <Plug>VimwikiUISelect <nop>

"let g:vimwiki_list = [{
"        \ 'auto_export': 1,
"	\ 'auto_tags': 1,
"        \ 'auto_generate_tags': 1,
"        \ 'auto_generate_links': 1,
"        \ 'automatic_nested_syntaxes': 1,
"        \ 'path': '$HOME/vimwiki/src',
"        \ 'path_html': '$HOME/vimwiki/docs/',
"        \ 'template_path': '$HOME/vimwiki/templates/',
"        \ 'template_default': 'default',
"        \ 'template_ext': '.tpl',
"        \ 'css_file': '$HOME/vimwiki/templates/style.css',
"        \ 'syntax': 'markdown',
"        \ 'ext': '.md',
"        \ 'custom_wiki2html': 'vimwiki_markdown',
"        \ 'let wiki.nested_syntaxes': {'python': 'python', 'bash': 'sh'},
"        \ 'html_filename_parameterization': 1
"        \ }]

"let g:vimwiki_hl_cb_checked = 2
"let g:vimwiki_ext = '.md' " set extension to .md
"let g:vimwiki_global_ext = 0 " make sure vimwiki doesn't own all .md files
"let g:vimwiki_use_mouse = 1
"let g:vimwiki_conceallevel=1
"let g:vimwiki_markdown_link_ext = 1
"let g:list_margin=0
"let g:vimwiki_user_htmls = '404.html,search.html,books.html,todo,html,contact.html,tags.html'
"let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1,nav,body,aside'

"hi VimwikiHeader1 guifg=#e5c07b
"hi VimwikiHeader2 guifg=#98c379
"hi VimwikiHeader3 guifg=#c678dd
"hi VimwikiHeader4 guifg=#8096BF
"hi VimwikiHeader5 guifg=#8096BF
"hi VimwikiHeader6 guifg=#8096BF

"hi VimwikiH1Folding guifg=#e5c07b
"hi VimwikiH2Folding guifg=#98c379
"hi VimwikiH3Folding guifg=#c678dd
"hi VimwikiH4Folding guifg=#8096BF
"hi VimwikiH5Folding guifg=#8096BF
"hi VimwikiH6Folding guifg=#8096BF

"hi VimwikiLink guifg=#61afef
"hi VimwikiLink guifg=#61afef
"hi VimwikiBold term=reverse cterm=underline ctermfg=204 gui=underline guifg=#E06C75

""=================================================================================================================================
"" 自动执行同步src的img同步到docs的img脚本
"au VimEnter *
"            \  if (isdirectory($HOME . "vimwiki")) && filereadable("$HOME/dotfiles/extras/vimwiki_img_autosync.sh")
"            \| silent execute "!nohup $HOME/dotfiles/extras/vimwiki_img_autosync.sh >/dev/null 2>&1 &"
"            \| endif

"" 开启/关闭Vimiki时自动步上传github

"" 方案一
""augroup vimwiki
"  "if !exists('g:zettel_synced')
"    "let g:zettel_synced = 0
"  "else
"    "finish
"  "endif

"  "if !exists('g:zettel_dir')
"    "let g:zettel_dir = vimwiki#vars#get_wikilocal('path')
"  "endif

"  "function! s:git_action(action)
"    "exec ":cd %:h"
"    ".normal ^L
"    "exec ":AsyncStop"
"    "exec ":AsyncRun !pushd" . g:zettel_dir . "; ". a:action . "; popd"
"    "autocmd User AsyncRunStop exec ":ccl"
"    "autocmd User AsyncRunStop exec ":e %"
"    "redraw!
"  "endfunction

"  "" sync changes at the start
"  "au! BufRead $HOME/vimwiki/src/index.md call <sid>git_action("git pull origin master")
"  "au! BufWritePost $HOME/vimwiki/src/index.md call <sid>git_action("git add .;git commit -m \"Auto commit + push. `date`\"")
"  "au! VimLeave $HOME/vimwiki/src/index.md call <sid>git_action("git push origin master")
""augroup END


"" 方案二
""au! BufReadPost $HOME/vimwiki/src/index.md !git -C $HOME/vimwiki/ pull origin master
""au! BufWritePost $HOME/vimwiki/* !git -C $HOME/vimwiki/ add . ;git commit -m "Auto commit."
""au! VimLeave $HOME/vimwiki/* !bash $HOME/dotfiles/extras/comparefolders.sh || !git -C $HOME/vimwiki/ add . ;git commit -m "Auto commit + push." ;git push origin master


"" " 方案三(异步)
"" func GitPull()
""     " 获取云端最新版
""     exec "w"
""     exec ":cd %:h"
""     .normal ^L
""     exec ":AsyncStop"
""     exec ":AsyncRun git pull origin master"
""     autocmd User AsyncRunStop exec ":ccl"
""     autocmd User AsyncRunStop exec ":e %"
""     let g:asyncrun_exit = "echom 'Sync Done'"
"" endfunc

"" func GitCommit()
""     " 提交到本地
""     call system("git add --all")
"" 	call system("git commit -m \"`whoami` @  `hostname` in `date +%Y-%m-%d=%H:%M:%S`\"")
"" 	exec ":AsyncRun git push origin master"
""     let g:asyncrun_exit = "echom 'Git Push Done'"
"" endfunc

"" func GitPush()
""     " 上传到云端
""     call system("git add --all")
"" 	call system("git commit -m \"`whoami` @  `hostname` in `date +%Y-%m-%d=%H:%M:%S`\"")
"" 	exec ":AsyncRun -mode=bang git push origin master"
""     exec ":AsyncStop"
""     let g:asyncrun_exit = "echom 'Done'"
"" endfunc

"" autocmd BufReadPost $HOME/vimwiki/src/index.md call GitPull()
"" autocmd BufWritePost $HOME/vimwiki/src/index.md call GitCommit()
"" autocmd VimLeave $HOME/vimwiki/* if exists("g:asyncrun_exit") | call GitPush() | endif

"" let g:asyncrun_status= ''
"" if exists('g:asyncrun_status')
"" let g:airline_section_x = airline#section#create_right(['%{g:asyncrun_status}'])
"" endif


"" " 方案三(异步)
"" func GitPull()
""     " 获取云端最新版
""     exec "w"
""     exec ":cd %:h"
""     .normal ^L
""     exec ":AsyncStop"
""     exec ":AsyncRun git pull origin master"
""     autocmd User AsyncRunStop exec ":ccl"
""     autocmd User AsyncRunStop exec ":e %"
""     let g:asyncrun_exit = "echom 'Sync done'"
"" endfunc

"" func GitCommit()
""     " 提交到本地
""     exec ":AsyncStop"
""     exec ":AsyncRun git -C $HOME/vimwiki/ add . ;git commit -m 'Auto commit'"
"" endfunc

"" func GitPush()
""     " 上传到云端
""     exec ":AsyncStop"
""     exec ":AsyncRun git -C $HOME/vimwiki/ add . ;git commit -m \"Auto commit `date`\" ;git push origin master"
"" endfunc

"" autocmd BufReadPost $HOME/vimwiki/src/index.md call GitPull()
"" autocmd BufWritePost $HOME/vimwiki/src/index.md call GitPush()
"" autocmd VimLeave $HOME/vimwiki/* !git -C $HOME/vimwiki/ add . ;git commit -m "Auto commit + push." ;git push origin master

"" 方案三(异步) - 最终方案
"func GitPull()
"    " 获取云端最新版
"    exec "w"
"    exec ":cd %:h"
"    .normal ^L
"    exec ":AsyncStop"
"    exec ":AsyncRun git pull origin master"
"    autocmd User AsyncRunStop exec ":ccl"
"    autocmd User AsyncRunStop exec ":e %"
"    let g:asyncrun_exit = "echom 'Sync Done'"
"endfunc

"func GitCommit()
"    " 提交到本地
"    call system("git add --all")
"	call system("git commit -m \"`whoami` @  `hostname` in `date +%Y-%m-%d=%H:%M:%S`\"")
"	exec ":AsyncRun git push origin master"
"    let g:asyncrun_exit = "echom 'Git Push Done'"
"endfunc

"func GitPush()
"    " 上传到云端
"    call system("git add --all")
"	call system("git commit -m \"`whoami` @  `hostname` in `date +%Y-%m-%d=%H:%M:%S`\"")
"	exec ":AsyncRun -mode=hide git push origin master"
"    exec ":AsyncStop"
"    let g:asyncrun_exit = "echom 'Done'"
"endfunc

"autocmd BufReadPost $HOME/vimwiki/src/index.md call GitPull()
"autocmd BufWritePost $HOME/vimwiki/src/index.md call GitCommit()
"autocmd VimLeave $HOME/vimwiki/* call GitPush() 

""=================================================================================================================================
"" 自定义airline同步通知颜色
"function! AirlineThemePatch(palette)
"  " [ guifg, guibg, ctermfg, ctermbg, opts ].
"  " See "help attr-list" for valid values for the "opt" value.
"  " http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
"  let a:palette.accents.running = [ '#c678dd', '' , '', '', '' ]
"  let a:palette.accents.success = [ '#61afef', '' , '', '', '' ]
"  let a:palette.accents.failure = [ '#e06c75', '' , '', '', '' ]
"endfunction
"let g:airline_theme_patch_func = 'AirlineThemePatch'

"" Change color of the relevant section according to g:asyncrun_status, a global variable exposed by AsyncRun
"" 'running': default, 'success': green, 'failure': red
"let g:asyncrun_status = ''
"let g:async_status_old = ''
"function! Get_asyncrun_running()
"  let async_status = g:asyncrun_status
"  if async_status != g:async_status_old
"    if async_status == 'running'
"      call airline#parts#define_accent('asyncrun_status', 'running')
"    elseif async_status == 'success'
"      call airline#parts#define_accent('asyncrun_status', 'success')
"    elseif async_status == 'failure'
"      call airline#parts#define_accent('asyncrun_status', 'failure')
"    endif
"    let g:airline_section_x = airline#section#create(['asyncrun_status'])
"    AirlineRefresh
"    let g:async_status_old = async_status
"  endif
"  return async_status
"endfunction

"" if !empty(glob("$HOME/.vim/plugged/vim-airline"))
"" call airline#parts#define_function('asyncrun_status', 'Get_asyncrun_running')
"" let g:airline_section_x = airline#section#create(['asyncrun_status'])
"" endif

"try 
"call airline#parts#define_function('asyncrun_status', 'Get_asyncrun_running')
"let g:airline_section_x = airline#section#create(['asyncrun_status'])
"catch
"endtry


""=================================================================================================================================
"" 使用wd删除markdown时自动删除相对应不使用的HTML文件
"function! VimwikiDeleteClean()
"  let htmlfile = expand('%:r') . '.html'
"  lcd ${HOME}/vimwiki/docs/
"  call delete(htmlfile)
"  lcd %:p:h
"  call vimwiki#base#delete_link()
"endfunction
"autocmd filetype vimwiki nnoremap <buffer> <leader>wd :call VimwikiDeleteClean()<CR>


"=================================================================================================================================
" Nuake settings
"=================================================================================================================================
"nnoremap <F6> :Nuake<CR>
"inoremap <F6> <C-\><C-n>:Nuake<CR>
"tnoremap <F6> <C-\><C-n>:Nuake<CR>
"nnoremap <silent><localleader>c :Nuake<CR>
"inoremap <silent><localleader>c <C-\><C-n>:Nuake<CR>
"tnoremap <silent><localleader>c <C-\><C-n>:Nuake<CR>

"let g:nuake_position = 'bottom'                                  " 'bottom', 'right', 'top' or 'left'.
"let g:nuake_size = 0.38                                          " 'default 0.25'


"=================================================================================================================================
" EasyAlign  settings
"=================================================================================================================================
" Start interactive EasyAlign in visual mode (e.g. vipga)
xnoremap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nnoremap ga <Plug>(EasyAlign)

let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>'  },
\ '/': {
\     'pattern':         '//\+\|/\*\|\*/',
\     'delimiter_align': 'l',
\     'ignore_groups':   ['!Comment'] },
\ ']': {
\     'pattern':       '[[\]]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       '[()]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ 'd': {
\     'pattern':      ' \(\S\+\s*[;=]\)\@=',
\     'left_margin':  0,
\     'right_margin': 0
\   }
\ }


"=================================================================================================================================
" Vim-visual-multi  settings
"=================================================================================================================================
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n


"=================================================================================================================================
" Goyo  settings
"=================================================================================================================================
function! s:goyo_enter()
	if has('gui_running')
		set background=light
		set linespace=7
	elseif exists('$TMUX')
		silent !tmux set status off
	endif
	set noshowmode
	set noshowcmd
	Limelight
endfunction

function! s:goyo_leave()
	if has('gui_running')
		set background=dark
		set linespace=0
	elseif exists('$TMUX')
		silent !tmux set status on
	endif
	set showmode
	set showcmd
	Limelight!
endfunction

" Goyo Commands 
augroup user_plugin_goyo
	autocmd!
	autocmd! User GoyoEnter
	autocmd! User GoyoLeave
	autocmd  User GoyoEnter nested call <SID>goyo_enter()
	autocmd  User GoyoLeave nested call <SID>goyo_leave()
augroup END

"=================================================================================================================================

" Auto switch goyo
function! Switch_goyo()
    if  winnr('$') == 1
        Goyo 200x200
    elseif exists('#goyo')
        Goyo!
    endif
endfunction
nnoremap <silent><Leader>go :call Switch_goyo()<cr>


"=================================================================================================================================
" Limelight  settings
"=================================================================================================================================
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!


"=================================================================================================================================
" AutoPairs  settings
"=================================================================================================================================
let g:AutoPairsMapCh = 0
let g:AutoPairsMapBS = 0
let g:AutoPairsMapCR = 0
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsshortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''


"=================================================================================================================================
" Which Key Map  settings
"=================================================================================================================================
" let g:which_key_sep = '→'
let g:which_key_sep = ' ◆ '
let g:which_key_use_floating_win = 0
let g:which_key_use_floating_relative = 0
let g:which_key_align_by_seperator = 1
let g:which_key_flatten = 1
let g:which_key_run_map_on_popup = 0
let g:which_key_fallback_to_native_key=1
let g:which_key_disable_default_offset = 1
let g:which_key_exit = ["\<Esc>","\q"]
let g:which_key_hspace = 3
let g:which_key_vertical = 0
let g:which_key_max_size = 0
let g:which_key_sort_horizontal = 0
"=================================================================================================================================
highlight default link WhichKey          Function
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Keyword
highlight default link WhichKeyDesc      Identifier
highlight default link WhichKeyFloating  Pmenu
"highlight Pmenu ctermbg=red guibg=#282c34
"highlight Keyword ctermbg=red guibg=#282c34
"highlight Function ctermbg=red guibg=#282c34

"=================================================================================================================================
let g:which_key_map =  {}

let g:which_key_map = {
  \
  \ 'e'    : [ ''                                            , 'MarkdownPreview'             ] ,
  \ 'p'    : [ ''                                            , 'ClipboardImage to Vim'       ] ,
  \ 'l'    : [ ''                                            , 'Toggle IndentLines'          ] ,
  \
  \ '<F2>' : [ ''                                            , 'Toggle Number'               ] ,
  \ '<F3>' : [ ''                                            , 'Toggle Syntax'               ] ,
  \ '<F4>' : [ ''                                            , 'Toggle Paste'                ] ,
  \ '<F5>' : [ ''                                            , 'Toggle Runner'               ] ,
  \ '<F6>' : [ ''                                            , 'Toggle Terminal'             ] ,
  \ '<F7>' : [ ''                                            , 'Toggle QuickFix'             ] ,
  \ '<F8>' : [ ''                                            , 'Toggle NERDTree'             ] ,
  \ '<F9>' : [ ''                                            , 'Toggle TagBar'               ] ,
  \
  \ 'm'    : {
  \ 'name' : '+SignatureMap',
  \
  \ "a"    : [''                                             , 'List All Marks'              ] ,
  \ "m"    : [''                                             , 'MarkLine'                    ] ,
  \ "d"    : [''                                             , 'Delete Marks'                ] ,
  \ "x"    : [''                                             , 'Delete All Marks'            ] ,
  \ "n"    : [''                                             , 'Next Marks Line'             ] ,
  \ "p"    : [''                                             , 'Prev Marks Line'             ] ,
  \ "f"    : [''                                             , 'Next Marks Spot'             ] ,
  \ "b"    : [''                                             , 'Prev Marks Spot'             ] ,
  \
  \ },
  \
  \ }

let g:which_key_map[';'] = {
  \ 'name' : '+LocalLeader' ,
  \
  \ 'q'    : [ ''                                            , 'Exit'                        ] ,
  \ 'w'    : [ ''                                            , 'Save'                        ] ,
  \ 't'    : [ ''                                            , 'Toggle TagBar'               ] ,
  \ 'b'    : [ ''                                            , 'Toggle LeaderF BufferTag'    ] ,
  \ 'u'    : [ ''                                            , 'Toggle LeaderF Functions'    ] ,
  \ 'f'    : [ ''                                            , 'Toggle LeaderF Files'        ] ,
  \ 'e'    : [ ''                                            , 'Toggle NERDTree'             ] ,
  \ 'm'    : [ ''                                            , 'Toggle Signature'            ] ,
  \ 'z'    : [ ''                                            , 'Toggle Zoom mode'            ] ,
  \ 'y'    : [ ''                                            , 'Copy  System Clipboard'      ] ,
  \ 'p'    : [ ''                                            , 'Paste System Clipboard'      ] ,
  \ 's'    : [ ''                                            , 'Toggle Startify'             ] ,
  \ 'r'    : [ ''                                            , 'Toggle Runner Code'          ] ,
  \ 'c'    : [ ''                                            , 'Toggle Terminal'             ] ,
  \
  \ "1"    : [''                                             , 'Toggle Buffers 1 '           ] ,
  \ "2"    : [''                                             , 'Toggle Buffers 2 '           ] ,
  \ "3"    : [''                                             , 'Toggle Buffers 3 '           ] ,
  \ "4"    : [''                                             , 'Toggle Buffers 4 '           ] ,
  \ "5"    : [''                                             , 'Toggle Buffers 5 '           ] ,
  \ "6"    : [''                                             , 'Toggle Buffers 6 '           ] ,
  \ "7"    : [''                                             , 'Toggle Buffers 7 '           ] ,
  \ "8"    : [''                                             , 'Toggle Buffers 8 '           ] ,
  \ "9"    : [''                                             , 'Toggle Buffers 9 '           ] ,
  \ "0"    : [''                                             , 'Toggle Buffers 10'           ] ,
  \ "a"    : [''                                             , 'Buffer Add'                  ] ,
  \ "Tab"  : [''                                             , 'Buffer Next'                 ] ,
  \ "STab" : [''                                             , 'Buffer Previous'             ] ,
  \
  \ "<Tab>": [''                                             , 'Edit Mode UltiSnip'          ] ,
  \
  \ }

let g:which_key_map.d = {
  \ 'name' : '+Display',
  \
  \ "w"    : ['<C-W>w'                                       , 'other-window'                ] ,
  \ "d"    : ['<C-W>c'                                       , 'delete-window'               ] ,
  \ "b"    : ['<C-W>s'                                       , 'split-window-below'          ] ,
  \ "r"    : ['<C-W>v'                                       , 'split-window-right'          ] ,
  \ "2"    : ['<C-W>v'                                       , 'layout-double-columns'       ] ,
  \ "h"    : ['<C-W>5<'                                      , 'expand-window-left'          ] ,
  \ "l"    : ['<C-W>5>'                                      , 'expand-window-right'         ] ,
  \ "a"    : ['<C-W>='                                       , 'balance-window'              ] ,
  \ "s"    : ['<C-W>s'                                       , 'split-window-below'          ] ,
  \ "v"    : ['<C-W>v'                                       , 'split-window-below'          ] ,
  \ "k"    : [':resize -5'                                   , 'expand-window-up'            ] ,
  \ "j"    : [':resize +5'                                   , 'expand-window-below'         ] ,
  \
  \ }

let g:which_key_map.f = {
  \ "name" : "+FZF",
  \
  \ "f"    : ['Files'                                        , 'Search Files'                ] ,
  \ "l"    : ['BLines'                                       , 'Search Lines Buffers'        ] ,
  \ "o"    : ['Colors'                                       , 'Search Color Themes'         ] ,
  \ "t"    : ['BTags'                                        , 'Search Tags'                 ] ,
  \ "b"    : ['Buffers'                                      , 'Search Open Buffers'         ] ,
  \ "i"    : ['GFiles'                                       , 'Search Git-Files'            ] ,
  \ "g"    : ['GFiles?'                                      , 'Search Modified-Git-Files'   ] ,
  \ "a"    : ['Ag'                                           , 'Search Ag'                   ] ,
  \ "r"    : ['Rg'                                           , 'Search Rg'                   ] ,
  \ "m"    : ['Marks'                                        , 'Search Marks'                ] ,
  \ "w"    : ['Windows'                                      , 'Search Windows'              ] ,
  \ "c"    : ['Commands'                                     , 'Search Commands'             ] ,
  \
  \ }


let g:which_key_map.t = {
  \ 'name' : '+Table Mode',
  \
  \ "m"    : ['TableModeToggle'                              , 'TableModeToggle'             ] ,
  \
  \ }

let g:which_key_map.v = {
  \ 'name' : '+VCS',
  \
  \ "e"    : ['Gbrowse'                                     , 'Browse'                       ] ,
  \ "i"    : ['Gdiff'                                       , 'Diff'                         ] ,
  \ "g"    : ['Gmerge'                                      , 'Merge'                        ] ,
  \ "s"    : ['Gpush'                                       , 'Push'                         ] ,
  \ "a"    : ['Grebase'                                     , 'Rebase'                       ] ,
  \ "b"    : ['Gblame'                                      , 'Blame'                        ] ,
  \ "c"    : ['Gcommit'                                     , 'Commit'                       ] ,
  \ "d"    : ['Gdelete'                                     , 'Delete'                       ] ,
  \ "f"    : ['Gfetch'                                      , 'Fetch'                        ] ,
  \ "o"    : ['Glog'                                        , 'Log'                          ] ,
  \ "m"    : ['Gmove'                                       , 'Move'                         ] ,
  \ "l"    : ['Gpull'                                       , 'Pull'                         ] ,
  \ "r"    : ['Grename'                                     , 'Rename'                       ] ,
  \ "t"    : ['Gstatus'                                     , 'Status'                       ] ,
  \
  \ }

let g:which_key_map.w = {
  \ 'name' : '+VimWiki',
  \
  \ "w"    : [''                                            , 'Go To Index'                  ] ,
  \ "n"    : [''                                            , 'Create new wiki page'         ] ,
  \ "d"    : [''                                            , 'Delete wiki page'             ] ,
  \ "r"    : [''                                            , 'Rename wiki page'             ] ,
  \ "v"    : [''                                            , 'Toggle wiki List'             ] ,
  \ "s"    : [''                                            , 'Search-for-wiki-pattam'       ] ,
  \ "f"    : [''                                            , 'Search-for-wiki-curword'      ] ,
  \
  \ 'c'    : {
  \ 'name' : '+CheckBox',
  \
  \ "t"    : ['VimwikiToggleListItem'                       , 'Toggle checkbox On/Off'       ] ,
  \ "n"    : ['VimwikiIncrementListItem'                    , 'Toggle checkbox Next/Previous'] ,
  \
  \ },
  \
  \ 't'    : {
  \ 'name' : '+Tables',
  \
  \ "t"    : ['VimwikiTable'                                , 'Create Table'                             ] ,
  \ "h"    : ['<Plug>VimwikiTableMoveColumnLeft'            , 'Move current column to the left'          ] ,
  \ "l"    : ['<Plug>VimwikiTableMoveColumnRight'           , 'Move current column to the Right'         ] ,
  \
  \ },
  \
  \ 'z'    : {
  \ 'name' : '+Zettel',
  \
  \ "b"    : ['ZettelBackLinks'                             , 'add-backlineks'                           ] ,
  \ "n"    : ['ZettelNew'                                   , 'add-new'                                  ] ,
  \ "o"    : ['ZettelOpen'                                  , 'Search fulltext use FZF'                  ] ,
  \ "i"    : ['ZettelInsertNote'                            , 'Using FZF and insert in the current'      ] ,
  \ "s"    : ['ZettelSearch'                                , 'Search the content of your zettelkasten'  ] ,
  \ "y"    : ['ZettelYankName'                              , 'Copy the current zettel file name'        ] ,
  \
  \ },
  \
  \ }

let g:which_key_map.g = {
  \ 'name' : '+Goyo',
  \
  \ "o"    : [':call Switch_goyo()'                         , 'Enter Goyo Mode'                          ] ,
  \
  \ }


"=================================================================================================================================
if !exists('which_key#register')
    silent! call which_key#register('<Space>', "g:which_key_map")
endif

" nnoremap <silent><space><space> :<c-u>WhichKey '<Space>'<CR>
" vnoremap <silent><space><space> :<c-u>WhichKeyVisual '<Space>'<CR>

nnoremap <silent><leader> :WhichKey '<Space>'<CR>
vnoremap <silent><leader> :WhichKeyVisual '<Space>'<CR>

autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
  

"=================================================================================================================================
" Signature  settings
"=================================================================================================================================
let g:SignatureEnabledAtStartup = 1
let g:SignatureForceMarkPlacement = 1
let g:SignatureForceMarkerPlacement = 1
let g:SignatureWrapJumps = 0
let g:SignatureMarkOrder="\m"
nnoremap <silent><localleader>m :SignatureToggleSigns<CR> 

let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m.",
        \ 'ToggleMarkAtLine'   :  "mm",
        \ 'PurgeMarksAtLine'   :  "m-",
        \ 'DeleteMark'         :  "md",
        \ 'PurgeMarks'         :  "mx",
        \ 'PurgeMarkers'       :  "m<SPACE>",
        \ 'GotoNextLineAlpha'  :  "']",
        \ 'GotoPrevLineAlpha'  :  "'[",
        \ 'GotoNextSpotAlpha'  :  "`]",
        \ 'GotoPrevSpotAlpha'  :  "`[",
        \ 'GotoNextLineByPos'  :  "mn",
        \ 'GotoPrevLineByPos'  :  "mp",
        \ 'GotoNextSpotByPos'  :  "mf",
        \ 'GotoPrevSpotByPos'  :  "mb",
        \ 'GotoNextMarker'     :  "]-",
        \ 'GotoPrevMarker'     :  "[-",
        \ 'GotoNextMarkerAny'  :  "]=",
        \ 'GotoPrevMarkerAny'  :  "[=",
        \ 'ListBufferMarks'    :  "ma",
        \ 'ListBufferMarkers'  :  "m?"
        \ }
	
" augroup Quickfix
" 	autocmd!
" 	autocmd FileType qf setlocal nonumber
"     	autocmd FileType qf nnoremap <buffer> <CR> <CR>:lclose<CR>
"     	autocmd FileType qf nnoremap <buffer> ma :lclose<CR>
" augroup END

autocmd FileType qf 6wincmd_

hi SignatureMarkText   term=standout ctermbg=2   ctermbg=2   guifg=#E06C75 guibg=#282C34   " 书签标记颜色
hi SignatureMarkerText term=standout ctermbg=2   ctermbg=2   guifg=#E06C75 guibg=#282C34   " 折叠提示颜色

"=================================================================================================================================
" Vim-bookmarks  settings
"=================================================================================================================================
" let g:bookmark_sign = ' ' "⚑ ♥ 
" let g:bookmark_annotation_sign = ' ' "☰  ﭅ 
" let g:bookmark_auto_close = 1                 "跳转到标签后自动关闭
" let g:bookmark_save_per_working_dir = 1
" let g:bookmark_auto_save = 1
" let g:bookmark_highlight_lines = 0             "高亮书签行
" hi BookmarkSign           term=standout ctermbg=2   ctermfg=2   guifg=#E06C75 guibg=#282C34   " 书签标记颜色
" hi BookmarkAnnotationSign term=standout ctermbg=2   ctermfg=2   guifg=#98C379 guibg=#282C34   " 书签标记颜色
" hi BookmarkLine           term=standout ctermbg=2   ctermfg=2   guifg=#E06C75 guibg=#282C34   " 书签标记颜色-行
" hi BookmarkAnnotationLine term=standout ctermbg=2   ctermfg=2   guifg=#98C379 guibg=#282C34   " 书签标记颜色-行

"=================================================================================================================================
" Ultisnips settings
"=================================================================================================================================
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

"=================================================================================================================================
" Gutentags settings
"=================================================================================================================================
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
"let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
"let g:gutentags_ctags_tagfile = '.tags'

" 同时开启 ctags 和 gtags 支持：
"let g:gutentags_modules = []
"if executable('ctags')
"	let g:gutentags_modules += ['ctags']
"endif
"if executable('gtags-cscope') && executable('gtags')
"	let g:gutentags_modules += ['gtags_cscope']
"endif

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
"let s:vim_tags = expand('~/.cache/tags')
"let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
"let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
"let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
"let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
"let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 检测 ~/.cache/tags 不存在就新建
"if !isdirectory(s:vim_tags)
"   silent! call mkdir(s:vim_tags, 'p')
"endif

"=================================================================================================================================
" LeaderF settings
"=================================================================================================================================
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_WindowHeight = 0.30
let g:Lf_StlColorscheme = 'one'
let g:Lf_DisableStl = 0
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_ShowDevIcons = 0
let g:Lf_ShortcutF = '' 
let g:Lf_ShortcutB = '' 
let g:Lf_WindowPosition = 'bottom'
let g:Lf_ShowRelativePath = 0
let g:Lf_PopupWidth = &columns * 1 / 2
let g:Lf_PopupHeight = float2nr(&lines * 0.3)
let g:Lf_PopupShowStatusline = 1
let g:Lf_PopupColorscheme = 'one'
let g:Lf_PopupShowFoldcolumn = 0
let g:Lf_CommandMap = { '<C-j>': ['<Down>'], '<C-k>': ['<Up>']}
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_SpinSymbols =  ['🌘', '🌗', '🌖', '🌕', '🌔', '🌓', '🌒', '🌑']
let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
            \}

hi Cursor                      gui=bold    guifg=#E06C75  guibg=#E06C75
hi Lf_hl_cursorline            gui=bold    guifg=#C678DD
hi Lf_hl_match                 gui=bold    guifg=#e06c75
hi Lf_hl_match2                gui=bold    guifg=#3FF5D1
hi Lf_hl_match3                gui=bold    guifg=#FF7272
hi Lf_hl_match4                gui=bold    guifg=#43B9F0
hi Lf_hl_matchRefine           gui=bold    guifg=#e06c75
hi Lf_hl_selection             gui=bold    guifg=#282C34  guibg=#A5EB84
hi Lf_hl_buftagLineNum         gui=bold    guifg=#abb2bf
hi Lf_hl_cursor                gui=bold    guifg=#E06C75  guibg=#E06C75
hi Lf_hl_popup_cursor          gui=bold    guifg=#E06C75  guibg=#E06C75
hi Lf_hl_quickfixColumnNumber  gui=bold    guifg=#E06C75  guibg=#E06C75
hi Lf_hl_loclistColumnNumber   gui=bold    guifg=#E06C75  guibg=#E06C75
hi Lf_hl_rgColumnNumber        gui=bold    guifg=#E06C75  guibg=#E06C75
hi Lf_hl_stlSpin               gui=bold    guifg=#E06C75  guibg=#3B3E4C

let g:Lf_StlPalette = {
            \   'stlName': {
            \       'gui': 'bold',
            \       'font': 'NONE',
            \       'guifg': '#ABBABF',
            \       'guibg': '#40444E',
            \       'cterm': 'bold',
            \       'ctermfg': '22',
            \       'ctermbg': '157'
            \   },
            \   'stlCategory': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '#ABBABF',
            \       'guibg': '#2C3339',
            \       'cterm': 'NONE',
            \       'ctermfg': '16',
            \       'ctermbg': '210'
            \   },
            \   'stlNameOnlyMode': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '#ABBABF',
            \       'guibg': '#40444E',
            \       'cterm': 'NONE',
            \       'ctermfg': '16',
            \       'ctermbg': '227'
            \   },
            \   'stlFullPathMode': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '#ABBABF',
            \       'guibg': '#40444E',
            \       'cterm': 'NONE',
            \       'ctermfg': '16',
            \       'ctermbg': '147'
            \   },
            \   'stlFuzzyMode': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '#ABBABF',
            \       'guibg': '#40444E',
            \       'cterm': 'NONE',
            \       'ctermfg': '16',
            \       'ctermbg': '227'
            \   },
            \   'stlRegexMode': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '#ABBABF',
            \       'guibg': '#40444E',
            \       'cterm': 'NONE',
            \       'ctermfg': '16',
            \       'ctermbg': '121'
            \   },
            \   'stlCwd': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '#ABB2BF',
            \       'guibg': '#282c45',
            \       'cterm': 'NONE',
            \       'ctermfg': '195',
            \       'ctermbg': '241'
            \   },
            \   'stlBlank': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': 'NONE',
            \       'guibg': '#3B3E4C',
            \       'cterm': 'NONE',
            \       'ctermfg': 'NONE',
            \       'ctermbg': '237'
            \   },
            \   'stlLineInfo': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '#ABB2BF',
            \       'guibg': '#282c45',
            \       'cterm': 'NONE',
            \       'ctermfg': '16',
            \       'ctermbg': '195'
            \   },
            \   'stlTotal': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '#282C34',
            \       'guibg': '#ABB2BF',
            \       'cterm': 'NONE',
            \       'ctermfg': '16',
            \       'ctermbg': '149'
            \   }
            \ }

noremap <silent> <LocalLeader>b :<C-U><C-R>=printf("Leaderf! bufTag %s", "--bottom --nowrap")<CR><CR>
noremap <silent> <LocalLeader>u :<C-U><C-R>=printf("Leaderf! function %s", "--bottom --nowrap")<CR><CR>
noremap <silent> <LocalLeader>f :<C-U><C-R>=printf("Leaderf! file %s", "--bottom --nowrap")<CR><CR>


"=================================================================================================================================
" Floaterm settings
"=================================================================================================================================
" let g:floaterm_keymap_toggle = '<silent><localleader>c'
let g:floaterm_keymap_toggle = '<Localleader>c'
let g:floaterm_wintype = 'normal'
let g:floaterm_height = 0.3
let g:floaterm_autoclose = 2
let g:floaterm_autohide = v:false

"=================================================================================================================================
" Coc.nvim settings
"=================================================================================================================================
" 使用Tab开启补全

if exists('g:plugs["coc.nvim"]')

let g:coc_global_extensions = ['coc-json', 'coc-java']

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

let g:coc_snippet_next = '<tab>'
inoremap <silent><expr> <TAB>
	\ pumvisible() ? coc#_select_confirm() :
	\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()

inoremap <expr> <down> pumvisible() ? "\<C-n>" : "\<down>"
inoremap <expr> <up> pumvisible() ? "\<C-p>" : "\<up>"

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

""=================================================================================================================================
" 多光标支持

nnoremap <leader>rr :CocCommand document.renameCurrentWord<CR>
nnoremap <leader>rs :CocSearch<Space>
nnoremap <leader>rw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <C-c> <Plug>(coc-cursors-position)
xmap <silent> <C-m> <Plug>(coc-cursors-range)
nmap <expr> <silent> <C-m> <SID>select_current_word()
function! s:select_current_word()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

call coc#config('suggest', {
  \ 'autoTrigger': 'none'
  \ })
call coc#config('cursors', {
  \ 'cancelKey': '<esc>',
  \ 'nextKey': '<C-n>',
  \ 'previousKey': '<C-p>'
  \ })
call coc#config('diagnostic', {
  \ 'errorSign': '•',
  \ 'warningSign': '•',
  \ 'infoSign': '•'
  \ })

""在命令行输入:CocConfig ->将下面代码添加进去后。强制开启不自动补全模式
"{
" "suggest.autoTrigger": "none",
" "cursors.cancelKey": "<esc>",
" "cursors.nextKey": "<C-n>",
" "cursors.previousKey": "<C-p>",
" "diagnostic.errorSign": "•",
" "diagnostic.warningSign": "•",
" "diagnostic.infoSign": "•"
"}

hi CocCursorRange term=reverse cterm=bold ctermfg=238 ctermbg=226 gui=bold guifg=#FFFFFF guibg=#E06c75
hi CocHoverRange term=reverse cterm=bold ctermfg=238 ctermbg=226 gui=bold guifg=#FFFFFF guibg=#E06c75
hi CocErrorSign term=reverse cterm=bold ctermfg=238 ctermbg=226 gui=bold guifg=#e06c75 

""" 使用回车强制去确认上屏
"" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
""    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

endif

"=================================================================================================================================
"Clever-F Settings
"=================================================================================================================================
if exists('g:plugs["clever-f.vim"]')
map <CR> <Plug>(clever-f-repeat-forward)
map <BS> <Plug>(clever-f-repeat-back)
let g:clever_f_show_prompt=1       " 显示提示符
let g:clever_f_fix_key_direction=0 " 循环搜索请设置为1
let g:clever_f_smart_case=1          " 智能大小写搜索
let g:clever_f_across_no_line=1
let g:clever_f_chars_match_any_signs=";"
hi CleverFDefaultLabel cterm=bold,underline ctermfg=9 gui=bold,underline guifg=#abb2bf guibg=#e06c75
hi CleverFDefaultLabel cterm=bold,underline ctermfg=9 gui=bold,underline guifg=#abb2bf guibg=#e06c75
hi CleverFChar         cterm=bold,underline ctermfg=9 gui=bold,underline guifg=#e06c75
endif

"=================================================================================================================================
" Pangu settings
"=================================================================================================================================
" autocmd BufWritePre *.markdown,*.md,*.text,*.txt,*.wiki,*.cnx call PanGuSpacing()
