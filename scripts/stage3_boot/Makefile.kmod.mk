include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	kmod
PKG_VERSION	    =	26
PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.xz
PKG_URL         =   https://www.kernel.org/pub/linux/utils/kernel/$(PKG_NAME)/$(PKG_ARCHIVE)

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install
	ln -sfv kmod $(TOOLS_DIR2)/bin/lsmod
	for tool in depmod insmod modprobe modinfo rmmod; do \
        ln -sv ../bin/kmod $(TOOLS_DIR2)/sbin/$${tool}; \
    done
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR)
#	cp scripts/stage2/data/$(PKG_NAME)_config.cache $(PKG_BUILD_DIR)
	cd $(PKG_BUILD_DIR) && \
	$(CONFIGURE_FOR_CROSS_COMPILING) \
            --with-rootlibdir=$(TOOLS_DIR2)/lib \
            --with-xz              \
            --with-zlib


#./configure --prefix=/usr          \
#            --bindir=/bin          \
#            --sysconfdir=/etc      \

#	$(PKG_SRC_DIR)/configure \
#	    --prefix=/$(TOOLS_DIR_NAME) \
#       --build=$(LFS_HOST) --host=$(LFS_TARGET) \
#        --without-bash-malloc --cache-file=config.cache

include scripts/build_rules.mk



