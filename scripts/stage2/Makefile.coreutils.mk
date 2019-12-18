include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	coreutils
PKG_VERSION	    =	8.31
PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.xz

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR)
	cp scripts/stage2/data/$(PKG_NAME)_config.cache $(PKG_BUILD_DIR)
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/configure \
	    --prefix=/$(TOOLS_DIR_NAME) \
        --build=$(LFS_HOST) --host=$(LFS_TARGET) \
        --enable-install-program=hostname --cache-file=config.cache

include scripts/build_rules.mk



