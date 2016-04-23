#-------------------------------------------------------------------------------
# 基本
#-------------------------------------------------------------------------------
export LANG=ja_JP.UTF-8                 # 文字コードをUTF-8に設定


#-------------------------------------------------------------------------------
# オプション
#-------------------------------------------------------------------------------
setopt no_beep                          # ビープ音を鳴らさない

# ディレクトリ変更
setopt auto_cd                          # ディレクトリ名だけでcd
setopt auto_pushd                       # cd時に自動でpushd
setopt pushd_ignore_dups                # 同じディレクトリをpushdしない

# 補完
setopt auto_list                        # 補完候補が複数ある時に一覧表示 (D)
setopt auto_menu                        # 補完キー(TAB)連打で候補を順に切り替え (D)
setopt list_packed                      # 補完候補をできるだけ詰めて表示
setopt list_types                       # 補完候補でファイル種別のマークを表示 (D)

# 履歴
setopt extended_history                 # 履歴ファイルに開始時刻/実行時間を記録
setopt hist_ignore_all_dups             # 履歴を重複させない（古い履歴を削除）
setopt hist_ignore_dups                 # 直前と同じコマンドを履歴に記録しない
setopt hist_ignore_space                # 空白で始まるコマンドを履歴に記録しない
setopt hist_no_store                    # historyコマンドを履歴に記録しない
setopt hist_reduce_blanks               # 余分な空白を削除して記録
setopt share_history                    # 履歴をリアルタイムで共有

# その他
setopt correct                          # コマンド名の入力ミスを訂正
setopt ignore_eof                       # Ctrl+Dでzshを終了しない
setopt interactive_comments             # コマンドラインでも'#'以降をコメントと見なす
setopt prompt_subst                     # プロンプト内で変数展開などを行う
setopt transient_rprompt                # 現在のコマンドラインのみ右プロンプトを表示


#-------------------------------------------------------------------------------
# 補完
#-------------------------------------------------------------------------------

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

autoload -U compinit
compinit

# 大文字小文字区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


#-------------------------------------------------------------------------------
# 履歴
#-------------------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=100000                         # メモリ上に保存される件数（検索できる件数）
SAVEHIST=100000                         # ファイルに保存される件数

# 入力途中での履歴検索
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


#-------------------------------------------------------------------------------
# 色
#-------------------------------------------------------------------------------
autoload -U colors
colors

# ls
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# lsがカラー表示になるようエイリアスを設定
case "${OSTYPE}" in
darwin*)
  # Mac
  alias ls="ls -GF"
  ;;
linux*)
  # Linux
  alias ls='ls -F --color'
  ;;
esac


#-------------------------------------------------------------------------------
# プロンプト
#-------------------------------------------------------------------------------

# 左側には「ユーザー名@ホスト名 カレントティレクトリ $ 」
PROMPT="%{${fg[green]}%}%n@%m %{${fg[yellow]}%}%~ %{${fg[red]}%}%(!.#.$)%f %{${reset_color}%}"
PROMPT2="%{${fg[yellow]}%} %_ > %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r ? [n,y,a,e] %{${reset_color}%}"

# 右側にはgit関連の情報
autoload -U vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{cyan}%S %F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
  LANG=en_US.UTF-8 vcs_info
}
RPROMPT='${vcs_info_msg_0_}'


#-------------------------------------------------------------------------------
# peco
#-------------------------------------------------------------------------------
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history


#-------------------------------------------------------------------------------
# その他
#-------------------------------------------------------------------------------

# tmux自動起動
if [ -z $TMUX ]; then
  # tmuxのオプションに-2を付けないとubuntuのtmux上でvimがカラーにならない
  # tmux -2
  tmux
fi
#

# ローカルのzshrcを読み込む
[ -f ~/.zshrc.local ] && source ~/.zshrc.local


