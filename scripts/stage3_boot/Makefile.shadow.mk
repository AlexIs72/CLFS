include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	shadow
PKG_VERSION	    =	4.7
PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.xz
PKG_URL         =   https://github.com/shadow-maint/$(PKG_NAME)/releases/download/$(PKG_VERSION)/$(PKG_ARCHIVE)

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install
#	mv -v $(TOOLS_DIR2)/usr/bin/passwd $(TOOLS_DIR2)/bin
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR)
#	cp -v $(PKG_SRC_DIR)/src/Makefile.in{,.orig}        
#	sed -e 's/groups$(EXEEXT) //' \
#   -e 's/= nologin$(EXEEXT)/= /' \
#    -e 's/\(^suidu*bins = \).*/\1/' \
#    $(PKG_SRC_DIR)/src/Makefile.in.orig > $(PKG_SRC_DIR)/src/Makefile.in
	echo "shadow_cv_passwd_dir=$(TOOLS_DIR2)/bin" > $(PKG_BUILD_DIR)/config.cache
#	cp scripts/stage2/data/$(PKG_NAME)_config.cache $(PKG_BUILD_DIR)
	cd $(PKG_BUILD_DIR) && \
	$(CONFIGURE_FOR_CROSS_COMPILING) \
        --enable-subordinate-ids=no --cache-file=config.cache
	echo "#define ENABLE_SUBUIDS 1" >> $(PKG_BUILD_DIR)/config.h

#./configure --prefix=/tools \
#    --build=${CLFS_HOST} --host=${CLFS_TARGET} --cache-file=config.cache \
#    --enable-subordinate-ids=no


include scripts/build_rules.mk



