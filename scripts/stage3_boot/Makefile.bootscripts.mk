include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk


#   bootscripts/ is for the bootscripts with the sysvinit book
#   boot-scripts/ is for the boot method with the systemd book
#   To generate a distributable tarball, run in either directory:
#   make dist
##
#

SRC_DIR_NAME    =   bootscripts-standard
PKG_URL         =   https://github.com/cross-lfs/$(SRC_DIR_NAME).git
SRC_DIR         =   $(BUILD_DIR)/$(SRC_DIR_NAME)
PKG_FULL_NAME   =   bootscripts


$(DONE_MARKER_FILE): $(TOOLS_DIR2)/etc/rc.d
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(TOOLS_DIR2)/etc/rc.d: $(SRC_DIR)
	make -C $(SRC_DIR)/bootscripts DESTDIR=$(TOOLS_DIR2) install-minimal
#make -C $(SRC_DIR)/$(SRC_DIR_NAME) dist


$(SRC_DIR): 
	cd $(BUILD_DIR) && git clone $(PKG_URL)