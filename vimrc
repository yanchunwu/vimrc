set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/Conque-GDB'
Plugin 'SuperTab'
Plugin 'a.vim'
Plugin 'delimitMate.vim'
Plugin 'vim-flake8'
" Plugin 'scrooloose/syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'w0rp/ale'
Plugin 'Vimjas/vim-python-pep8-indent'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'file:///home/yanchun/.vim/roslaunch.vim'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set hlsearch
set expandtab       " turns tabs into spaces
set tabstop=4       " number of spaces per tab
set autoindent
set smartindent
set shiftwidth=4    " number of spaces per shift

set statusline=%f
set statusline+=%=    " Switch to the right side
set statusline+=%c    " column
set statusline+=,     " Separator
set statusline+=%l    " Current line
set statusline+=/     " Separator
set statusline+=%L    " Total lines
set laststatus=2
set tw=80

" set clipboard=exclude:.*
set clipboard=unnamedplus

" set tags
" set tags+=~/vxl/vxl.1.17/tags

" solarized color
syntax enable
if has('gui_running')
  set background=light
else
  set background=dark
endif
" colorscheme solarized

" txx as c++ file type
autocmd BufNewFile,BufReadPost *.txx,*.cu set filetype=cpp

function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename . " "
  execute "normal! Go#endif /* " . gatename . " */"
  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

au FileType mail let b:delimitMate_autoclose = 0 

" " syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" " f compiler flag
let g:syntastic_cpp_compiler = "g++"
" let g:syntastic_cpp_compiler = "clang++"
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"
let g:syntastic_cpp_config_file = '.vim/my_custom_include_file_for_syntastic'

"ale global variables
let g:ale_cpp_gcc_options='-std=c++11 -Wall -I/usr/local/include/pcl-1.8 -I/usr/include/eigen3 -I/usr/include -I/usr/include/ni -I/usr/include/openni2 -I/usr/include/vtk-5.8'
" let g:ale_linters = {'python': ['flake8', 'mypy', 'pylint', 'pyflakes']}
" let g:ale_linters = {'python': ['flake8'], 'cpp': ['cppcheck', 'clangtidy'] }
let g:ale_linters = {'python': ['pylint'], 'cpp': ['cppcheck'] }

" option for Vimjas/vim-python-pep8-indent
" closing brackets line up with the items
" let g:python_pep8_indent_hang_closing = 1
"

" YouCompleteMe Option
" let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" matchit
" source ~/.vim/bundle/matchit.zip/plugin/matchit.vim
"
autocmd BufRead,BufNewFile *.launch setfiletype roslaunch
