"===========================================================================
"
" オプション
"
"===========================================================================

set lines=80		" 縦幅
set columns=160		" 横幅

" GUIオプション
set guioptions+=b	" 水平スクロールバー表示
set guioptions-=T	" ツールバー非表示
set guioptions-=t	" メニューの切り離しができないようにする

"" フォント
if has('win32')
"  " Windows用
"  set guifont=MS_Gothic:h10:cSHIFTJIS
"  "set guifont=Inconsolata:h10:cSHIFTJIS
"  "set guifont=Consolas:h10:cSHIFTJIS
"  "set guifont=MS_Gothic:h12:cSHIFTJIS
"  "set guifont=MS_Mincho:h12:cSHIFTJIS
"  " 行間隔の設定
"  set linespace=1
"  " 一部のUCS文字の幅を自動計測して決める
"  if has('kaoriya')
"    set ambiwidth=auto
"  endif
elseif has('mac')
	" Macではなぜかgvimrcにも書いておかないとおかしくなる
	colorscheme molokai

	" 現在のMac環境では、文字の色が明るすぎるので、ちょっと変更する
	hi Normal guifg=#CCCCCC

"  set guifont=Osaka−等幅:h14
"  "set guifont=Ricty:h14
"elseif has('xfontset')
"  " UNIX用 (xfontsetを使用)
"  set guifontset=a14,r14,k14
"else
"  set guifont=MS\ Gothic\ 10
endif

" 色
"colorscheme jellybeans


"set mouse=""

