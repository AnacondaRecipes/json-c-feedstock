#!/bin/bash

bash ./autogen.sh

# https://github.com/json-c/json-c/issues/406
export CPPFLAGS="${CPPFLAGS/-DNDEBUG/}"

./configure --prefix=$PREFIX

make
make check
make install
