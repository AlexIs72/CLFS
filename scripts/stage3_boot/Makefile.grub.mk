include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	grub
PKG_VERSION	    =	2.04
PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.xz

#https://ftp.gnu.org/gnu/grub/grub-2.04.tar.xz

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
#	cd $(PKG_BUILD_DIR) && 
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install
#	ln -sv bash /$(TOOLCHAIN_DIR_NAME)/bin/sh || true
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR)
	cd $(PKG_BUILD_DIR) && \
	$(CONFIGURE_FOR_CROSS_COMPILING) \
        --disable-werror --enable-grub-mkfont=no --with-bootdir=$(TOOLS_DIR_NAME)/boot

#	$(PKG_SRC_DIR)/configure \
#	    --prefix=/$(TOOLS_DIR_NAME) \
#       --build=$(LFS_HOST) --host=$(LFS_TARGET) \
#        --without-bash-malloc --cache-file=config.cache

include scripts/build_rules.mk


