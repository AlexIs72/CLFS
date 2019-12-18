include env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME        =   glibc
PKG_VERSION     =   2.30

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	BUILD_CC="gcc" CC="$(LFS_TARGET)-gcc $(BUILD64)" \
	AR="$(LFS_TARGET)-ar" RANLIB="$(CLFS_TARGET)-ranlib" \
	$(PKG_SRC_DIR)/configure --prefix=/$(TOOLS_DIR_NAME) \
	    --host=$(LFS_TARGET) --build=$(LFS_HOST) \
	    --disable-profile --enable-kernel=3.2 \
	    --with-binutils=/$(TOOLCHAIN_DIR_NAME)/bin --with-headers=/$(TOOLS_DIR_NAME)/include \
	    --enable-obsolete-rpc --cache-file=config.cache

#	AR=ar AS=as $(PKG_SRC_DIR)/configure \
#    --prefix=/$(TOOLCHAIN_DIR_NAME) --host=$(LFS_HOST) --target=$(LFS_TARGET) \
#    --with-sysroot=$(LFS) --with-lib-path=/$(TOOLS_DIR_NAME)/lib --disable-nls \
#    --disable-static --enable-64-bit-bfd --disable-multilib --disable-werror

include scripts/build_rules.mk


#	touch $(PKG_SRC_DIR) && \

