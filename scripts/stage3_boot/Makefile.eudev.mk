include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	eudev
PKG_VERSION	    =	3.2.8
#PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.xz
PKG_URL         =   https://dev.gentoo.org/~blueness/$(PKG_NAME)/$(PKG_ARCHIVE)
#eudev-3.2.8.tar.gz
#https://www.kernel.org/pub/linux/utils/kernel/$(PKG_NAME)/$(PKG_ARCHIVE)

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) install
	install -dv $(TOOLS_DIR2)/lib/firmware
	echo "# dummy, so that network is once again on eth*" > \
    $(TOOLS_DIR2)/etc/udev/rules.d/80-net-name-slot.rules
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR)
	cd $(PKG_BUILD_DIR) && \
	$(CONFIGURE_FOR_CROSS_COMPILING) \
    --disable-introspection --disable-gtk-doc-html \
    --disable-gudev --disable-keymap --with-firmware-path=/tools/lib/firmware \
    --enable-libkmod
#	sed -i '/keyboard_lookup_key/d' $(PKG_SRC_DIR)/src/udev/udev-builtin-keyboard.c


include scripts/build_rules.mk



