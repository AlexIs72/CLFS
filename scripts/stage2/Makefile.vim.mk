include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	vim
PKG_VERSION	    =	8.1.1846
PKG_URL         =   https://github.com/$(PKG_NAME)/$(PKG_NAME)/archive/v$(PKG_VERSION)/$(PKG_ARCHIVE)

SRC_DIR         =   $(BUILD_DIR)
#PKG_SRC_DIR     =   $(PKG_BUILD_DIR)/$(PKG_FULL_NAME)

#CONFIGURE_SCRIPT = $(PKG_SRC_DIR)/src/configure

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/src/auto/config.h
#	cd $(PKG_BUILD_DIR) && 
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install
	ln -sv vim $(TOOLS_DIR2)/bin/vi
	cp scripts/stage2/data/vimrc $(TOOLS_DIR2)/etc/vimrc
#	ln -sv bash /$(TOOLCHAIN_DIR_NAME)/bin/sh || true
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(PKG_BUILD_DIR)/src/auto/config.h: $(PKG_SRC_DIR)
#	mkdir -p $(PKG_BUILD_DIR)/src/auto/
	cp scripts/stage2/data/$(PKG_NAME)_config.cache $(PKG_BUILD_DIR)/src/auto/config.cache
	echo '#define SYS_VIMRC_FILE "$(TOOLS_DIR2)/etc/vimrc"' >> $(PKG_SRC_DIR)/src/feature.h
	cd $(PKG_BUILD_DIR) && \
	CFLAGS+=-fPIC $(CONFIGURE_FOR_CROSS_COMPILING) \
    --enable-gui=no --disable-gtktest --disable-xim \
    --disable-gpm --without-x --disable-netbeans --with-tlib=tinfo

include scripts/build_rules.mk



