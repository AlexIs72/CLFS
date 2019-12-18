$(TOOLCHAIN_DIR) $(ROOTFS_DIR) $(LOG_DIR) $(DL_DIR) $(BUILD_DIR):
	mkdir -pv $@

$(PKG_SRC_FILE):
	wget --continue --directory-prefix=$(DL_DIR) $(PKG_URL)

$(PKG_SRC_DIR):: $(PKG_SRC_FILE)
#    echo $(suffix $(PKG_SRC_FILE))
	@echo "Extract files $(PKG_SRC_FILE) ..."
	@extract_cmd=""; \
	ext=$(suffix $(PKG_SRC_FILE)); \
	if [ "$$ext" = ".gz" ]; \
	then \
	    extract_cmd=xzvf;\
	elif [ "$$ext" = ".xz" ]; \
	then \
	    extract_cmd=xJvf; \
	elif [ "$$ext" = ".bz2" ]; \
	then \
	    extract_cmd=xjvf; \
	elif [ "$$ext" = ".lzma" ]; \
	then \
	    extract_cmd="--lzma -xvf"; \
	else \
	    echo "Unknown archive extension!!!"; exit 1; \
	fi; \
	cd $(SRC_DIR) && /bin/tar $$extract_cmd $(PKG_SRC_FILE)  > /dev/null
	touch $(PKG_SRC_DIR)
#	@[ ! -z "$(PKG_SRC_DIR)" ] &&  mv $(PKG_SRC_DIR) $(PKG_DIR) || true

#$(PKG_PASS_DIR):: $(PKG_DIR)
#	mv $(PKG_DIR) $(PKG_PASS_DIR)

#$(DONE_MARKER_FILE):: $(PKG_BUILD_DIR)/Makefile
#	cd $(PKG_BUILD_DIR) && make -j $(NUM_CPU) && make install
#	$(call touch_done_marker_file,$(PKG_NAME),$(PKG_VERSION))
#--lzma