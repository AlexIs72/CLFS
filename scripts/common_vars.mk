TARGET_ARCH     =   x86_64
BUILD64         =   -m64
PKG_FULL_NAME   =   $(PKG_NAME)-$(PKG_VERSION)
PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.gz
PKG_URL         =   https://ftp.gnu.org/gnu/$(PKG_NAME)/$(PKG_ARCHIVE)
#KERNEL_NAME     =   linux
#KERNEL_VERSION  =   4.19.86
#KERNEL_ARCHIVE  =   $(KERNEL_NAME)-$(KERNEL_VERSION).tar.xz
#KERNEL_URL      =   https://cdn.kernel.org/pub/linux/kernel/v4.x/$(KERNEL_ARCHIVE)

#PKG_URL         =   https://ftp.gnu.org/gnu/$(PKG_NAME)/$(PKG_FULL_NAME)/$(PKG_ARCHIVE)
#                    https://ftp.gnu.org/gnu/gcc/gcc-7.3.0/

PKG_DIR         =   $(BUILD_DIR)/$(PKG_FULL_NAME)
PKG_SRC_DIR     =   $(SRC_DIR)/$(PKG_FULL_NAME)
PKG_SRC_FILE    =   $(DL_DIR)/$(PKG_ARCHIVE)    
PKG_PASS_DIR    =   $(PKG_DIR)_$(PKG_SUFFIX)
PKG_BUILD_DIR   =   $(PKG_DIR)

CONFIGURE_SCRIPT = $(PKG_SRC_DIR)/configure
#/.build

#DONE_MARKER_FILE =  $(call get_done_marker_file_name,$(PKG_NAME),$(PKG_VERSION))
DONE_MARKER_FILE =  $(call get_done_marker_file_name,$(PKG_FULL_NAME))

CONFIGURE       =   $(CONFIGURE_SCRIPT) --prefix=/$(TOOLCHAIN_DIR_NAME)
CONFIGURE_FOR_CROSS_COMPILING = $(CONFIGURE_SCRIPT) --prefix=/$(TOOLS_DIR_NAME) --build=$(LFS_HOST) --host=$(LFS_TARGET) 

