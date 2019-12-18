include env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	gperf
PKG_VERSION	    =	3.1
#PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.xz
#PKG_URL         =   
#http://ftp.gnu.org/gnu/gperf/gperf-3.1.tar.gz

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR)
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/configure --prefix=/$(TOOLCHAIN_DIR_NAME)

#        --prefix=$(TOOLCHAIN_DIR2) \
#        --build=$(LFS_HOST) \
#        --host=$(LFS_TARGET)
#	sed -i '/keyboard_lookup_key/d' $(PKG_SRC_DIR)/src/udev/udev-builtin-keyboard.c

#	$(CONFIGURE_FOR_CROSS_COMPILING) 


include scripts/build_rules.mk



