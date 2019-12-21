include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk

SYS_DIR_NAMES   =   bin sys dev proc etc
SYS_DIRS        =   $(addprefix $(INSTALL_DISK_DIR)/rootfs/,$(SYS_DIR_NAMES))
DEVICES_LIST    =   console null tty1 tty2 ram0
#ramdisk ram0 
DEVICES         =   $(addprefix $(INSTALL_DISK_DIR)/rootfs/dev/,$(DEVICES_LIST))
TARGET_CPIO     =   $(INSTALL_DISK_DIR)/ramdisk.cpio
TARGET          =   $(TARGET_CPIO).gz
#

$(TARGET): prepare 
	(cd $(INSTALL_DISK_DIR)/rootfs && find . | cpio -o -H newc > $(TARGET_CPIO))
	gzip -f -9 -n -c $(TARGET_CPIO) > $(TARGET)


prepare: $(SYS_DIRS) 
#$(DEVICES)
	cp scripts/stage3_install_disk/data/fstab $(INSTALL_DISK_DIR)/rootfs/etc
#	ln -s /sbin/init  $(INSTALL_DISK_DIR)/rootfs/init
	rm -f $(INSTALL_DISK_DIR)/rootfs/linuxrc    
	cp scripts/stage3_install_disk/data/init $(INSTALL_DISK_DIR)/rootfs/
	mkdir -p $(INSTALL_DISK_DIR)/rootfs/{lib,mnt/root}
#	cp -R $(TOOLS_DIR2)/lib/modules $(INSTALL_DISK_DIR)/rootfs/lib/
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
