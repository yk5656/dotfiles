"------------------------------------------------------------------------------
"
" 基本設定
"
"------------------------------------------------------------------------------

" vi互換をオフにして、vimのデフォルトの設定にする
set nocompatible

" 文字コードをUTF-8にする
set encoding=utf-8

" <Leader>キーを「,」にする
let mapleader = ","


"
" カラー
"

" シンタックスのカラー表示を有効にする
syntax on

" カラースキーマ
colorscheme molokai
"colorscheme jellybeans
"colorscheme hybrid

" ステータスラインのカラーの設定（挿入モード時に色を変える）
"highlig statuslin term=NONE cterm=NONE guifg=black ctermfg=black ctermbg=6
highlight StatusLine guifg=#2E4340 guibg=#ccdc90 gui=none cterm=none ctermfg=black ctermbg=6
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340 gui=none cterm=none ctermfg=black ctermbg=3
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90 gui=none cterm=none ctermfg=black ctermbg=6
augroup END


"
" ファイル
"

" 他でファイルが更新された場合に自動で再読み込みする
set autoread

" スワップファイルを作成しない
set noswapfile

" バックアップファイルを作成しない
set nobackup


"
" 外観
"

" タイトルを表示する
set title

" 行番号を表示する
set number

" ステータス行を常に表示する
set laststatus=2

" カーソルが何行目の何列目に置かれているかを表示する
"set ruler			" 設定しなくても表示されてる？

" 入力中のコマンドを画面の右下に表示する
set showcmd

" コマンドラインの高さを設定する
set cmdheight=2

" コマンドラインの補完を有効にする
set wildmenu

" ステータスラインの表示内容
set statusline=%<[%n]%F%=\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ %l,%c\ %P 


"
" テキスト表示
"
" 長い行は折り返して表示する
set wrap

" 括弧入力時に対応する括弧に表示が移らないようにする
set noshowmatch

" タブ文字「>」、行末「$」、行末の余分なスペース「_」、で表示する
set list
set listchars=tab:>\ ,eol:$,trail:_

" 文字入力中に勝手に改行しないようにする
set textwidth=0
" Kaoriya版vimの場合、デフォルトの設定ファイルvimrc_example.vimを読み込む際に
" textwidthが上書きされるので、その対策
autocmd FileType text setlocal textwidth=0


"
" インデント
"

" タブをスペースに変換しない
set noexpandtab

" タブの文字数
set tabstop=4
set shiftwidth=4
set softtabstop=4

" 自動的にインデントする
set autoindent


"
" 検索/移動
"

" 最後まで検索した後、先頭から再度検索しない
set nowrapscan

" 小文字の場合は大文字小文字区別しないが、
set ignorecase
" 大文字が含まれる場合は大文字小文字区別する
set smartcase

" 画面の上下に数行余白を残してスクロールする
set scrolloff=5

" カーソルが行頭・行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

" 検索やコマンドの履歴の保存数
set history=100


"
" その他
"

" クリップボード連携
"  unnamedではなくunnamedplusじゃないとUbuntuでクリップボードに保存されなかっ
set clipboard=unnamedplus

" テキスト挿入中の自動折り返しを日本語に対応させる
"set formatoptions+=mM

" BSでインデントや改行を削除できるようにする
"set backspace=indent,eol,start

" Ubuntuで全角記号がうまく表示されない問題への対策
set ambiwidth=double



" キーマップ
"
"  コマンド       ノーマルモード 挿入モード コマンドラインモード ビジュアルモード
"  map/noremap           @            -              -                  @
"  nmap/nnoremap         @            -              -                  -
"  imap/inoremap         -            @              -                  -
"  cmap/cnoremap         -            -              @                  -
"  vmap/vnoremap         -            -              -                  @
"  map!/noremap!         -            @              @                  -
"

" 表示行単位で行移動する
noremap j gj
noremap k gk

" ctrl+j/k/h/lでウィンドウを移動
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

" Escの2回押しでハイライト消去
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR>:ccl<CR><Esc>

" Ctrl+nで次のバッファを表示、Ctrl+Pで前のバッファを表示
nnoremap <silent> <C-p> :bprevious<CR>
nnoremap <silent> <C-n> :bnext<CR>

" Ctrl+jでESC
inoremap <silent> <C-j> <esc>

" コマンドラインをEmacs風にする
cnoremap <C-a> <Home>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>

" .vimrc/.gvimrcの編集/反映
nnoremap <silent> <leader>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <leader>eg :<C-u>edit $MYGVIMRC<CR>
"nnoremap <silent> <leader>eV :<C-u>edit ~/.vimrc.local<CR>
if has('gui_running')
nnoremap <silent> <leader>er :<C-u>source $MYVIMRC<CR>:<C-u>source $MYGVIMRC<CR>
else
nnoremap <silent> <leader>er :<C-u>source $MYVIMRC<CR>
endif


"
" ファイルタイプ
"
"filetype plugin on
"filetype indent on
autocmd FileType ruby setlocal sw=2 sts=2 ts=2 et
"autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
"autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
"autocmd FileType html       setlocal sw=2 sts=2 ts=2 et



"------------------------------------------------------------------------------
"
" プラグイン
"
"------------------------------------------------------------------------------
filetype off

" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]> 

" ctags生成
nnoremap <leader>c :!ctags -R<CR>

" プラグイン関連
nnoremap :q<CR> :Bquit<CR>
nnoremap <silent> <leader>t :NERDTreeToggle<CR>
nnoremap <silent> <leader>f :NERDTreeFind<CR>
nnoremap <silent> <leader>l :TlistToggle<CR>
nnoremap <silent> <leader>L :TlistOpen<CR>
nnoremap <silent> <leader>p :CtrlP<CR>
nnoremap <silent> <leader>@ :CtrlPBufTag<CR>
nnoremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <leader>g :Rgrep<CR>
"nnoremap <silent> <leader>h :<C-u>help<Space><C-r><C-w><Enter>	" カーソル下のキーワードをヘルプで引く

" vim-over
nnoremap <silent> <Leader>r :OverCommandLine<CR>%s/
vnoremap <silent> <Leader>r :OverCommandLine<CR>s/

" ファンクションキー割り当て
" ヘルプ
"nnoremap <F1> K
" 再帰Grep
"nnoremap <silent> <F3> :Rgrep<CR>
" 前回の検索結果
"nnoremap <silent> <F4> :ToggleQFixWin<CR>
"map <F6> <ESC>:TMiniBufExplorer<CR>		" タブ表示切替
"nnoremap <F8> :source %<CR>				" vimrcを再読み込み
"map <F11> <ESC>:set nowrap<CR>				" 折り返しをやめる
"nnoremap <silent> <F12> :TlistToggle<CR>	" タグリスト

"--------------------------------------
" Vundle
"--------------------------------------
if has("win32") || has("win64")
  set rtp+=~/vimfiles/vundle/
  call vundle#rc('~/vimfiles/bundle/')
else
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()
endif

Bundle 'yk5656/vim-bquit'
Bundle 'gmarik/vundle'
Bundle 'The-NERD-tree'
Bundle 'taglist.vim'
Bundle 'buftabs'
Bundle 'kien/ctrlp.vim'

Bundle 'grep.vim'
"Bundle 'fuenor/qfixgrep'
"Bundle 'QuickBuf'
"Bundle 'terryma/vim-multiple-cursors'
"Bundle 'rking/ag.vim'

Bundle 'osyo-manga/vim-over'

filetype plugin indent on


"--------------------------------------
" NERDTree
"--------------------------------------
"let NERDTreeShowHidden		= 1
let NERDTreeShowBookmarks	= 1			" ツリーにブックマークも表示
let NERDTreeChDirMode		= 2			" ブックマーク選択時、カレントディレクトリも変更
let NERDTreeMapActivateNode	='<space>'	" スペースで開閉できるようにする
let NERDTreeIgnore=['\.$', '\.\.$']
"let NERDTreeIgnore = ['\.cvs$']
" 最後に残ったウィンドウがNERDTREEのみのときはvimを閉じる
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


"--------------------------------------
" taglist
"--------------------------------------
let Tlist_Use_Right_Window	= 1		" 右側に表示
let Tlist_Show_One_File		= 1		" 常に一つしか表示しない
let g:tlist_php_settings = 'php;f:function'
"let Tlist_Ctags_Cmd			= '/usr/local/bin/ctags'


"--------------------------------------
" buftabs
"--------------------------------------
let g:buftabs_only_basename=1		" バッファタブにパスを省略してファイル名のみ表示する
let g:buftabs_in_statusline=1		" バッファタブをステータスライン内に表示する
let g:buftabs_active_highlight_group="Visual"	" 現在のバッファをハイライト
set laststatus=2	" ステータスラインを常に表示
" ステータスライン
"set statusline=%=\ [%{(&fenc!=''?&fenc:&enc)}/%{&ff}]\[%Y]\[%04l,%04v][%p%%]


"--------------------------------------
" CtrlP
"--------------------------------------
let g:ctrlp_map						= ''
let g:ctrlp_working_path_mode		= 0
let g:ctrlp_by_filename				= 1
let g:ctrlp_max_height				= 20
let g:ctrlp_extensions				= ['tag']
let g:ctrlp_match_window_reversed	= 0
let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
  \ 'PrtSelectMove("k")':   ['<c-p>', '<up>'],
  \ 'PrtHistory(-1)':       ['<c-j>'],
  \ 'PrtHistory(1)':        ['<c-k>'],
  \ }


"--------------------------------------
" grep
"--------------------------------------
let Grep_Default_Filelist = '*.txt *.html *.css *.js *.php *.ctp'
let Grep_Skip_Dirs = '.svn .git'
let Grep_Skip_Files = 'tags *.jpg *.jpeg *.png *.gif *.exe *.swf *.swp *.bak'
let Grep_Default_Options = '-i'
"let QFix_Height = 40
"let QFix_PreviewEnable = 0
""let Grep_Path = 'c:/cygwin/bin/grep.exe'
"let Grep_Find_Path = 'c:/cygwin/bin/find.exe'
"let Grep_Xargs_Path = 'c:/cygwin/bin/xargs.exe'
""let Grep_Path = 'c:/GnuWin32/bin/grep.exe'
""let Grep_Find_Path = 'c:/GnuWin32/bin/find.exe'
""let Grep_Xargs_Path = 'c:/GnuWin32/bin/xargs.exe'
""let Grep_Default_Filelist = '*.cgi, *.css, *.ctp, *.htm, *.html, *.java, *.js, *.php, *.sql, *.xml'
"let Grep_Find_Use_Xargs = 0
""let Grep_Cygwin_Find = 1 
"let Grep_Shell_Quote_Char = '"'
"let Grep_Cygwin_Find = 1



"===========================================================================
"
" その他
"
"===========================================================================

" 独自シンタックスの設定
"au BufNewFile,BufRead *.txt setf mine	"setfだと反映されない
au BufNewFile,BufRead *.txt set filetype=mine


" ローカルのvimrcを読み込む
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

