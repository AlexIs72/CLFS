include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk
include scripts/kernel_vars_4.19.86.mk
#3.16.80.mk

PKG_SUFFIX      =   stage3_install_disk
PKG_NAME        =   $(KERNEL_NAME)
#KERNEL_VERSION  =   3.16.80
PKG_VERSION     =   $(KERNEL_VERSION)
#4.19.86
PKG_ARCHIVE     =   $(KERNEL_ARCHIVE)
#$(PKG_FULL_NAME).tar.xz
PKG_URL         =   $(KERNEL_URL)
#https://cdn.kernel.org/pub/linux/kernel/v3.x/$(KERNEL_ARCHIVE)
#$(KERNEL_URL)
#https://cdn.kernel.org/pub/linux/kernel/v4.x/$(PKG_ARCHIVE)
#https://ftp.gnu.org/gnu/$(PKG_NAME)/$(PKG_ARCHIVE)
CONFIG_FILE     =   $(PKG_SRC_DIR)/include/.config
IMAGE_FILE      =   $(PKG_BUILD_DIR)/vmlinux
MODULES_DEP     =   $(INSTALL_DISK_DIR)/lib/modules/$(KERNEL_VERSION)/modules.dep
BOOT_FILE       =   $(INSTALL_DISK_DIR)/boot/vmlinuz
#/$(TOOLS_DIR_NAME)/include/linux/kernel.h
TOUCH_NAME      =   $(PKG_NAME)-$(PKG_VERSION)_$(PKG_SUFFIX)
PKG_BUILD_DIR   =   $(BUILD_DIR)/$(PKG_FULL_NAME)_$(PKG_SUFFIX)


DONE_MARKER_FILE :=  $(call get_done_marker_file_name,$(TOUCH_NAME))   

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(CONFIG_FILE) $(IMAGE_FILE) $(MODULES_DEP) $(BOOT_FILE)
#	cp -v $(PKG_BUILD_DIR)/System.map $(TOOLS_DIR2)/boot/System.map-$(KERNEL_VERSION)
#	cp -v $(PKG_BUILD_DIR)/.config $(TOOLS_DIR2)/boot/config-$(KERNEL_VERSION)
	$(call touch_done_marker_file,$(TOUCH_NAME))

$(MODULES_DEP):
#	make ARCH=$(TARGET_ARCH) CROSS_COMPILE=$(LFS_TARGET)- -C $(PKG_BUILD_DIR) \
#   INSTALL_MOD_PATH=$(INSTALL_DISK_DIR)/rootfs modules_install
#	make ARCH=$(TARGET_ARCH) CROSS_COMPILE=$(LFS_TARGET)- -C $(PKG_BUILD_DIR) \
#   INSTALL_MOD_PATH=$(TOOLS_DIR2) firmware_install

$(BOOT_FILE):
	mkdir -pv $(INSTALL_DISK_DIR)/boot && \
    cp -v $(PKG_BUILD_DIR)/arch/$(TARGET_ARCH)/boot/bzImage $(BOOT_FILE)

$(IMAGE_FILE): 
	cd $(PKG_SRC_DIR) && \
	make -j $(NUM_CPU) ARCH=$(TARGET_ARCH) CROSS_COMPILE=$(LFS_TARGET)- O=$(PKG_BUILD_DIR)
	$(call touch_done_marker_file,$(TOUCH_NAME))

$(CONFIG_FILE) : $(PKG_SRC_DIR)
	mkdir -p  $(PKG_BUILD_DIR)
	cd $(PKG_SRC_DIR) && \
	make mrproper && \
	cp $(PWD)/scripts/stage3_install_disk/data/linux_config $(PKG_BUILD_DIR)/.config
     


#	make ARCH=$(TARGET_ARCH) CROSS_COMPILE=$(LFS_TARGET)- menuconfig


#	make ARCH=x86_64 headers_check && \
#	make INSTALL_HDR_PATH=dest headers_install && \
#	cp -rv dest/include/* $(TOOLS_DIR2)/include


#make mrproper
#make ARCH=x86_64 headers_check
#make ARCH=x86_64 INSTALL_HDR_PATH=/tools headers_install
#		

include scripts/build_rules.mk