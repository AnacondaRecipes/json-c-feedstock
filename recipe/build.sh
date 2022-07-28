#!/bin/bash

# Get an updated config.sub and config.guess
cp -r ${BUILD_PREFIX}/share/gnuconfig/config.* .

# https://github.com/json-c/json-c/issues/406
export CPPFLAGS="${CPPFLAGS/-DNDEBUG/}"

echo "Building ${PKG_NAME}."


# Isolate the build.
mkdir -p Build-${PKG_NAME}
cd Build-${PKG_NAME} || exit 1


# Generate the build files.
echo "Generating the build files..."
cmake .. ${CMAKE_ARGS} \
      -GNinja \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_BUILD_TYPE=Release


# Build.
echo "Building..."
ninja || exit 1


# Perform tests.
echo "Testing..."
ctest -VV --output-on-failure || exit 1


# Installing
echo "Installing..."
ninja install || exit 1


# Error free exit!
echo "Error free exit!"
exit 0
