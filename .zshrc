# Set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt bart

typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

setopt prompt_subst
export __CURRENT_GIT_BRANCH=

# Get git infos
parse_git_branch() {
	git branch --no-color 2> /dev/null \
	| sed -e '/^[^*]/d' -e 's/* \(.*\)/[%F{green}\1%F{white}]/'
}

# When we execute some git command
preexec_functions+='zsh_preexec_update_git_vars'
zsh_preexec_update_git_vars() {
	case "$(history $HISTCMD)" in 
		*git*)
		export __CURRENT_GIT_BRANCH="$(parse_git_branch)"
		;;
	esac
}

# When we change directory
chpwd_functions+='zsh_chpwd_update_git_vars'
zsh_chpwd_update_git_vars() {
	export __CURRENT_GIT_BRANCH="$(parse_git_branch)"
}

get_git_prompt_info() {
	echo $__CURRENT_GIT_BRANCH
}

#TEST module vcs_info
#autoload -Uz vcs_info
#zstyle ':vcs_info:*' enable git cvs svn
#precmd(){
#	vcs_info 'prompt'
#}

#export PS1='[%F{blue}%n%F{white}@%F{red}%M%F{white}:%F{cyan}%~%F{white}]$(get_git_prompt_info)${vcs_info_msg_0_}$ '
export PS1='%F{white}[%F{blue}%n%F{white}@%F{red}%M%F{white}:%F{cyan}%~%F{white}]$(get_git_prompt_info)$ '


setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Alias

alias rm='rm -i'
alias lc='ls --color=auto'
alias ll='lc -lrt'
alias lla='lc -la'
alias gre='grep -rn --color'
alias grepsvn='gre --exclude-dir=.svn'
alias grepwaf='gre --exclude-dir=.waf*'
alias dofus='~/src/jeux/dofus/Dofus/launch-dofus.sh'
alias dofusbeta='~/liens/DofusBM/bin/Dofus'
alias dofusbot='LD_PRELOAD=~/src/jeux/dofus/bot4/libdofus.so dofus'
alias dofussniff='LD_PRELOAD=~/.usr/lib/libdofussniff.so dofus'
alias flashdecompiler='wine ~/.wine/drive_c/Program\ Files/Eltima\ Software/Flash\ Decompiler\ Trillix/FlashDecompiler.exe'

export CREMI=alucas@jaguar.emi.u-bordeaux1.fr
export TUTO=tutorat@ssh.alwaysdata.com
export KANJI=kanji@ssh.alwaysdata.com

# Paths

export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:jre/bin/java::")
export CLASS_PATH=$CLASS_PATH:$(readlink -f /usr/bin/java | sed "s:jre/bin/java:lib:"):~/prog/idea-IC-139.1117.1/lib

export EDITOR=vim
export PYTHONPATH=~/.usr/lib/python

export PATH=$PATH:~:~/.usr/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/.usr/lib
export CPATH=$CPATH:~/.usr/include

#print "Execution du script d'initialisation de zsh: OK"

export MANPAGER="/usr/bin/most -s"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

