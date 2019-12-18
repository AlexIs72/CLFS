#$(DONE_MARKER_FILE):  $(PKG_BUILD_DIR)/Makefile
#	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && make -C $(PKG_BUILD_DIR) install
#	$(call touch_done_marker_file,$(PKG_NAME),$(PKG_FULL_NAME))

#$(PKG_SRC_DIR)::
#	scripts/stage1/bin/fix_gcc_includes.sh $(PKG_SRC_DIR) $(TOOLCHAIN_DIR_NAME)
#	make -f scripts/stage1/Makefile.mpfr.mk GCC_DIR=$(PKG_SRC_DIR)
#	make -f scripts/stage1/Makefile.gmp.mk GCC_DIR=$(PKG_SRC_DIR)
#	make -f scripts/stage1/Makefile.mpc.mk GCC_DIR=$(PKG_SRC_DIR)

#$(PKG_PASS_DIR):: $(PKG_DIR) $(MPFR_SRC_FILE) $(GMP_SRC_FILE) $(MPC_SRC_FILE)
#	mv $(PKG_DIR) $(PKG_PASS_DIR)
#	make -f scripts/stage1/Makefile.mpfr.mk GCC_DIR=$(PKG_SRC_DIR)
#	make -f scripts/stage1/Makefile.gmp.mk GCC_DIR=$(PKG_SRC_DIR)
#	make -f scripts/stage1/Makefile.mpc.mk GCC_DIR=$(PKG_SRC_DIR)

