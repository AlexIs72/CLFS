include env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	file
PKG_VERSION	    =	5.37
PKG_URL	    	=	ftp://ftp.astron.com/pub/$(PKG_NAME)/$(PKG_ARCHIVE)

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	cd $(PKG_BUILD_DIR) && \
	make -j $(NUM_CPU) && \
	make install
	$(call touch_done_marker_file,$(PKG_NAME),$(PKG_VERSION))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/configure \
	    --prefix=/$(TOOLCHAIN_DIR_NAME)

include scripts/build_rules.mk



