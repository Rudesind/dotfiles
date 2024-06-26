set fish_greeting
fish_add_path /opt/homebrew/bin
starship init fish | source
alias config='/opt/homebrew/bin/git --git-dir=$HOME/.config/ --work-tree=$HOME'
alias ls='lsd -a -l'
alias cat='bat'
alias cls='clear'
