include env.mk
include scripts/macros.mk
include scripts/common_vars.mk
include scripts/stage1/gcc_vars.mk


PKG_SUFFIX      =   lisbstdc++

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install
	$(call touch_done_marker_file,$(PKG_FULL_NAME)_$(PKG_SUFFIX))


$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR) 
	echo "Configure $(PKG_FULL_NAME) ..."
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/libstdc++-v3/configure           \
	    --build=$(LFS_HOST) \
	    --host=$(LFS_HOST) \
	    --target=$(LFS_TARGET) \
	    --prefix=/$(TOOLCHAIN_DIR_NAME)                 \
	    --disable-multilib              \
	    --disable-nls                   \
	    --disable-libstdcxx-threads     \
	    --disable-libstdcxx-pch         \
	    --with-gxx-include-dir=/$(TOOLCHAIN_DIR_NAME)/$(LFS_TARGET)/include/c++/$(PKG_VERSION)


include scripts/build_rules.mk


