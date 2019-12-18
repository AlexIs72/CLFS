include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	e2fsprogs
PKG_VERSION	    =	1.45.3
PKG_URL         =   https://downloads.sourceforge.net/project/$(PKG_NAME)/$(PKG_NAME)/v$(PKG_VERSION)/$(PKG_ARCHIVE)


all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install
	make -C $(PKG_BUILD_DIR) install-libs
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR)
#	cp scripts/stage3/data/$(PKG_NAME)_config.cache $(PKG_BUILD_DIR)
	cd $(PKG_BUILD_DIR) && \
	$(CONFIGURE_FOR_CROSS_COMPILING) \
        --enable-elf-shlibs     \
        --disable-libblkid      \
        --disable-libuuid       \
        --disable-uuidd         \
        --disable-fsck && \
	cp -v Makefile{,.orig} && \
	sed 's@/etc/cron@$(TOOLS_DIR2)/etc/cron@g' Makefile.orig > Makefile && \
	cp -v scrub/Makefile{,.orig} && \
	sed 's@/etc/cron@$(TOOLS_DIR2)/etc/cron@g' scrub/Makefile.orig > scrub/Makefile

#        --with-root-prefix=$(TOOLS_DIR2)   
#        --bindir=$(TOOLS_DIR2)/bin           
#        --enable-elf-shlibs --disable-libblkid --disable-libuuid --disable-fsck \
#        --disable-uuidd 

include scripts/build_rules.mk



