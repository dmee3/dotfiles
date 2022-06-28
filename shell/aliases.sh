#!/bin/false

# Terminal Navigation
alias ..='cd ../'
alias ...='cd ../../'

# Editor
alias vim='nvim'

# Git
alias gst='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gs='git branch | fzf | git switch'

# Ruby
alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'

# Use Brew'd Universal ctags
alias ctags="`brew --prefix`/bin/ctags"

## Rails/RSpec
alias s='bundle exec rspec'
alias brc='bin/rails c'
alias brs='bin/rails s'
alias berc='bundle exec rails c'
alias bers='bundle exec rails s'

# Misc
alias cat='bat'
alias l='lsd -la'
alias chrome='open -a /Applications/Google\ Chrome.app'

# Fun
alias hack='open http://hackertyper.net'
