#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Automatically prepend 'cd' before filepaths ('/etc' == 'cd /etc')
shopt -s autocd

alias sudo='sudo '
alias s='sudo '
alias pvpn='protonvpn'
alias fast='sudo protonvpn d && sudo protonvpn c -f'
alias peer='sudo protonvpn d && sudo protonvpn c --p2p'
alias x='startx'
alias nnn='nnn -H'
alias ls='ls -A --color=always'
alias sdnow='shutdown 0'
alias reboot='shutdown -r 0'
alias n='nvim'
alias ud='udiskie'
alias udm='udiskie-mount'
alias udu='udiskie-umount'
alias udi='udiskie-info'
alias sctl='systemctl'
alias jctl='journalctl'
alias bctl='bluetoothctl'
alias pac='pacman'
alias ga='git add'
alias gc='git commit'
alias gpush='git push'
alias gpull='git pull'
alias glog='git log'
alias hgrep='history | grep '
alias mkdir='mkdir -p'
alias cmus='cd ~/music && cmus && cd -'
alias grep='grep --color'
alias mocp='mocp -T=nightly_theme'

export VISUAL=/usr/bin/nvim
export EDITOR=/usr/bin/nvim
export NNN_USE_EDITOR=1
export NNN_CONTEXT="1234"
export NNN_PLUG="s:suedit;u:uidgid;i:imgview;d:diffs"
export PS1="\[$(tput bold)\]\[\033[38;5;153m\][\u@\h \W]\[$(tput sgr0)\]\$ "

export PATH=$PATH:/home/thomas/.local/bin
