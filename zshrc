# Path to your oh-my-zsh installation.
export ZSH=/home/tahiry/.oh-my-zsh
source ${HOME}/.bashrc

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="sunrise"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git jump)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/tahiry/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
#
#
#
### TERMITE ###
eval $(dircolors ~/.dircolors)
source ${HOME}/rep/github.fork/zsh-git-prompt/zshrc.sh
[ -f ~/.shell_prompt.sh ] && source ~/.shell_prompt.sh
#PROMPT='%B%m%~%b$(git_super_status) %# '
#PROMPT='%B$PREFIX %2~ $(git_super_status)%{$M%}%B»%b%{$RESET%} '

### FUNCTION ###

google() {
    search=""; img=""; wiki=0; serie=0;
    echo "Googling: $@";
    for term in $@; 
    do  
     if [ "$term" = "-i" ]; 
        then img="&tbm=isch" 
     elif [ "$term" = "-l" ]; 
        then img="$img&btnI=I%27m+Feeling+Lucky" 
     elif [ "$term" = "-w" ];
        then wiki=1
     elif [ "$term" = "-S" ];
        then serie=1
     else
    search="$search%20$term"; 
     fi
    done
    if [ $wiki -eq 1 ];
        then    w3m "http://en.wikipedia.org/wiki/Special:Search/$search"
    elif [ $serie -eq 1 ];
        then    w3m "http://en.wikipedia.org/wiki/Special:Search/list%20of%20$search%20episodes"
    else        
        w3m  "http://www.google.com/search?hl=en&q=$search$img" 
    fi
}

googlenow(){
    search="";
    for term in $@;
    do
     search="$search%20$term";
    done     
    w3m  "http://www.google.com/search?hl=en&q=$search" |sed -n "/About.*results/{n;N;p;}" |sed -r 's .{23}  ';
}

ddg(){
    search=""; bang=""; zeroc=0;
    for term in $@;
    do
     if [ "$term" = "-z" ];
        then zeroc=1
     elif [[ "$term" =~ -([A-Za-z0-9._%+-]*) ]];
        then bang="!${BASH_REMATCH[1]}"
     else
        search="$search%20$term";
     fi
    done
    if [ $zeroc -eq 1 ];
      then w3m  "https://www.duckduckgo.com/?q=$bang$search" | sed -n "/Zero-click/,/More at/p" ;
    else
      w3m  "https://www.duckduckgo.com/?q=$bang$search" ;
    fi
}

function frtoen()
{ 
    w3m http://mobile-dictionary.reverso.net/francais-anglais/$(perl -MURI::Escape -e 'print uri_escape("'$1'");') | awk '/━━━━+$/,/Index alphabétique/' ;
}

function entofr()
{ 
    w3m http://mobile-dictionary.reverso.net/anglais-francais/$(perl -MURI::Escape -e 'print uri_escape("'$1'");') | awk '/━━━━+$/,/Index alphabétique/' ;
}



