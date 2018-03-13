#!/bin/bash

bash ./autogen.sh

# https://github.com/json-c/json-c/issues/406
export CPPFLAGS="${CPPFLAGS/-DNDEBUG/}"

./configure --prefix=$PREFIX --host=$HOST --build=$BUILD

make ${VERBOSE_AT}
make check ${VERBOSE_AT}
make install
