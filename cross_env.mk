include env.mk

export CC       =   $(LFS_TARGET)-gcc $(BUILD64)
export CXX      =   $(LFS_TARGET)-g++ $(BUILD64)
export AR       =   $(LFS_TARGET)-ar
export AS       =   $(LFS_TARGET)-as
export RANLIB   =   $(LFS_TARGET)-ranlib
export LD       =   $(LFS_TARGET)-ld
export STRIP    =   $(LFS_TARGET)-strip