include env.mk
include scripts/macros.mk
include scripts/common_vars.mk
include scripts/stage1/gcc_vars.mk

#PKG_NAME        =   gcc
#PKG_VERSION     =   9.2.0
PKG_SUFFIX      =   pass1

DONE_MARKER_FILE =  $(call get_done_marker_file_name,$(PKG_FULL_NAME)_$(PKG_SUFFIX))

all: $(DONE_MARKER_FILE) 
#/$(TOOLS_DIR_NAME)/include/limits.h

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) all-gcc all-target-libgcc && \
	make -C $(PKG_BUILD_DIR) install-gcc install-target-libgcc
	$(call touch_done_marker_file,$(PKG_FULL_NAME)_$(PKG_SUFFIX))

/$(TOOLS_DIR_NAME)/include/limits.h:
	mkdir -p /$(TOOLS_DIR_NAME)/include
#	cd $(PKG_SRC_DIR) && \
#	echo -en '\n#undef STANDARD_STARTFILE_PREFIX_1\n#define STANDARD_STARTFILE_PREFIX_1 "/$(TOOLS_DIR_NAME)/lib/"\n' >> gcc/config/linux.h && \
#	echo -en '\n#undef STANDARD_STARTFILE_PREFIX_2\n#define STANDARD_STARTFILE_PREFIX_2 ""\n' >> gcc/config/linux.h
	touch /$(TOOLS_DIR_NAME)/include/limits.h

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR) /$(TOOLS_DIR_NAME)/include/limits.h
	echo "Configure $(PKG_FULL_NAME) ..."
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	AR=ar LDFLAGS="-Wl,-rpath,/$(TOOLCHAIN_DIR_NAME)/lib" \
	$(PKG_SRC_DIR)/configure \
	    --prefix=/$(TOOLCHAIN_DIR_NAME) \
	    --build=$(LFS_HOST) \
	    --host=$(LFS_HOST) \
	    --target=$(LFS_TARGET) \
	    --with-sysroot=$(LFS) \
	    --with-local-prefix=/$(TOOLS_DIR_NAME) \
	    --with-native-system-header-dir=/$(TOOLS_DIR_NAME)/include \
	    --disable-nls \
	    --disable-shared \
	    --with-mpfr=/$(TOOLCHAIN_DIR_NAME) \
	    --with-gmp=/$(TOOLCHAIN_DIR_NAME) \
	    --with-isl=/$(TOOLCHAIN_DIR_NAME) \
	    --with-cloog=/$(TOOLCHAIN_DIR_NAME) \
	    --with-mpc=/$(TOOLCHAIN_DIR_NAME) \
	    --without-headers \
	    --with-newlib \
	    --disable-decimal-float \
	    --disable-libgomp \
	    --disable-libmudflap --disable-libssp --disable-libatomic --disable-libitm \
	    --disable-libsanitizer --disable-libquadmath --disable-threads \
	    --disable-multilib --disable-target-zlib --with-system-zlib \
	    --enable-languages=c,c++ --enable-checking=release


include scripts/build_rules.mk

$(PKG_SRC_DIR)::
	scripts/stage1/bin/fix_gcc_includes.sh $(PKG_SRC_DIR) $(TOOLS_DIR_NAME)

#	[ ! -d $(PKG_SRC_DIR) ] && mv $(PKG_DIR) $(PKG_SRC_DIR) || true

# LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/$(TOOLCHAIN_DIR_NAME)/lib