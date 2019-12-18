include env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME        =   linux
PKG_VERSION     =   4.19.86
#PKG_FULL_NAME   =   $(PKG_NAME)-$(PKG_VERSION)
PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.xz
PKG_URL         =   https://cdn.kernel.org/pub/linux/kernel/v4.x/$(PKG_ARCHIVE)
#https://ftp.gnu.org/gnu/$(PKG_NAME)/$(PKG_ARCHIVE)
#PKG_DIR         =   $(BUILD_DIR)/$(PKG_FULL_NAME)
#PKG_BUILD_DIR   =   $(PKG_DIR)
#PKG_SRC_FILE    =   $(DL_DIR)/$(PKG_ARCHIVE)    
TARGET_FILE     =   /$(TOOLCHAIN_DIR_NAME)/include/linux/kernel.h

DONE_MARKER_FILE :=  $(call get_done_marker_file_name,$(PKG_NAME)_headers,$(PKG_VERSION))   

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(TARGET_FILE)
	$(call touch_done_marker_file,$(PKG_NAME)_headers,$(PKG_VERSION))

$(TARGET_FILE) : $(PKG_SRC_DIR)
	cd $(PKG_SRC_DIR) && \
	make mrproper && \
	make INSTALL_HDR_PATH=dest headers_install && \
	cp -rv dest/include/* /$(TOOLCHAIN_DIR_NAME)/include

#$(PKG_DIR): $(PKG_SRC_FILE)
#	cd $(BUILD_DIR) && tar -xJvf $(PKG_SRC_FILE)  > /dev/null

#$(PKG_SRC_FILE):
#	wget --continue --directory-prefix=$(DL_DIR) $(PKG_URL)
#
#		

include scripts/build_rules.mk