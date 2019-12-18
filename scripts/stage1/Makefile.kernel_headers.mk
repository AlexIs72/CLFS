include env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME        =   $(KERNEL_NAME)
PKG_VERSION     =   $(KERNEL_VERSION)
#4.19.86
PKG_ARCHIVE     =   $(KERNEL_ARCHIVE)
#$(PKG_FULL_NAME).tar.xz
PKG_URL         =   $(KERNEL_URL)
#https://cdn.kernel.org/pub/linux/kernel/v4.x/$(PKG_ARCHIVE)
#https://ftp.gnu.org/gnu/$(PKG_NAME)/$(PKG_ARCHIVE)
TARGET_FILE     =   $(TOOLS_DIR2)/include/linux/kernel.h
#/$(TOOLS_DIR_NAME)/include/linux/kernel.h
TOUCH_NAME      =   $(PKG_NAME)_headers-$(PKG_VERSION)


DONE_MARKER_FILE :=  $(call get_done_marker_file_name,$(TOUCH_NAME))   

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(TARGET_FILE)
	$(call touch_done_marker_file,$(TOUCH_NAME))

$(TARGET_FILE) : $(PKG_SRC_DIR)
	mkdir -p $(TOOLS_DIR2)/include
	cd $(PKG_SRC_DIR) && \
	make mrproper && \
	make ARCH=$(TARGET_ARCH) headers_check && \
	make INSTALL_HDR_PATH=dest headers_install && \
	cp -rv dest/include/* $(TOOLS_DIR2)/include


#make mrproper
#make ARCH=x86_64 headers_check
#make ARCH=x86_64 INSTALL_HDR_PATH=/tools headers_install
#		

include scripts/build_rules.mk