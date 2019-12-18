include env.mk
include scripts/macros.mk
include scripts/common_vars.mk


#GCC_DIR         ?= .
PKG_NAME       =   mpfr
PKG_VERSION    =   4.0.2
PKG_SUFFIX     =   stage1
#MPFR_DIR        =   $(GCC_DIR)/$(MPFR_NAME)
#MPFR_ARCHIVE    =   $(MPFR_NAME)-$(MPFR_VERSION).tar.gz
PKG_URL        =   https://www.mpfr.org/mpfr-current/$(PKG_ARCHIVE)
#MPFR_SRC_FILE   =   $(DL_DIR)/$(MPFR_ARCHIVE)      
#PKG_DIR         =   $(SRC_DIR)/$(PKG_FULL_NAME)
#PKG_SRC_DIR     =   $(SRC_DIR)/$(PKG_FULL_NAME)_$(PKG_SUFFIX)
PKG_BUILD_DIR   =   $(BUILD_DIR)/$(PKG_FULL_NAME)_$(PKG_SUFFIX)

DONE_MARKER_FILE =  $(call get_done_marker_file_name,$(PKG_FULL_NAME)_$(PKG_SUFFIX))

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install
	$(call touch_done_marker_file,$(PKG_FULL_NAME)_$(PKG_SUFFIX))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/configure \
	    --prefix=/$(TOOLCHAIN_DIR_NAME) --disable-static --with-gmp=/$(TOOLCHAIN_DIR_NAME)


#mpfr: $(MPFR_DIR)

#$(MPFR_DIR): $(MPFR_SRC_FILE)
#	echo "Extract files $(MPFR_SRC_FILE) ..."
#	cd $(GCC_DIR) && \
#	tar -xzvf $(MPFR_SRC_FILE)  > /dev/null && \
#	ln -s $(MPFR_NAME)-$(MPFR_VERSION) $(MPFR_DIR)

#$(MPFR_SRC_FILE):
#	wget --continue --directory-prefix=$(DL_DIR) $(MPFR_URL)

include scripts/build_rules.mk

#$(PKG_SRC_DIR)::
#	[ ! -d $(PKG_SRC_DIR) ] && mv $(PKG_DIR) $(PKG_SRC_DIR) || true
