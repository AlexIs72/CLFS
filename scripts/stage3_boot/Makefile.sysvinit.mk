include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	sysvinit
PKG_VERSION	    =	2.95
PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.xz
PKG_URL         =   http://download.savannah.gnu.org/releases/$(PKG_NAME)/$(PKG_ARCHIVE)
#https://github.com/shadow-maint/$(PKG_NAME)/releases/download/$(PKG_VERSION)/shadow-4.7.tar.xz

SRC_DIR         =   $(BUILD_DIR)

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_SRC_DIR)
	make -C $(PKG_BUILD_DIR)/src -j $(NUM_CPU) clobber && \
	make -C $(PKG_BUILD_DIR)/src -j $(NUM_CPU) CC="$(CC)" && \
	make -C $(PKG_BUILD_DIR)/src ROOT=$(TOOLS_DIR2) install
	cp scripts/stage3_boot/data/inittab $(PKG_BUILD_DIR)/etc
	$(call touch_done_marker_file,$(PKG_FULL_NAME))

include scripts/build_rules.mk



