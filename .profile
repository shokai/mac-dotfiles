alias screen="screen -U -O"

## cmd
export EDITOR='emacs'
export LESS='-R'
export LESSOPEN='| $HOME/.source-hilite/src-hilite-lesspipe.sh %s'
export GREP_OPTIONS='--color=auto'

## PATH
export PATH=/usr/local/bin:/usr/local/sbin:/Developer/usr/bin:/usr/X11/bin:$PATH
export PATH=$HOME/bin:$HOME/local/bin:$PATH
export PATH=$PATH:/usr/local/CrossPack-AVR/bin
export PATH=$PATH:/usr/local/heroku/bin

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
export GOROOT=`go env GOROOT`
export GOPATH=$HOME/lib/go
export PATH=$PATH:$GOROOT/bin

## Java
alias javac='LC_ALL=en javac -J-Dfile.encoding=UTF8'
alias jar='LC_ALL=en jar -J-Dfile.encoding=UTF8'
alias ant='LC_ALL=en ant'
export CLASSPATH=.
export CLASSPATH=$CLASSPATH:$HOME/lib/java/jai/lib:$HOME/lib/java
export PATH=$PATH:$JAVA_HOME/bin
export 'JRUBY_OPTS=-X-C'
export 'JAVA_OPTS=-Dfile.encoding=UTF-8'

## Android
export ANDROID_HOME=/usr/local/opt/android-sdk

## Node.js
export NODE_REPL_HISTORY_FILE=$HOME/.node_repl_history

## misc
export CRX_KEY=$HOME/.chrome_ext/key.pem
alias macdown="open -a /Applications/MacDown.app"
alias gitx="open -a /Applications/GitX.app"

[[ -s $HOME/.local_profile ]] && source $HOME/.local_profile

# added by travis gem
[ -f /Users/sho/.travis/travis.sh ] && source /Users/sho/.travis/travis.sh
