" 更新时间：2018-04-30 01:09:27

" 定义快捷键的前缀，即 <Leader>
" let mapleader=";"
let mapleader = "\<Space>"
" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC


" >>>>>>>>>>>>>>>>>>>>
" 文件类型侦测

" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" vim 自身（非插件）快捷键

" 定义快捷键到行首和行尾
nmap LB 0
nmap LE $

" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至vim
nmap <Leader>p "+p

" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
" 定义快捷键保存所有窗口内容并退出 vim
nmap <Leader>WQ :wa<CR>:q<CR>
" 不做任何保存，直接退出 vim
nmap <Leader>Q :qa!<CR>

" 设置快捷键遍历子窗口
" 依次遍历
nnoremap nw <C-W><C-W>
" 跳转至右方的窗口
nnoremap <Leader>lw <C-W>l
" 跳转至左方的窗口
nnoremap <Leader>hw <C-W>h
" 跳转至上方的子窗口
nnoremap <Leader>kw <C-W>k
" 跳转至下方的子窗口
nnoremap <Leader>jw <C-W>j

" 定义快捷键在结对符之间跳转
nmap <Leader>M %

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" 营造专注气氛

" 禁止光标闪烁
set gcr=a:block-blinkon0

" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T

" 将外部命令 wmctrl 控制窗口最大化的命令行参数封装成一个 vim 的函数
fun! ToggleFullscreen()
    call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf
" 全屏开/关快捷键
map <silent> <F11> :call ToggleFullscreen()<CR>
" 启动 vim 时自动全屏
autocmd VimEnter * call ToggleFullscreen()

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" 辅助信息

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 显示侧边栏
set signcolumn=yes

" 高亮显示当前行/列
" set cursorline
" set cursorcolumn
" 高亮显示搜索结果
set hlsearch

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase

" 关闭兼容模式
set nocompatible
" 使退格键可用
set backspace=indent,eol,start

" vim 自身命令行模式智能补全
set wildmenu

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" 缩进

" 自适应不同语言的智能缩进
filetype indent on

" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" 代码折叠

" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" 其他美化

" 设置 gvim 显示字体
set guifont=YaHei\ Consolas\ Hybrid\ 10.5

" 禁止折行
set nowrap

" 配色方案
" set background=dark
" colorscheme solarized
" colorscheme molokai
" colorscheme phd


" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" 个人的一些设置

" 设置默认编码
set encoding=utf-8
" 宽度标识
set cc=80
" 使用鼠标
" set mouse=a
" 关闭错误声音
set vb t_vb=  
" 光标从行首和行末可以跳到另一行去
set whichwrap=b,s,<,>,[,]
" 标记不必要的空白字符
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.cpp,*.cc,*.go match BadWhitespace /\s\+$/

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" vim-plug 插件设置
" vim-plug 管理的插件列表必须位于 call plug#begin() 和 call plug#end() 之间

call plug#begin('~/.vim/plugged')

" Plug 'altercation/vim-colors-solarized'
" Plug 'vim-scripts/phd'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'derekwyatt/vim-fswitch'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Yggdroot/LeaderF', {'do': './install.sh'}
Plug 'scrooloose/nerdcommenter'
Plug 'Valloric/YouCompleteMe'
Plug 'derekwyatt/vim-protodef'
Plug 'derekwyatt/vim-fswitch'
Plug 'scrooloose/nerdtree'
Plug 'gcmt/wildfire.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'w0rp/ale'
Plug 'mhinz/vim-signify'
Plug 'Shougo/echodoc.vim'
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'fatih/molokai'

call plug#end()

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" vim-airline 插件设置

" 开启256色支持后vim-go报错信息的颜色很难看
set t_Co=256
" 打开tabline功能,方便查看Buffer和切换
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" 设置切换 buffer 的快捷键
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='molokai'

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" Indent Guides 插件设置

" 随 Vim 自启动
let g:indent_guides_enable_on_vim_startup = 1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level = 2
" 色块宽度
let g:indent_guides_guide_size = 1

" 关闭自动配色，手动设置颜色
colorscheme default
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=darkgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=darkgrey

" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>ig <Plug>IndentGuidesToggle

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" vim-fswitch 插件设置

" *.cpp 和 *.h 间切换
nmap <silent> <Leader>sw :FSHere<cr>

"<<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" Gutentags 插件设置

set tags=./.tags;,.tags
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.git', '.gitignore', '.root', '.svn', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_executable = '/home/ubuntu/Program/exctags/bin/exctags'
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v']
let g:gutentags_ctags_extra_args += ['--python-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v']
let g:gutentags_ctags_extra_args += ['--golang-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" LeaderF 插件设置

let g:Lf_Ctags = "/home/ubuntu/Program/exctags/bin/exctags"
" 指定 LeaderF 使用的 Python 版本
let g:Lf_PythonVersion = 3
" 搜索文件
let g:Lf_ShortcutF = '<c-p>'
" 搜索 buffer
let g:Lf_ShortcutB = '<c-b>'
" 搜索最近打开文件列表
noremap <c-n> :LeaderfMru<cr>
noremap <c-l> :LeaderfFunction<cr>
noremap <c-b> :LeaderfBuffer<cr>
noremap <c-g> :LeaderfTag<cr>

let g:Lf_WindowHeight = 0.30
let g:Lf_ShowRelativePath = 0
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_StlSeparator = { 'left': '►', 'right': '◄', 'font': '' }
" 如果目录中包含以下文件夹之一则为根目录
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'

" 指定索引时想要忽略的文件和文件夹
let g:Lf_WildIgnore = {
    \ 'dir': ['.svn','.git','.hg'],
    \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
    \ }

" 指定是否在搜索结果中显示预览
let g:Lf_PreviewResult = {
    \ 'File': 0,
    \ 'Buffer': 0,
    \ 'Mru': 0,
    \ 'Tag': 0,
    \ 'BufTag': 1,
    \ 'Function': 1,
    \ 'Line': 0,
    \ 'Colorscheme': 0
    \ }

" 定义标准模式下的键映射
let g:Lf_NormalMap = {
    \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
    \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
    \ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
    \ "Tag":    [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
    \ "Function":    [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
    \ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
    \ }

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" YouCompleteMe 插件设置

" 基于语义的代码导航
nnoremap <leader>jc :YcmCompleter GoToDeclaration<CR>
" 只能是 #include 或已打开的文件
nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>

" 基于语义的代码补全
" YCM 补全菜单配色
" 菜单
highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
" 选中项
highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900

" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1

" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0
let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/third_party/config/.ycm_extra_conf.py'

" 开启 YCM 标签补全引擎
let g:ycm_collect_identifiers_from_tags_files=0
"" 引入 C++ 标准库 tags
"set tags+=/data/misc/software/app/vim/stdcpp.tags
"set tags+=/data/misc/software/app/vim/sys.tags

" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
inoremap <leader>; <C-x><C-o>

" 补全内容不以分割子窗口形式出现，只显示补全列表
" set completeopt-=preview

" 从第2个键入字符就开始罗列匹配项
" let g:ycm_min_num_of_chars_for_completion=2

" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0

" 是否开启语义补全
let g:ycm_seed_identifiers_with_syntax=1

" Python 补全
let g:ycm_python_binary_path = 'python3'

" 关闭函数原型预览窗口
set completeopt=menu,menuone
let g:ycm_add_preview_to_completeopt = 0
" 不显示诊断信息
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
" 从第2个键入字符就开始罗列匹配项（标签补全）
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_complete_in_strings=1
" 补全快捷键 Ctrl+Z
let g:ycm_key_invoke_completion = '<c-z>'
noremap <c-z> <NOP>
" 补全后自动关闭预览窗口
let g:ycm_autoclose_preview_window_after_completion=1

" 键入第2个字符就触发语义补全
let g:ycm_semantic_triggers =  {
    \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
    \ 'cs,lua,javascript': ['re!\w{2}'],
    \ }

" 只有属于白名单的文件类型才开启YCM
let g:ycm_filetype_whitelist = {
    \ "c": 1,
    \ "cpp": 1,
    \ "python": 1,
    \ "go": 1,
    \ }

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" vim-protodef 插件设置

" 由接口快速生成实现框架
" 设置 pullproto.pl 脚本路径
let g:protodefprotogetter='~/.vim/plugged/vim-protodef/pullproto.pl'
" 成员函数的实现顺序与声明顺序一致
let g:disable_protodef_sorting=1

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" NERDTree 插件设置

" 使用 NERDTree 插件查看工程文件
" noremap <F2> :NERDTreeToggle<CR>
nmap <Leader>fl :NERDTreeToggle<CR>
" 设置 NERDTree 子窗口宽度
let NERDTreeWinSize=25
" 设置 NERDTree 子窗口位置
let NERDTreeWinPos="left"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" wildfire.vim 插件设置

" 一次空格选中最近一层结对符内的文本，两次则选中近两层内的文本，三次三层，依此类推
map <SPACE> <Plug>(wildfire-fuel)
" Shift + Space 取消选中
vmap <S-SPACE> <Plug>(wildfire-water)
" 适用于哪些结对符
let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "i>", "ip"]

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" asyncrun.vim 插件设置

" 自动打开 quickfix window，高度为 6
let g:asyncrun_open = 6
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" F4：使用 cmake 生成 Makefile 
" F5：单文件：运行
" F6：项目：测试
" F7：项目：编译
" F8：项目：运行
" F9：单文件：编译
" F10：打开/关闭底部的 quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
nnoremap <silent> <F9> :AsyncRun clang++ -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']
nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>
nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>
nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>
nnoremap <silent> <F4> :AsyncRun -cwd=<root> cmake . <cr>

" <<<<<<<<<<<<<<<<<<<<


" Deleted by LiuJingchao on 2018-05-02 17:03
" ALE 插件貌似和 vim-go 插件冲突
" >>>>>>>>>>>>>>>>>>>>
" Asynchronous Lint Engine 插件设置
   
" 保持侧边栏可见
let g:ale_sign_column_always = 1
" 设置错误和警告标识符
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
" 设置可以运行的 linter
let g:ale_linters_explicit = 1
let g:ale_linters = {
    \ 'javascript': ['eslint'],
    \ 'c': ['clang', 'gcc'],
    \ 'cpp': ['clang++', 'g++', 'clang', 'gcc'],
    \ 'go': ['golint'],
    \ 'python': ['autopep8'],
    \ }
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
" 如果 normal 模式下文字改变以及离开 insert 模式的时候运行 linter
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
" 让 airline 状态栏显示错误信息
let g:airline#extensions#ale#enabled = 1

" let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
" let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
" let g:ale_c_cppcheck_options = ''
" let g:ale_cpp_cppcheck_options = ''
let g:ale_c_clang_executable = 'clang'
let g:ale_c_clang_options = '-std=c99 -Wall -O2'
let g:ale_cpp_clang_executable = 'clang++'
let g:ale_cpp_clang_options = '-std=c++14 -Wall -O2'

let g:ale_sign_error = "\ue009\ue009"
" ALEError
hi! clear SpellBad
" ALEWarning 
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad gui=undercurl guisp=red ctermbg=2
hi! SpellCap gui=undercurl guisp=blue ctermbg=3
hi! SpellRare gui=undercurl guisp=magenta ctermbg=blue
   
" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" echodoc.vim 插件设置

let g:echodoc#enable_at_startup = 1
set noshowmode

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" vim-go 插件设置

let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
" automatically run golint on :w
set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim
autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_structs = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

" vim-go 美化
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

" <<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>
" <<<<<<<<<<<<<<<<<<<<
