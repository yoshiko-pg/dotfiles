# 環境変数
export LANG=ja_JP.UTF-8

# 色を使用出来るようにする
autoload -Uz colors
colors
export CLICOLOR=1
# eval $(/usr/local/bin/gdircolors ~/Dropbox/app/Terminal/solarized/dircolors-solarized-master/dircolors.ansi-universal)
export LSCOLORS=ExFxBxDxCxegedabagacad
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
alias diff='colordiff -u'

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

ulimit -n 2048

# プロンプト
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git:*:-all-' command /usr/bin/git
zstyle ':vcs_info:*' max-exports 6 # formatに入る変数の最大数
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b@%r' '%c' '%u'
zstyle ':vcs_info:git:*' actionformats '%b@%r|%a' '%c' '%u'
setopt prompt_subst
function vcs_echo {
	local st branch color
	STY= LANG=en_US.UTF-8 vcs_info
	st=`git status 2> /dev/null`
	if [[ -z "$st" ]]; then return; fi
	branch="$vcs_info_msg_0_"
	if   [[ -n "$vcs_info_msg_1_" ]]; then color=${fg[green]} #staged
	elif [[ -n "$vcs_info_msg_2_" ]]; then color=${fg[red]} #unstaged
	elif [[ -n `echo "$st" | grep "^Untracked"` ]]; then color=${fg[blue]} # untracked
	else color=${fg[cyan]}
	fi
	echo "%{$color%}(%{$branch%})%{$reset_color%}" | sed -e s/@/"%F{yellow}@%f%{$color%}"/
}

DEFAULT='$'
ERROR='%F{red}$%f'

DEFAULT=$'\U1F411 ' # ひつじ
#ERROR=$'\U1F40D '	# ヘビ
ERROR=$'\U1F363 '	# スシ

#DEFAULT=$'\U1F363 '	# スシ
#ERROR=$'\U1F356 '	# 肉

#DEFAULT=$'\U1F4AC ' # ふきだし
#ERROR=$'\U274C '	# バツ

PROMPT=$'
%F{yellow}[%~]%f `vcs_echo`
%(?.${DEFAULT}.${ERROR}) '

# もしかして
SPROMPT="%{$fg[blue]%}もしかして: %B%r%b ${reset_color}  (y, n, a, e)-> "

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# 補完機能を有効にする
autoload -U compinit
compinit -u

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# コマンド名の修正
setopt correct

########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep
setopt nolistbeep

# フローコントロールを無効にする
setopt no_flow_control

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# = の後はパス名として補完する
setopt magic_equal_subst

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# ヒストリファイルに保存するとき、すでに重複したコマンドがあったら古い方を削除する
setopt hist_save_nodups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 補完候補が複数あるときに自動的に一覧表示する
setopt auto_menu

# 高機能なワイルドカード展開を使用する
#setopt extended_glob

########################################
# キーバインド
bindkey -v

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "^J" history-beginning-search-backward
bindkey "^K" history-beginning-search-forward

########################################
# エイリアス

alias ls='/usr/local/bin/gls -slhaF --color=auto --time-style=long-iso'
alias ll="ls"

alias cp='cp -i'
alias mv='mv -i'

function count(){
  \ls -1 $1 | wc -l
}

# git
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
function git(){hub "$@"}
alias g='git'
alias gits='git status'
alias gitrmall='git rm $(git ls-files --deleted)'
alias gh='git gh'
alias gbr='git browse-remote --pr'
alias gpr='git pull-request && git browse-remote --pr'
alias pr='gpr'
alias gg='git grep'

: ${_omz_git_git_cmd:=git}
function current_branch() {
  local ref
  ref=$($_omz_git_git_cmd symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$($_omz_git_git_cmd rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}
ggl() {
  [[ "$#" == 0 ]] && local b="$(current_branch)"
  git pull origin "${b:=$1}" "${*[2,-1]}"
}
ggp() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(current_branch)"
    git push origin "${b:=$1}"
  fi
}

# bundle
alias bi='bundle install'
alias bu='bundle update'
alias bug='bundle upgrade'
alias be='bundle exec'

# gulp
alias cgulp='gulp --require coffee-script'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# カスタム移動系
alias d='cd ~/Desktop;'
alias w='cd ~/workspace;'
alias api='cd ~/workspace/prott-api;'
alias we='cd ~/workspace/prott-webapp;'
alias s='cd ~/workspace/sandbox;'

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# スリープ解除時間
function when(){grep Wake /var/log/system.log}

# alias C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

# macvim
# export PATH="/Applications/MacVim.app/Contents/MacOS:$PATH"
# alias vim=/Applications/MacVim.app/Contents/MacOS/Vim
# alias vi=vim

# rbenv
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

# ruby
# export RUBYGEMS_GEMDEPS=-

# Haskell
# Add GHC 7.10.1 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="/Applications/ghc-7.10.1.app"
if [ -d "$GHC_DOT_APP" ]; then
  export PATH="${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi


# zaw.zsh
# function mkcd(){mkdir -p $1 && cd $1}
# source /Users/maasa/zsh_plugin/zaw/zaw.zsh
# bindkey '^h' zaw-history

# postgresql
# 
# PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH"

# rails
export RAILS_ENV=development

# Android
# export PATH="/Applications/eclipse/sdk/tools:$PATH"
# export PATH="/Applications/eclipse/sdk/platform-tools:$PATH"
#export ANDROID_HOME="/Applications/eclipse/sdk"
#export JAVA_HOME="/usr/libexec/java_home"
#export JAVA_HOME="/Library/Java/Home"
#export PATH="$JAVA_HOME/bin:$PATH"
# export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'

# phpenv
# export PATH=$PATH:$HOME/.phpenv/bin
# eval "$(phpenv init - zsh)"

# php5
export PATH=/usr/local/php5/bin:$PATH

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# Prott
export PATH=/Users/yoshiko/workspace/tools/prott-commands/bin:$PATH

# tmux
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
    if is_screen_or_tmux_running; then
        ! is_exists 'tmux' && return 1

        if is_tmux_runnning; then
            # echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
            # echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
            # echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
            # echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
            # echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
        elif is_screen_running; then
            echo "This is on screen."
        fi
    else
        if shell_has_started_interactively && ! is_ssh_running; then
            if ! is_exists 'tmux'; then
                echo 'Error: tmux command not found' 2>&1
                return 1
            fi

            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                # detached session exists
                tmux list-sessions
                echo -n "Tmux: attach? (y/N/num) "
                read
                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                    tmux attach-session
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                    tmux attach -t "$REPLY"
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                fi
            fi

            if is_osx && is_exists 'reattach-to-user-namespace'; then
                # on OS X force tmux's default command
                # to spawn a shell in the user's namespace
                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
            else
                tmux new-session && echo "tmux created new session"
            fi
        fi
    fi
}
tmux_automatically_attach_session
