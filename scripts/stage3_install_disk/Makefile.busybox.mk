include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME        =   busybox
PKG_VERSION     =   1.31.1
PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.bz2
PKG_URL         =   https://busybox.net/downloads/$(PKG_ARCHIVE)
#https://github.com/gavinhoward/$(PKG_NAME)/archive/$(PKG_VERSION)/$(PKG_ARCHIVE)


SRC_DIR         =   $(BUILD_DIR)

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(INSTALL_DISK_DIR)/rootfs/bin/busybox
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(INSTALL_DISK_DIR)/rootfs/bin/busybox: $(PKG_SRC_DIR)
	cp scripts/stage3_install_disk/data/busybox_config $(PKG_BUILD_DIR)/.config
#	CC=$(TOOLS_DIR2)/bin/x86_64-aaeon-linux-gnu-gcc 
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) ARCH=$(LFS_ARCH) CROSS_COMPILE=$(LFS_TARGET)- && \
	make -C $(PKG_BUILD_DIR) CONFIG_PREFIX=$(INSTALL_DISK_DIR)/rootfs install

#	touch $(PKG_BUILD_DIR)/Makefile
#	touch $(TOOLCHAIN_DIR2)/bin/bc



#$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
#	dfasdfasdfasdf
#	asdfasdf
#	asdfasdf  make CROSS_COMPILE=arm-linux-uclibcgnueabi-

#CROSS_COMPILE=$(LFS_TARGET)-

include scripts/build_rules.mk



