include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	gettext
PKG_VERSION	    =	0.20.1
PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.xz

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
#	cd $(PKG_BUILD_DIR) && 
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	cp -v $(PKG_BUILD_DIR)/gettext-tools/src/{msgfmt,msgmerge,xgettext} /$(TOOLS_DIR_NAME)/bin
#	make -C $(PKG_BUILD_DIR)/gnulib-lib -j $(NUM_CPU) && \
#	make -C $(PKG_BUILD_DIR)/src -j $(NUM_CPU) msgfmt && \
#	cd $(PKG_BUILD_DIR) && cp -v src/msgfmt /$(TOOLS_DIR_NAME)/bin
#	make -C $(PKG_BUILD_DIR) install
#	ln -sv bash /$(TOOLCHAIN_DIR_NAME)/bin/sh || true
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR)
	echo "gl_cv_func_wcwidth_works=yes" > $(PKG_BUILD_DIR)/config.cache
	cd $(PKG_BUILD_DIR) && \
	$(CONFIGURE_FOR_CROSS_COMPILING) \
        --disable-shared --cache-file=config.cache

include scripts/build_rules.mk



