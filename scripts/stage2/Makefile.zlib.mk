include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	zlib
PKG_VERSION	    =	1.2.11
PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.xz
PKG_URL	    	=	https://zlib.net/$(PKG_ARCHIVE)
#oftp://ftp.astron.com/pub/$(PKG_NAME)/$(PKG_ARCHIVE)

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/configure \
	    --prefix=/$(TOOLS_DIR_NAME)

include scripts/build_rules.mk



