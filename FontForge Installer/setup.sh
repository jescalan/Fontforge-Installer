#!/bin/bash

cd /tmp
curl -o fontforge.tar.bz2 http://iweb.dl.sourceforge.net/project/fontforge/fontforge-source/fontforge_full-20110222.tar.bz2
tar -xjf fontforge.tar.bz2
cd fontforge-20110222
./configure --enable-pyextension --enable-double --without-x
make
# install python extensions