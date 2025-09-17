alias screen="screen -U -O"

## cmd
export EDITOR='emacs'
export GREP_OPTIONS='--color=auto'

## PATH
export PATH=/usr/local/bin:/usr/local/sbin:/Developer/usr/bin:/usr/X11/bin:$PATH
export PATH=$HOME/bin:$HOME/local/bin:$PATH
export PATH=$PATH:/usr/local/heroku/bin

## homebrew
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

## C
export LIBRARY_PATH=/usr/local/lib:/usr/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=/usr/local/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/usr/local/include:$CPLUS_INCLUDE_PATH
export BOOST_ROOT=/usr/local/include/boost
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

## Ruby
export RBENV_ROOT=/usr/local/var/rbenv
export PATH=/usr/local/var/rbenv/shims:$PATH

## Golang
export PATH=$PATH:$HOME/go/bin

## Java
alias javac='LC_ALL=en javac -J-Dfile.encoding=UTF8'
alias jar='LC_ALL=en jar -J-Dfile.encoding=UTF8'
alias ant='LC_ALL=en ant'
export CLASSPATH=.
export CLASSPATH=$CLASSPATH:$HOME/lib/java/jai/lib:$HOME/lib/java
export PATH=$PATH:$JAVA_HOME/bin
export 'JRUBY_OPTS=-X-C'
export 'JAVA_OPTS=-Dfile.encoding=UTF-8'

## Node.js
export PATH=$HOME/.npm-global/bin:$PATH
export NODE_REPL_HISTORY_FILE=$HOME/.node_repl_history

## Google cloud SDK
export PATH=$PATH:$HOME/bin/google-cloud-sdk/bin

## Docker compose
export COMPOSE_HTTP_TIMEOUT=864000

## App open
alias vscode="open -a /Applications/Visual\ Studio\ Code.app"


[[ -s $HOME/.local_profile ]] && source $HOME/.local_profile

## LMStudio
export PATH="$PATH:$HOME/.lmstudio/bin"
