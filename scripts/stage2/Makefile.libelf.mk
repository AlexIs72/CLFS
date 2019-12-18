include env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME        =   elfutils
PKG_VERSION     =   0.177
#PKG_BUILD_DIR   =   $(BUILD_DIR)/$(PKG_FULL_NAME)_$(PKG_SUFFIX)
PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.bz2
PKG_URL         =   https://sourceware.org/ftp/$(PKG_NAME)/$(PKG_VERSION)/$(PKG_ARCHIVE)

DONE_MARKER_FILE =  $(call get_done_marker_file_name,$(PKG_FULL_NAME))

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR)/libelf install
	install -vm644 $(PKG_BUILD_DIR)/config/libelf.pc $(TOOLCHAIN_DIR)/lib/pkgconfig
#	make -C $(PKG_BUILD_DIR) install
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/configure \
    --prefix=$(TOOLCHAIN_DIR) 

#--host=$(LFS_HOST) --target=$(LFS_TARGET) \
#    --with-sysroot=$(LFS) --with-lib-path=/$(TOOLS_DIR_NAME)/lib --disable-nls \
#    --disable-static --enable-64-bit-bfd --disable-multilib --disable-werror

include scripts/build_rules.mk



