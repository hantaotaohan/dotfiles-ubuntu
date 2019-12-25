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
"set background=dark

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

"-----------------------------------------------------------------o--------------------------------------------------------------o
"                                                                                                                                
"                                                                ESC                                                          
"                                                                                                                                
"-----------------------------------------------------------------o--------------------------------------------------------------o
" inoremap jj <Esc>
" vnoremap jj <Esc> 

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
call plug#begin('$HOME/.vim/plugged')
Plug 'joshdick/onedark.vim'                                              " 主题文件
Plug 'vim-airline/vim-airline'                                           " 状态栏
Plug 'vim-airline/vim-airline-themes'                                    " 状态栏主题
Plug 'tpope/vim-fugitive'                                                " git插件
Plug 'scrooloose/nerdtree'                                               " 文件树插件
Plug 'godlygeek/tabular'                                                 " 文本对齐插件
Plug 'dhruvasagar/vim-table-mode'                                        " 表格模式
Plug 'majutsushi/tagbar'                                                 " Tag浏览
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }        " 为系统安装fzf工具
Plug 'junegunn/fzf.vim'                                                  " 为vim安装fzf插件
Plug 'skywind3000/asyncrun.vim'                                          " 配合调测python插件
Plug 'christoomey/vim-tmux-navigator'                                    " 同步vim与tmux快捷键
Plug 'Yggdroot/indentLine'                                               " 缩进线显示插件
Plug 'scrooloose/nerdcommenter'                                          " 快速注释插件
Plug 'mhinz/vim-startify'                                                " 定制vim开始页面
Plug 'SirVer/ultisnips'                                                  " 代码片段管理器
Plug 'honza/vim-snippets'                                                " 代码片段仓库
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() } }" MarkdownPreview插件
"Plug 'terryma/vim-multiple-cursors'                                     " 多光标插件
"Plug 'edkolev/tmuxline.vim'                                             " Vim同步tmux配色
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
set clipboard=unnamed                                                    " 共享剪贴板
set nowrap                                                               " 设置不自动换行
set showtabline=2                                                        " 永远显示标签页
set t_Co=256                                                             " 设置终端显示颜色
set scrolloff=5                                                          " 光标上下两侧最少保留的屏幕行数
syntax enable                                                            " 开启语法高亮
set guifont=DejaVu\ Sans\ Mono\ 10                                       " 设置字体
"set termguicolors                                                       " 终端模式 自动转换256真色彩 


"=================================================================================================================================
" Base Config 
"=================================================================================================================================
filetype on                                                              " 启用文件类型侦测
filetype plugin on                                                       " 针对不同的文件类型加载对应的插件
filetype plugin indent on                                                " 启用缩进
set fileencodings=utf-8,cp936,gb18030,big5,latin1                        " 探测即将打开的文件的字符编码
set fileencoding=utf-8                                                   " 打开文件的字符编码
set encoding=utf-8                                                       " Vim 内部使用的字符编码方式
set autoindent                                                           " 代码自动对齐
set smartindent                                                          " 启用智能对齐方式
set expandtab                                                            " 将Tab键转换为空格
set tabstop=4                                                            " 设置Tab键的宽度，可以更改，如：宽度为2
set shiftwidth=4                                                         " 换行时自动缩进宽度，可更改（宽度同tabstop）
set smarttab                                                             " 指定按一次backspace就删除shiftwidth宽度
set helplang=cn                                                          " 双字宽
set showmatch                                                            " 匹配模式,括号匹配
set nocompatible                                                         " 去掉有关vi一致性模式
set backspace=indent,eol,start                                           " 设置退格键的工作方式
set hlsearch                                                             " 高亮搜索的关键字
set pythondll=                                                           " python3.6支持
set writebackup                                                          " 保存文件前建立备份，保存成功后删除该备份
set nobackup                                                             " 设置无备份文件
set undofile                                                             " 开启撤销功能
set undodir=~/.vim/                                                      " 开启撤销功能的目录
set autoread                                                             " 当文件在外部被修改，自动更新该文件
set ignorecase                                                           " 搜索模式里忽略大小写
set smartcase                                                            " 如果搜索模式包含大写字符，不使用 'ignorecase' 选项
set autochdir                                                            " 自动切换目录 
set noswapfile                                                           " 设置无临时文件
set noshowmode                                                           " 任务栏不显示状态
set ambiwidth=single                                                     " 设置为双字宽显示默认值double
set hidden                                                               " 针对buffer不保存即可切换
set timeoutlen=1000 ttimeoutlen=0                                        " 取消延迟设置
" set timeoutlen=0                                                       " 取消延迟
" set backupdir=/etc/vim/.vim/                                           " 备份文件目录  
" set directory=/etc/vim/.vim/                                           " 交换文件目录  
" set vb t_vb=                                                           " 关闭提示音
" set noincsearch                                                        " 在输入要搜索的文字时，取消实时匹配


"=================================================================================================================================
" 折叠设置 
"=================================================================================================================================
set foldmethod=manual                                                    " 启用手动折叠zf
set viewdir=~/.vim/                                                      " view视图文件目录设定
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>         " 空格打开关闭折叠视图
vnoremap <Space> zf                                                      " 空格打开关闭折叠视图
"---------------------------------------------------------------------------------------------------------------------------------
augroup AutoSaveFolds
autocmd!
au BufWinLeave .* mkview                                                 " 关闭时自动保存折叠视图
au BufWinEnter .* silent loadview                                        " 打开时自动读取折叠视图
augroup END


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
let g:airline#extensions#tabline#buffer_nr_show = 1                      " tabline中buffer显示编号
let g:airline#extensions#tabline#fnamemod = ':t'                         " 只显示文件名称
let g:airline_powerline_fonts= 1                                         " 使用powerline打过补丁的字体
let g:airline#extensions#whitespace#enabled = 0                          " 取消计数
let g:airline#extensions#tabline#buffers_label = 'Buffers'               " airline右上角定制
let g:airline#extensions#wordcount#enabled = 1                           " 开启字数统计
let g:airline#extensions#wordcount#filetypes = ['all']                   " 开启字数统计文件类型
let g:airline#extensions#wordcount#formatter#default#fmt = '%s words'    " 自定义字数统计格式
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
endif


"=================================================================================================================================
" NERDTree 插件配置
"=================================================================================================================================
nmap <F8> :NERDTreeToggle<CR>                                         " F8开启关闭NERDTree
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
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 1

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 1

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 1

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
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

" use a custom markdown style must be absolute path
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = '8888'

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" MarkdownPreviewToggle
nmap <Leader>] <Plug>MarkdownPreviewToggle


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
noremap <F9> :TagbarToggle<CR>                                           " F9打开关闭Tagbar
let g:tagbar_autofocus = 1                                               " 焦点自动聚焦到Tagbar


"=================================================================================================================================
" Markdown2-Ctags
"=================================================================================================================================
" 让Tagbar支持markdown格式的Tags
"---------------------------------------------------------------------------------------------------------------------------------
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '$HOME/.vim/markdown2ctags.py',
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


"=================================================================================================================================
" FZF.vim 
"=================================================================================================================================
nnoremap <silent> <Leader>f :Files /<CR>
nnoremap <silent> <Leader>ff :Lines<CR>


"=================================================================================================================================
" asyncru
"=================================================================================================================================
noremap <F7> :call asyncrun#quickfix_toggle(6)<cr>
inoremap <F7> <esc> :call asyncrun#quickfix_toggle(6)<cr>


"=================================================================================================================================
" indentLine
"=================================================================================================================================
let g:indentLine_enabled = 0
noremap <F12> :IndentLinesToggle<CR>
inoremap <F12> <esc> :IndentLinesToggle<CR>


"=================================================================================================================================
" vim-startify
"=================================================================================================================================
let g:startify_change_to_vcs_root = 1
let g:startify_files_number = 6

let g:startify_list_order = [
    \ ['   Recent files in this directory:'],
    \ 'dir',
    \ ['   Recent files:'],
    \ 'files',
    \ ['   Bookmarks:'],
    \ 'bookmarks',
    \ ]

let g:startify_skiplist = [
    \ 'COMMIT_EDITMSG',
    \ ]

let g:startify_bookmarks = [
    \ { 'v': '$HOME/.vimrc' },
    \ ]

let g:startify_custom_footer = [
    \ '    +------------------------------+',
    \ '    |     Keep an open mind!       |',
    \ '    +----------------+-------------+',
    \]


"-----------------------------------------------------------------o--------------------------------------------------------------o
"                                                                                                                                
"                                                             快捷键设置                                                         
"                                                                                                                                
"-----------------------------------------------------------------o--------------------------------------------------------------o


"=================================================================================================================================
" Leader(\)+ 123....  切换Buffers快捷键设置
"=================================================================================================================================
noremap <Leader>a :badd<Space>
noremap <leader>d :bdelete<Space>
noremap <silent><leader>1 :b1<cr>
noremap <silent><leader>2 :b2<cr>
noremap <silent><leader>3 :b3<cr>
noremap <silent><leader>4 :b4<cr>
noremap <silent><leader>5 :b5<cr>
noremap <silent><leader>6 :b6<cr>
noremap <silent><leader>7 :b7<cr>
noremap <silent><leader>8 :b8<cr>
noremap <silent><leader>9 :b9<cr>
noremap <silent><leader>0 :b10<cr>
noremap <silent><leader><tab> :bnext<CR>
inoremap <silent><leader><tab> <ESC>:bnext<CR>


"=================================================================================================================================
" Leader(\)+ 123....  切换Tabs快捷键设置 
"=================================================================================================================================
" noremap <silent><leader>n :tabnew<cr>
" noremap <silent><leader>c :tabclose<cr>
" noremap <silent><leader>1 :tabn 1<cr>
" noremap <silent><leader>2 :tabn 2<cr>
" noremap <silent><leader>3 :tabn 3<cr>
" noremap <silent><leader>4 :tabn 4<cr>
" noremap <silent><leader>5 :tabn 5<cr>
" noremap <silent><leader>6 :tabn 6<cr>
" noremap <silent><leader>7 :tabn 7<cr>
" noremap <silent><leader>8 :tabn 8<cr>
" noremap <silent><leader>9 :tabn 9<cr>
" noremap <silent><leader>0 :tabn 10<cr>
" noremap <silent><leader><tab> :tabnext<CR>
" inoremap <silent><leader><tab> <ESC>:tabnext<CR>


"================================================================================================================================= 
" Ctrl + n 切换buff快捷键 
"=================================================================================================================================
" noremap <c-e> :bp!<CR>
" inoremap <c-e> <esc> :bp!<CR>


"=================================================================================================================================
" Ctrl + h j k l 切换窗口快捷键设置  
"=================================================================================================================================
" 设置Alt快捷方式为 进入编辑模式后 ctrl+v 再按 alt+某键即可
"=================================================================================================================================
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
inoremap <c-h> <esc><c-w>h
inoremap <c-l> <esc><c-w>l
inoremap <c-j> <esc><c-w>j
inoremap <c-k> <esc><c-w>k


"================================================================================================================================= 
" 快速移动光标快捷键 
"=================================================================================================================================
" 普通模式下:Shift+HJKL快速移动
" nnoremap K <Esc>5<up>
" nnoremap J <Esc>5<down>
" nnoremap H <Esc>0
" nnoremap L <Esc>$

" 编辑模式下:Alt+Shift+hjkl加速移动
" inoremap <C-H> <ESC>I
" inoremap <C-J> <down><down><down><down><down>
" inoremap <C-K> <up><up><up><up><up>
" inoremap <C-L> <ESC>A

" 可视化模式下:Shift+HJKL快速移动
" vnoremap K 5<up>
" vnoremap J 5<down>
" vnoremap H 0
" vnoremap L $


"=================================================================================================================================
" Shift + - = , . 调整窗口高低宽窄快捷键 
"=================================================================================================================================
noremap <silent><leader>j <C-W>:resize           +2<CR>
noremap <silent><leader>k <C-W>:resize           -2<CR>
noremap <silent><leader>h <C-W>:vertical resize  +4<CR>
noremap <silent><leader>l <C-W>:vertical resize  -4<CR>


"=================================================================================================================================
" Ctrl + n 开关显示绝对/相对行号显示
" 设定相对行号和绝对行号显示问题 编辑模式=绝对行号 普通模式=相对行号 Ctrl+n 切换
" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
"=================================================================================================================================
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
function! NumberToggle()
if(&relativenumber == 1)
set norelativenumber number
else
set relativenumber
endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>


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
nnoremap <F3> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>


"=================================================================================================================================
" F4 粘贴模式开关
"=================================================================================================================================
set pastetoggle=<F4>                                                     " 设置粘贴模式 <F4>切换


"=================================================================================================================================
" Quit Term Alt+Q 
"=================================================================================================================================
tnoremap q <c-\><c-n>


"================================================================================================================================= 
" 非root权限保存快捷命令 命令模式下输入:W
"=================================================================================================================================
command W w !sudo tee % > /dev/null


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
nnoremap <F5> :call CompileRunGcc1()<cr>
func! CompileRunGcc1()
    exec "w"
    if &filetype == 'python'
        if search("@profile")
            exec "AsyncRun kernprof -l -v %"
            exec "copen"
            exec "wincmd p"
        elseif search("set_trace()")
            exec "!python3 %"
        else
            exec "AsyncRun -raw python3 %"
            exec "copen"
            exec "wincmd p"
        endif
    endif
endfunc
"=================================================================================================================================
map <F6> :call CompileRunGcc2()<CR>
func! CompileRunGcc2()
    exec "w"
    if &filetype == 'python'
        exec "!clear"
        exec "!time python3 %"
    elseif &filetype == 'sh'
        :!time bash %
    endif
endfunc


"=================================================================================================================================
" 自动切换目录为当前编辑文件所在目录
"=================================================================================================================================
au BufRead,BufNewFile,BufEnter * cd %:p:h
