if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'skywind3000/asyncrun.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'itchyny/lightline.vim' "状态栏插件
Plug 'vim-airline/vim-airline' "状态栏
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim' "排版插件
Plug 'tpope/vim-fugitive' "git插件
Plug 'terryma/vim-expand-region' "文本快速选定
Plug 'vim-scripts/mru.vim' "最近使用过的文件插件
Plug 'scrooloose/nerdtree' "文件浏览器
Plug 'w0rp/ale' "语法检测
Plug 'vim-scripts/bufexplorer.zip' "buff插件
Plug 'universal-ctags/ctags' "跳转
Plug 'ludovicchabant/vim-gutentags' "跳转
Plug 'mhinz/vim-signify' "实时修改状态
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' } "文件查找
"vim 补全{
Plug 'tomtom/tlib_vim' 
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe'
"vim 补全}
Plug 'amix/open_file_under_cursor.vim' "gf 跳转
Plug 'terryma/vim-multiple-cursors' "多光标操作
Plug 'michaeljsmith/vim-indent-object' "缩进
Plug 'tpope/vim-commentary' "注释
"vim配色方案{
Plug 'morhetz/gruvbox' 
Plug 'flazz/vim-colorschemes'
"vim配色方案}
Plug 'zxqfl/tabnine-vim'
call plug#end()

set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set enc=utf8
set fencs=utf8,gbk,gb2312,gb18030
set ts=4
set noundofile
set nobackup
set noswapfile
map <C-e> :NERDTreeToggle<CR>
filetype plugin on
set number
set relativenumber

" colorscheme gruvbox
set background=dark    " Setting dark mode
let g:markdown_fenced_languages = ['html', 'lua', 'python', 'bash=sh']
" autocmd vimenter * NERDTree
let g:multi_cursor_select_all_word_key = '<C-m>'
"开启tabline
let g:airline#extensions#tabline#enabled = 1
"tabline中当前buffer两端的分隔字符
let g:airline#extensions#tabline#left_sep = '>'
"tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#left_alt_sep = '>'
"tabline中buffer显示编号
"let g:airline#extensions#tabline#buffer_nr_show = 1  
" AirlineTheme {theme-name}
function! AccentDemo()
  let keys = ['a','b','c','d','e','f','g','h']
  for k in keys
  		call airline#parts#define_text(k, k)
  endfor
  call airline#parts#define_accent('a', 'red')
  call airline#parts#define_accent('b', 'green')
  call airline#parts#define_accent('c', 'blue')
  call airline#parts#define_accent('d', 'yellow')
  call airline#parts#define_accent('e', 'orange')
  call airline#parts#define_accent('f', 'purple')
  call airline#parts#define_accent('g', 'bold')
  call airline#parts#define_accent('h', 'italic')
  let g:airline_section_a = airline#section#create(keys)
endfunction
autocmd VimEnter * call AccentDemo()
let g:airline_section_x = 'liujun_m@cyou-inc.com'

" 【ludovicchabant/vim-gutentags】
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 " 
let g:gutentags_project_root = ['.root','.svn','.git']

" 所生成的数据文件的名称 " 
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 " 
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数 " 
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args = ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--cc-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建 " 
if !isdirectory(s:vim_tags)  
  silent! call mkdir(s:vim_tags, 'p')  
endif

" 【universal-ctags/ctags】
" Ctrl + ] 跳转到对应的定义位置 
" Ctrl + o 回退到原来的位置
" Ctrl - W + ] 用新窗口打开并查看光标下符号的定义
" Ctrl -W } 使用 preview 窗口预览光标下符号的定义

let g:asyncrun_rootmarks = ['.svn', '.git', '.root']
let g:asyncrun_open = 6
map <C-c> :cclose <cr>
let mapleader=";"
map <Leader>r :AsyncRun -cwd=<root> ./Run.sh start_game <cr>
map <Leader>s :AsyncRun -cwd=<root> ./Run.sh stop_game <cr>
map <Leader>check :AsyncRun -cwd=<root> make check <cr>

map <Leader>ff :Leaderf file <cr>
map <Leader>fu :Leaderf function <cr>

" search word under cursor, the pattern is treated as regex, and enter normal mode directly
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search word under cursor, the pattern is treated as regex,
" append the result to previous search results.
noremap <C-G> :<C-U><C-R>=printf("Leaderf! rg --append -e %s ", expand("<cword>"))<CR>
" search word under cursor literally only in current buffer
noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg -F --current-buffer -e %s ", expand("<cword>"))<CR>
" search visually selected text literally, don't quit LeaderF after accepting an entry
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F --stayOpen -e %s ", leaderf#Rg#visual())<CR>
" recall last search. If the result window is closed, reopen it.
noremap go :<C-U>Leaderf! rg --stayOpen --recall<CR>



map <Leader>c :cclose <cr>
" map <Leader>o :copen <cr>




"set runtimepath+=~/.vim_runtime
"
"source ~/.vim_runtime/vimrcs/basic.vim
"source ~/.vim_runtime/vimrcs/filetypes.vim
"source ~/.vim_runtime/vimrcs/plugins_config.vim
"source ~/.vim_runtime/vimrcs/extended.vim
"
"try
"source ~/.vim_runtime/my_configs.vim
"catch
"endtry
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
