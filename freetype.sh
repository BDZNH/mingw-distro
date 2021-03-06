#!/bin/sh

source ./0_append_distro_path.sh

extract_file freetype-2.8.tar

cd /c/temp/gcc
mv freetype-2.8 src
mkdir build dest
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 --disable-shared \
--prefix=/c/temp/gcc/dest "CFLAGS=-s -O3" || fail_with freetype 1 - EPIC FAIL

make $X_MAKE_JOBS all || fail_with freetype 2 - EPIC FAIL
make install || fail_with freetype 3 - EPIC FAIL
cd /c/temp/gcc
rm -rf build src
mv dest freetype-2.8
cd freetype-2.8
rm -rf bin lib/pkgconfig lib/*.la share

7z -mx0 a ../freetype-2.8.7z *
