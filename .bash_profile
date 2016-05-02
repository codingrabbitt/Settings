export PATH="/usr/local/sbin:/usr/local/mysql/bin:/usr/local/bin:$PATH"
CLICOLOR=1 
LSCOLORS=gxfxcxdxbxegedabagacad
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '
export TERM=xterm-color
# System alias
alias ls="ls -G"
alias ll="ls -l"

# Django alias
alias djr="python manage.py runserver"
alias dj="python manage.py"
alias djmm="python manage.py makemigrations"
alias djm="python manage.py migrate"

# Virtualenv alias
alias sba="source ./bin/activate"
alias da="deactivate"

# Git alias
alias gits="git status"
alias gitaa="echo -e \"\033[33m### Before add ###\033[0m\" && gits && git add . && echo -e \"\033[33m### After add ###\033[0m\" && gits"
alias gitc="git commit"
alias gitps="git push"
alias gitpl="git pull"

