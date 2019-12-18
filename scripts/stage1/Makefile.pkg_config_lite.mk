include env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	pkg-config-lite
PKG_VERSION	    =	0.28-1
PKG_URL	    	=	http://sourceforge.net/projects/pkgconfiglite/files/$(PKG_VERSION)/$(PKG_ARCHIVE)
#ftp://ftp.astron.com/pub/$(PKG_NAME)/$(PKG_ARCHIVE)

#http://sourceforge.net/projects/pkgconfiglite/files/0.28-1/pkg-config-lite-0.28-1.tar.gz

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	cd $(PKG_BUILD_DIR) && \
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/configure \
	    --prefix=/$(TOOLCHAIN_DIR_NAME) \
	    --host=$(LFS_TARGET) \
	    --with-pc-path=/$(TOOLS_DIR_NAME)/lib/pkgconfig:/$(TOOLS_DIR_NAME)/share/pkgconfig

include scripts/build_rules.mk



