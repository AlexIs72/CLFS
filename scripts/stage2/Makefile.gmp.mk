include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME        =   gmp
PKG_VERSION     =   6.1.2
PKG_SUFFIX      =   stage2
#GMP_DIR         =   $(GCC_DIR)/$(GMP_NAME)
PKG_ARCHIVE     =   $(PKG_NAME)-$(PKG_VERSION).tar.bz2
#PKG_DIR         =   $(SRC_DIR)/$(PKG_FULL_NAME)
#PKG_SRC_DIR     =   $(SRC_DIR)/$(PKG_FULL_NAME)_$(PKG_SUFFIX)
PKG_BUILD_DIR   =   $(BUILD_DIR)/$(PKG_FULL_NAME)_$(PKG_SUFFIX)
#PKG_URL         =   https://ftp.gnu.org/gnu/gmp/$(PKG_ARCHIVE)
#GMP_SRC_FILE    =   $(DL_DIR)/$(GMP_ARCHIVE) 

DONE_MARKER_FILE =  $(call get_done_marker_file_name,$(PKG_FULL_NAME)_$(PKG_SUFFIX))

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install
	$(call touch_done_marker_file,$(PKG_FULL_NAME)_$(PKG_SUFFIX))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	CC_FOR_BUILD=gcc  \
	$(PKG_SRC_DIR)/configure \
	    --prefix=/$(TOOLS_DIR_NAME) \
	    --build=$(LFS_HOST) \
	    --host=$(LFS_TARGET) \
	    --enable-cxx

include scripts/build_rules.mk

#$(PKG_SRC_DIR)::
#	[ ! -d $(PKG_SRC_DIR) ] && mv $(PKG_DIR) $(PKG_SRC_DIR) || true


#LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}:/$(TOOLS_DIR_NAME)/lib