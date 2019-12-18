include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	findutils
PKG_VERSION	    =	4.6.0

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
#	cd $(PKG_BUILD_DIR) && 
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install
#	ln -sv bash /$(TOOLCHAIN_DIR_NAME)/bin/sh || true
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR)
	cp scripts/stage2/data/$(PKG_NAME)_config.cache $(PKG_BUILD_DIR)
	cd $(PKG_SRC_DIR) && \
	sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' gl/lib/*.c && \
	sed -i '/unistd/a #include <sys/sysmacros.h>' gl/lib/mountlist.c && \
	echo "#define _IO_IN_BACKUP 0x100" >> gl/lib/stdio-impl.h && \
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/configure \
	    --prefix=/$(TOOLS_DIR_NAME) \
        --build=$(LFS_HOST) --host=$(LFS_TARGET) \
        --cache-file=config.cache

include scripts/build_rules.mk



