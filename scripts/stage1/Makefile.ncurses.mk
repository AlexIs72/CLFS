include env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	ncurses
PKG_VERSION	    =	6.1
PKG_SUFFIX      =   stage1
PKG_BUILD_DIR   =   $(BUILD_DIR)/$(PKG_FULL_NAME)_$(PKG_SUFFIX)

DONE_MARKER_FILE =  $(call get_done_marker_file_name,$(PKG_FULL_NAME)_$(PKG_SUFFIX))


all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
#	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
#	make -C $(PKG_BUILD_DIR) install
#	cd /$(TOOLCHAIN_DIR_NAME)/lib && ln -s libncursesw.so /$(TOOLCHAIN_DIR_NAME)/lib/libncurses.so
	make -C $(PKG_BUILD_DIR)/include
	make -C $(PKG_BUILD_DIR)/progs tic
	cd $(PKG_BUILD_DIR) && install -v -m755 progs/tic /$(TOOLCHAIN_DIR_NAME)/bin
	$(call touch_done_marker_file,$(PKG_FULL_NAME)_$(PKG_SUFFIX))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/configure \
	    --prefix=/$(TOOLCHAIN_DIR_NAME) \
	    --without-shared   \
	    --without-debug \
	    --without-ada   \
	    --enable-widec  \
	    --enable-overwrite
#	touch Makefile

include scripts/build_rules.mk



