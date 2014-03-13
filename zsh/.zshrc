# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="xiong-chiamiov-plus"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#
export EDITOR='vim'
#export PS1='\A [\u@\h \W]\$ '
#export PROMPT_COMMAND='RET=$?; if [[ $RET -eq 0 ]]; then echo -ne "\033[0;32m$RET\033[0m "; else echo -ne "\033[0;31m$RET\033[0m "; fi;'
export PATH=$HOME/.gem/ruby/1.9.1/bin:$HOME/.gem/ruby/2.0.0/bin:$PATH

if [[ "$OSTYPE" == *dawin* ]] then
  export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

  alias mysqlram='diskutil erasevolume HFS+ "ramdisk" `hdiutil attach -nomount ram://1048576` && cp -R /usr/local/mysql/data/* /Volumes/ramdisk/ && mysqld'
  export PATH=$HOME/.homebrew/bin:$PATH
  export PATH=/usr/local/mysql/bin:$PATH
fi

if [[ "$TERM" == *rxvt* ]] then 
    bindkey  "^[[7~"   beginning-of-line
    bindkey  "^[[8~"   end-of-line
fi


if [[ "$OSTYPE" == *linux* ]] then
  alias ls='ls --color=auto'
  alias yogurt='yaourt'
  function open {
      ((xdg-open $1 &> /dev/null &)&)
  }
fi


alias tardis='ssh yacoby@ssh.tardis.ed.ac.uk'
alias uni='ssh -X s1040340@student.ssh.inf.ed.ac.uk'
alias kazilar='ssh root@kazila.jacobessex.com'
alias kazila='ssh kazila.jacobessex.com'

alias todo='todo.sh'

alias be='bundle exec'

eval "$(rbenv init -)"

# Start X at log in for my desktop
[[ `hostname -s` = "ThinkingMachine" && -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
