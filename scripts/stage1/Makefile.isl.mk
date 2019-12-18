include env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	isl
PKG_VERSION	    =	0.22
PKG_SUFFIX      =   stage1
#PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.lzma
PKG_URL	    	=	http://isl.gforge.inria.fr/$(PKG_ARCHIVE)
#ftp://ftp.astron.com/pub/$(PKG_NAME)/$(PKG_ARCHIVE)
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
	LDFLAGS="-Wl,-rpath,/$(TOOLCHAIN_DIR_NAME)/lib" \
	$(PKG_SRC_DIR)/configure \
	    --prefix=/$(TOOLCHAIN_DIR_NAME) --disable-static --with-gmp-prefix=/$(TOOLCHAIN_DIR_NAME)

include scripts/build_rules.mk

#$(PKG_SRC_DIR)::
#	[ ! -d $(PKG_SRC_DIR) ] && mv $(PKG_DIR) $(PKG_SRC_DIR) || true


