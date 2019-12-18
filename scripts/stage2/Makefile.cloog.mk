include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	cloog
PKG_VERSION	    =	0.18.4
PKG_SUFFIX      =   stage2
PKG_URL	    	=	http://www.bastoul.net/$(PKG_NAME)/pages/download/$(PKG_ARCHIVE)
PKG_BUILD_DIR   =   $(BUILD_DIR)/$(PKG_FULL_NAME)_$(PKG_SUFFIX)
#ftp://ftp.astron.com/pub/$(PKG_NAME)/$(PKG_ARCHIVE)

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
	    --prefix=/$(TOOLS_DIR_NAME) \
	    --build=$(LFS_HOST) \
	    --host=$(LFS_TARGET) \
	    --with-gmp-prefix=/$(TOOLS_DIR_NAME) \
	    --with-isl=system && \
	cp -v Makefile{,.orig} && \
	sed '/cmake/d' Makefile.orig > Makefile

#	    --with-gmp-prefix=/$(TOOLCHAIN_DIR_NAME) 

#--build=${CLFS_HOST} --host=${CLFS_TARGET} \

include scripts/build_rules.mk

#	LDFLAGS="-Wl,-rpath,/$(TOOLCHAIN_DIR_NAME)/lib" \


