include scripts/common_vars.mk

PKG_NAME        =   gcc
PKG_VERSION     =   9.2.0
#7.3.0
#9.2.0
#PKG_FULL_NAME   =   $(PKG_NAME)-$(PKG_VERSION)
#PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.gz
#PKG_URL         =   https://ftp.gnu.org/gnu/$(PKG_NAME)/$(PKG_FULL_NAME)/$(PKG_ARCHIVE)
#                    https://ftp.gnu.org/gnu/gcc/gcc-7.3.0/

#PKG_DIR         =   $(BUILD_DIR)/$(PKG_FULL_NAME)
#PKG_PASS_DIR    =   $(PKG_DIR)_$(PKG_SUFFIX)
#PKG_BUILD_DIR   =   $(PKG_PASS_DIR)/.build

PKG_DIR         =   $(SRC_DIR)/$(PKG_FULL_NAME)
#PKG_SRC_DIR     =   $(SRC_DIR)/$(PKG_FULL_NAME)_$(PKG_SUFFIX)
PKG_BUILD_DIR   =   $(BUILD_DIR)/$(PKG_FULL_NAME)_$(PKG_SUFFIX)

#PKG_SRC_FILE    =   $(DL_DIR)/$(PKG_ARCHIVE)    

#DONE_MARKER_FILE =  $(call get_done_marker_file_name,$(PKG_NAME),$(PKG_FULL_NAME))
DONE_MARKER_FILE =  $(call get_done_marker_file_name,$(PKG_FULL_NAME))
