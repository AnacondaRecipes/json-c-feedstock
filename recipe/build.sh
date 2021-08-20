#!/bin/bash

# Get an updated config.sub and config.guess
cp -r ${BUILD_PREFIX}/share/libtool/build-aux/config.* .

if [[ "${target_platform}" == osx-* ]]; then
  # turn off Werror for clang ...
  sed -i.bak -E "s/-Werror/-Wno-error/" configure.ac
fi

bash ./autogen.sh

# https://github.com/json-c/json-c/issues/406
export CPPFLAGS="${CPPFLAGS/-DNDEBUG/}"

./configure --prefix=$PREFIX --host=$HOST --build=$BUILD

make ${VERBOSE_AT}
make check ${VERBOSE_AT}
make install
