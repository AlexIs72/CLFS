include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	bc
PKG_VERSION	    =	2.1.3
#PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.xz
PKG_URL         =   https://github.com/gavinhoward/$(PKG_NAME)/archive/$(PKG_VERSION)/$(PKG_ARCHIVE)

SRC_DIR         =   $(BUILD_DIR)

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(TOOLCHAIN_DIR2)/bin/bc
	touch $(PKG_BUILD_DIR)/Makefile
	touch $(TOOLCHAIN_DIR2)/bin/bc
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(TOOLCHAIN_DIR2)/bin/bc: $(PKG_BUILD_DIR)/Makefile
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR)
	cd $(PKG_BUILD_DIR) && \
	CC=gcc  CFLAGS="-std=c99" NLSPATH="$(TOOLCHAIN_DIR2)/usr/share/locale/%L/%N" \
    $(PKG_SRC_DIR)/configure.sh --prefix=$(TOOLCHAIN_DIR2) --disable-generated-tests --opt=3 

#PREFIX=/usr CC=gcc CFLAGS="-std=c99" ./configure.sh -G -O3

include scripts/build_rules.mk



