"===========================================================================
"
" オプション
"
"===========================================================================
syntax on
let mapleader = ","		" <Leader>キーを「,」に変更
set nocompatible	" Vi互換をオフ

" ファイル
set encoding=utf-8	" デフォルトの文字コードをUTF-8にする
set autoread		" 他で書き換えられたら自動で読み直す
set nobackup		" バックアップ取らない
set noswapfile		" スワップファイル作らない

" 外観
set title			" タイトルを表示
set number			" 行番号を表示
set laststatus=2	" 常にステータス行を表示 (詳細は:he laststatus)
set ruler			" ルーラーを表示

" 検索/移動
set nowrapscan		" 検索をファイルの先頭へループしない
set ignorecase		" 小文字の検索で大文字も見つかるようにする
set smartcase		" 大文字を混ぜて検索した場合だけ大文字/小文字を区別する
set scrolloff=5		" スクロール時の余白確保
set whichwrap=b,s,h,l,<,>,[,]	" カーソルを行頭、行末で止まらないようにする

" テキスト表示
set wrap			" 長い行を折り返して表示 (nowrap:折り返さない)
set noshowmatch		" 括弧入力時に対応する括弧を表示
set list			" タブ文字、行末など不可視文字を表示する
set listchars=tab:>\ ,eol:$,trail:_		"不可視文字の表示文字列

" インデント
set tabstop=4		" ファイル内の <Tab> が対応する空白の数
set shiftwidth=4	" シフト移動幅
set autoindent		" 自動的にインデントする
set noexpandtab		" タブをスペースに展開しない

" コマンドライン
set cmdheight=2		" コマンドラインの高さ
set showcmd			" コマンドをステータス行に表示
set wildmenu		" コマンドライン補完するときに強化されたものを使う

" その他
set history=100		" コマンド・検索パターンの履歴数
set clipboard=unnamed	" クリップボードをWindowsと連携
set formatoptions+=mM	" テキスト挿入中の自動折り返しを日本語に対応させる
set backspace=indent,eol,start	" BSでインデントや改行を削除できるようにする
set statusline=%<[%n]%F%=\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ %l,%c\ %P 
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

" ボツ
"set browsedir=buffer	" ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
"set grepprg=ack\ -a
"set nohlsearch		" 検索結果をハイライトしない	" TODO:なぜか有効にならない	
"set foldlevel=1		" 折り畳みレベル
"set backupdir=$HOME/vimbackup	" バックアップファイルを作るディレクトリ
"set directory=$HOME/vimbackup	" スワップファイル用のディレクトリ
"set incsearch		" インクリメンタルサーチを行う
"set listchars=tab:>\ ,eol:$,trail:_,extends:\	" タブと改行の表示文字列
"set listchars=eol:$,tab:>\ ,extends:<	" listで表示される文字のフォーマットを指定する
"set nobackup		" バックファイルを作らない
"set noswapfile		" バックファイルを作らない
"set smartindent	" 新しい行を作ったときに高度な自動インデントを行う
"set smarttab		" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
"set hidden			" 変更中のファイルでも、保存しないで他のファイルを表示
"set clipboard=unnamedplus,unnamed	" このように設定しないとYankRingが動作しない
"set wildchar=<Tab>
"set wildmode=longest:list,full
"set matchtime=3	" 対応する括弧を表示する時間(1/10秒)
"set textwidth=10	" テキストの最大幅
"set formatoptions=q	"自動で改行を入れないようにする
"set complete+=k	" 補完に辞書ファイル追加


"===========================================================================
"
" 自動コマンド
"
"===========================================================================

"ウィンドウを最大化して起動
"au GUIEnter * simalt ~x

"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

"日本語入力をリセット
"au BufNewFile,BufRead * set iminsert=0
"タブ幅をリセット
"au BufNewFile,BufRead * set tabstop=4 shiftwidth=4

".txtファイルで自動的に日本語入力ON
"au BufNewFile,BufRead *.txt set iminsert=2
".rhtmlと.rbでタブ幅を変更
"au BufNewFile,BufRead *.rhtml   set nowrap tabstop=2 shiftwidth=2
"au BufNewFile,BufRead *.rb  set nowrap tabstop=2 shiftwidth=2

"全角スペースを視覚化
"highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
"au BufNewFile,BufRead * match ZenkakuSpace /　/



"===========================================================================
"
" キーマップ
"
"===========================================================================
" コマンド       ノーマルモード 挿入モード コマンドラインモード ビジュアルモード
" map/noremap           @            -              -                  @
" nmap/nnoremap         @            -              -                  -
" imap/inoremap         -            @              -                  -
" cmap/cnoremap         -            -              @                  -
" vmap/vnoremap         -            -              -                  @
" map!/noremap!         -            @              @                  -
"-------------------------------------------------------------------------------

"nnoremap <Space>. :<C-u>edit $MYVIMRC<CR>
"nnoremap <Space>s. :<C-u>source $MYVIMRC<CR>

" 表示行単位で行移動するようにする
noremap j gj
noremap k gk

" ctrl+j/k/h/lでウィンドウを移動できるようにする
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

" Ctrl+Nで次のバッファを表示、Ctrl+Pで前のバッファを表示
"map <C-N> :bnext<CR>
"map <C-P> :bprevious<CR>
"nnoremap <silent> <C-p> :bprevious<CR>
"nnoremap <silent> <C-n> :bnext<CR>

" Escの2回押しでハイライト消去
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR>:ccl<CR><Esc>

"nnoremap :q<CR> :Kwbd<CR>

"inoremap {} {}<LEFT>
"inoremap [] []<LEFT>
"inoremap () ()<LEFT>
"inoremap "" ""<LEFT>
"inoremap '' ''<LEFT>
"inoremap <> <><Left>

inoremap <silent> <C-j> <esc>

nnoremap g1 :<C-u>b1<CR>
nnoremap g2 :<C-u>b2<CR>
nnoremap g3 :<C-u>b3<CR>
nnoremap g4 :<C-u>b4<CR>
nnoremap g5 :<C-u>b5<CR>
nnoremap g6 :<C-u>b6<CR>
nnoremap g7 :<C-u>b7<CR>
nnoremap g8 :<C-u>b8<CR>
nnoremap g9 :<C-u>b9<CR>
nnoremap <silent> <leader>1  :<C-u>b1<CR>
nnoremap <silent> <leader>2  :<C-u>b2<CR>
nnoremap <silent> <leader>3  :<C-u>b3<CR>
nnoremap <silent> <leader>4  :<C-u>b4<CR>
nnoremap <silent> <leader>5  :<C-u>b5<CR>
nnoremap <silent> <leader>6  :<C-u>b6<CR>
nnoremap <silent> <leader>7  :<C-u>b7<CR>
nnoremap <silent> <leader>8  :<C-u>b8<CR>
nnoremap <silent> <leader>9  :<C-u>b9<CR>

nnoremap <silent> <leader>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <leader>eg :<C-u>edit $MYGVIMRC<CR>
nnoremap <silent> <leader>rv :<C-u>source $MYVIMRC<CR>
nnoremap <silent> <leader>rg :<C-u>source $MYGVIMRC<CR>
nnoremap <silent> <leader>bn :<c-u>bnext<cr>
nnoremap <silent> <leader>bp :<c-u>bprevious<cr>
nnoremap <silent> <leader>tf :<c-u>tabfirst<cr>
nnoremap <silent> <leader>tl :<c-u>tablast<cr>
nnoremap <silent> <leader>tn :<c-u>tabnext<cr>
nnoremap <silent> <leader>tN :<c-u>tabNext<cr>
nnoremap <silent> <leader>tp :<c-u>tabprevious<cr>
nnoremap <silent> <leader>te :<c-u>tabedit<cr>
nnoremap <silent> <leader>tc :<c-u>tabclose<cr>
nnoremap <silent> <leader>to :<c-u>tabonly<cr>
nnoremap <silent> <leader>ts :<c-u>tabs<cr>

"------------------------------------
" ファンクションキー割り当て
"------------------------------------
"nnoremap <F1> K								" ヘルプ
"nnoremap <silent> <F3> :Rgrep<CR>			" 再帰Grep
"map <F6> <ESC>:TMiniBufExplorer<CR>			" タブ表示切替
"nnoremap <F8> :source %<CR>					" vimrcを再読み込み
"map <F11> <ESC>:set nowrap<CR>				" 折り返しをやめる
nnoremap <silent> <F12> :TlistToggle<CR>	" タグリスト



"===========================================================================
"
" プラグイン
"
"===========================================================================
filetype off

if has("win32") || has("win64")
  set rtp+=~/vimfiles/vundle/
  call vundle#rc('~/vimfiles/bundle/')
elseif has('mac')
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()
else
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()
endif

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'The-NERD-tree'
Bundle 'fuenor/qfixgrep'
"Bundle 'buftabs'
Bundle 'fholgado/minibufexpl.vim'
"Bundle 'rgarver/Kwbd'
"Bundle 'Smooth-Scroll'
"Bundle 'QuickBuf'
"Bundle 'rgarver/Kwbd.vim'
Bundle 'taglist.vim'
"Bundle 'grep.vim'

filetype plugin indent on


" CtrlP
let g:ctrlp_working_path_mode = 0
let g:ctrlp_by_filename       = 1
let g:ctrlp_max_height        = 20
let g:ctrlp_extensions        = ['tag']
let g:ctrlp_match_window_reversed = 0
nnoremap <silent> <C-@> :CtrlPBufTag<CR>


" NERDTree
let NERDTreeShowHidden = 1
let NERDTreeShowBookmarks = 1	" ツリーにブックマークも表示
let NERDTreeChDirMode = 2	" ブックマーク選択時、カレントディレクトリも変更
let NERDTreeMapActivateNode='<space>'	" スペースで開閉できるようにする
nnoremap <silent> <leader>ntt :NERDTreeToggle<CR>	" NERDTreeの表示をトグル
map <F2> <ESC>:NERDTreeToggle<CR>			" ツリー表示切替
"let NERDTreeMouseMode = 2		" シングルクリックでフォルダを展開する
"let NERDTreeIgnore = ['\.cvs$']
"nnoremap <silent> <leader>nt  :NERDTree <C-R>=expand("%:p:h")<CR><CR>


" buftabs
"let g:buftabs_only_basename=1	" ファイル名のみ表示
"let g:buftabs_in_statusline=1	" バッファタブをステータスライン内に表示する
"let g:buftabs_active_highlight_group="Visual"	" 現在のバッファをハイライト
"let g:buftabs_marker_modified = "+"


" MiniBufExpl
:let g:miniBufExplMapWindowNavVim = 1
:let g:miniBufExplMapWindowNavArrows = 1
:let g:miniBufExplMapCTabSwitchBuffs = 1


" taglist
let Tlist_Use_Right_Window = 1	" 右側に表示
let Tlist_Show_One_File = 1		" 常に一つしか表示しない
let Tlist_Ctags_Cmd='/usr/bin/ctags'


"---------------------------------------------------------------------------
" grep
"---------------------------------------------------------------------------
""let Grep_Path = 'c:/cygwin/bin/grep.exe'
"let Grep_Find_Path = 'c:/cygwin/bin/find.exe'
"let Grep_Xargs_Path = 'c:/cygwin/bin/xargs.exe'
"
""let Grep_Path = 'c:/GnuWin32/bin/grep.exe'
""let Grep_Find_Path = 'c:/GnuWin32/bin/find.exe'
""let Grep_Xargs_Path = 'c:/GnuWin32/bin/xargs.exe'
""let Grep_Default_Filelist = '*.cgi, *.css, *.ctp, *.htm, *.html, *.java, *.js, *.php, *.sql, *.xml'
"let Grep_Find_Use_Xargs = 0
""let Grep_Cygwin_Find = 1 
"let Grep_Shell_Quote_Char = '"'
"let Grep_Skip_Dirs = '.svn'
"let Grep_Skip_Files = '*.jpg *.jpeg *.png *.gif *.exe *.swf *.swp *.bak'
"let Grep_Cygwin_Find = 1







"===========================================================================
"
" オリジナル
"
"===========================================================================

" 独自シンタックスの設定
"au BufNewFile,BufRead *.txt setf mine	"setfだと反映されない
au BufNewFile,BufRead *.txt set filetype=mine


"===========================================================================
"===========================================================================
"===========================================================================
function! s:CloseBuf()
	let bufl = bufnr('$')
	if bufl == 1
		silent exe 'q'
	else
		let bufn = bufnr('%')
		if bufn >= (bufl - 1)
			silent exe 'bprevious'
		else
			silent exe 'bnext'
		endif

		let bufn2 = bufnr('%')
		if bufn == bufn2
			silent exe 'q'
		else
			silent exe 'bdel ' . bufn
		endif
	endif
endfunction
command! -nargs=0 CloseBuf call s:CloseBuf()

"nnoremap <silent> <leader>d :<C-u>CloseBuf<CR>
nnoremap :q<CR> :<C-u>CloseBuf<CR>


