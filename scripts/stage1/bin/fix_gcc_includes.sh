#!/bin/bash

set -x

GCC_PATH=$1
TOOLCHAIN_DIR_NAME=$2

for file in ${GCC_PATH}/gcc/config/{linux,i386/linux{,64}}.h
do
    cp -uv $file{,.orig}
    sed -e "s@/lib\(64\)\?\(32\)\?/ld@/${TOOLCHAIN_DIR_NAME}&@g" \
        -e "s@/usr@/${TOOLCHAIN_DIR_NAME})@g" $file.orig > $file
    echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "'/${TOOLCHAIN_DIR_NAME}'/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
    touch $file.orig
done

case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig ${GCC_PATH}/gcc/config/i386/t-linux64
 ;;
esac