include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	bzip2
PKG_VERSION	    =	1.0.8
PKG_URL	    	=	https://www.sourceware.org/pub/$(PKG_NAME)/$(PKG_ARCHIVE)

$(DONE_MARKER_FILE): $(PKG_DIR)
	cd $(PKG_DIR) && \
	cp -v Makefile{,.orig} && \
	sed -e 's@^\(all:.*\) test@\1@g' Makefile.orig > Makefile
	make -C $(PKG_DIR) CC="$(CC)" AR=$(AR) RANLIB=$(RANLIB)
	make -C $(PKG_DIR) PREFIX=/$(TOOLS_DIR_NAME) install
	$(call touch_done_marker_file,$(PKG_FULL_NAME))


$(PKG_DIR): $(PKG_SRC_FILE)
	echo "Extract files $(PKG_SRC_FILE) ..."
	cd $(BUILD_DIR) && tar -xzvf $(PKG_SRC_FILE)  > /dev/null


include scripts/build_rules.mk



