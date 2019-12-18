include env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME        =   binutils
PKG_VERSION     =   2.33.1
PKG_SUFFIX      =   stage1
PKG_BUILD_DIR   =   $(BUILD_DIR)/$(PKG_FULL_NAME)_$(PKG_SUFFIX)

DONE_MARKER_FILE =  $(call get_done_marker_file_name,$(PKG_FULL_NAME)_$(PKG_SUFFIX))

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install
	$(call touch_done_marker_file,$(PKG_FULL_NAME)_$(PKG_SUFFIX))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	AR=ar AS=as $(PKG_SRC_DIR)/configure \
    --prefix=/$(TOOLCHAIN_DIR_NAME) --host=$(LFS_HOST) --target=$(LFS_TARGET) \
    --with-sysroot=$(LFS) --with-lib-path=/$(TOOLS_DIR_NAME)/lib --disable-nls \
    --disable-static --enable-64-bit-bfd --disable-multilib --disable-werror

include scripts/build_rules.mk



