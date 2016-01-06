#!/bin/bash

# exit on error
set -e

TMUX_VERSION=2.1

# create our directories
mkdir -p $HOME/tmux_tmp
cd $HOME/tmux_tmp

#Needed:
#yum install ncurses ncurses-devel


# download source files for tmux, libevent, and ncurses
#wget -O tmux-${TMUX_VERSION}.tar.gz http://downloads.sourceforge.net/tmux/tmux-${TMUX_VERSION}.tar.gz
wget -O tmux-${TMUX_VERSION}.tar.gz https://github.com/tmux/tmux/releases/download/2.1/tmux-2.1.tar.gz
curl -OkL https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz


#yum groupinstall "Development Tools" -y
#yum install ncurses-devel.x86_64

# extract files, configure, and compile

############
# libevent #
############
tar xvzf libevent-2.0.21-stable.tar.gz
cd libevent-2.0.21-stable
./configure --prefix=$HOME/tmux_tmp --disable-shared
make
make install
cd ..

############
# ncurses  #
############
#tar xvzf ncurses-5.9.tar.gz
#cd ncurses-5.9
#./configure --prefix=$HOME/local
#make
#make install
#cd ..

############
# tmux     #
############
tar xvzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
PKG_CONFIG_PATH=$HOME/tmux_tmp/lib/pkgconfig CFLAGS="-I$HOME/tmux_tmp/include" LDFLAGS="-L$HOME/tmux_tmp/lib" ./configure --prefix=/usr
make
# cleanup
#rm -rf $HOME/tmux_tmp

#echo "$HOME/local/bin/tmux is now available. You can optionally add $HOME/local/bin to your PATH."

