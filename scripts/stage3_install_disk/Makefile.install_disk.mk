include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk
include scripts/kernel_vars_4.19.86.mk
#3.16.80.mk

#SYS_DIR_NAMES   =   bin sys dev proc etc
#SYS_DIRS        =   $(addprefix $(INITRD_STAGE_DIR)/,$(SYS_DIR_NAMES))
#DEVICES_LIST    =   console null tty1 tty2 ram0
#ramdisk ram0 
#DEVICES         =   $(addprefix $(INITRD_STAGE_DIR)/dev/,$(DEVICES_LIST))
#TARGET_CPIO     =   $(INSTALL_DISK_DIR)/ramdisk.cpio
PKG_SUFFIX      =   stage3_install_disk
PKG_NAME        =   $(KERNEL_NAME)
PKG_VERSION     =   $(KERNEL_VERSION)
PKG_ARCHIVE     =   $(KERNEL_ARCHIVE)

PKG_BUILD_DIR   =   $(BUILD_DIR)/$(PKG_FULL_NAME)_$(PKG_SUFFIX)
TARGET          =   $(INSTALL_DISK_DIR)/install_disk.iso
TMP_IMAGE       =   $(INSTALL_DISK_DIR)/install_disk.image
INITRD          =   $(INSTALL_DISK_DIR)/ramdisk.cpio.gz
#

#all:  

$(TARGET): $(TMP_IMAGE)
	mkdir -p $(INSTALL_DISK_DIR)/mount
	cp -R scripts/efi_loader/* $(INSTALL_DISK_DIR)/mount
#	cp -v $(PKG_BUILD_DIR)/vmlinux $(INSTALL_DISK_DIR)/mount/vmlinuz
	cp -v $(INSTALL_DISK_DIR)/boot/vmlinuz $(INSTALL_DISK_DIR)/mount/vmlinuz
#	cp -v $(PKG_BUILD_DIR)/arch/$(TARGET_ARCH)/boot/bzImage $(INSTALL_DISK_DIR)/mount/vmlinuz
#	cp $(TOOLS_DIR2)/boot/vmlinuz-clfs-$(KERNEL_VERSION) $(INSTALL_DISK_DIR)/mount/vmlinuz
	cp $(INITRD) $(INSTALL_DISK_DIR)/mount/initrd
	mcopy -i $(TMP_IMAGE) -s $(INSTALL_DISK_DIR)/mount/* ::/
#	mcopy -i $(TMP_IMAGE) -s scripts/efi_loader/* ::/
#	guestmount -a $(TMP_IMAGE) -i $(INSTALL_DISK_DIR)/mount
#	(cd $(INSTALL_DISK_DIR)/rootfs && find . | cpio -o -H newc > $(TARGET_CPIO))
#	gzip -f -9 -n -c $(TARGET_CPIO) > $(TARGET)

$(TMP_IMAGE):
	dd if=/dev/zero of=$@ bs=100M count=25
	/sbin/parted -s $@ --script mktable gpt
	/sbin/parted -s $@ --script mkpart EFI fat32 1MiB 10MiB
	/sbin/parted -s $@ --script set 1 msftdata on
	/sbin/parted -s $@ --script set 1 boot on
	/sbin/mkfs.vfat -n EFI $@

prepare: $(SYS_DIRS) $(DEVICES)
	cp scripts/stage3_initrd/data/fstab $(INSTALL_DISK_DIR)/rootfs/etc
#	echo $(DEVICES)
#	echo $(SYS_DIRS)

$(SYS_DIRS):
	mkdir $@
#$(INSTALL_DISK_DIR)/rootfs/$@


$(INSTALL_DISK_DIR)/rootfs/dev/console:
	mknod -m 600 $@ c 5 1

$(INSTALL_DISK_DIR)/rootfs/dev/null:
	mknod -m 600 $@ c 1 3


$(INSTALL_DISK_DIR)/rootfs/dev/tty1:
	mknod -m 600 $@ c 4 1

$(INSTALL_DISK_DIR)/rootfs/dev/tty2:
	mknod -m 600 $@ c 4 2

$(INSTALL_DISK_DIR)/rootfs/dev/ram0:
	mknod -m 660 $@ c 4 2

#mknod -m 660 /dev/ram0 b 1 0

#$(DEVICES):
#	cp -a /dev/$@ $(INSTALL_DISK_DIR)/rootfs/dev/

include scripts/build_rules.mk


#    mknod -m 600 ${ROOTFS_DIR}/dev/console c 5 1
#    [ ! -c ${ROOTFS_DIR}/dev/null ] && 
#    mknod -m 666 ${ROOTFS_DIR}/dev/null c 1 3
