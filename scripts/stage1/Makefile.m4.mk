include env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	m4
PKG_VERSION	    =	1.4.18

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
#	cd $(PKG_SRC_DIR) && \
#	sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c && \
#	echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h 
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/configure \
	    --prefix=/$(TOOLCHAIN_DIR_NAME) 
#	touch Makefile

include scripts/build_rules.mk



