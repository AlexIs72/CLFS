include cross_env.mk
include scripts/macros.mk
include scripts/common_vars.mk
include scripts/stage1/gcc_vars.mk

#PKG_NAME        =   gcc
#PKG_VERSION     =   9.2.0
PKG_SUFFIX      =   stage2

DONE_MARKER_FILE =  $(call get_done_marker_file_name,$(PKG_FULL_NAME)_$(PKG_SUFFIX))

all: $(DONE_MARKER_FILE) 
#/$(TOOLS_DIR_NAME)/include/limits.h

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
#	cd $(PKG_SRC_DIR) && cp -v Makefile{,.orig} && \
#	sed "/^HOST_\(GMP\|ISL\|CLOOG\)\(LIBS\|INC\)/s:/$(TOOLS_DIR_NAME):/$(TOOLCHAIN_DIR_NAME):g" \
#    Makefile.orig > Makefile
	echo $(AS)
	echo $(LD)
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) AS_FOR_TARGET=$(AS) LD_FOR_TARGET=$(LD) && \
	make -C $(PKG_BUILD_DIR) install
	cp -v $(PKG_SRC_DIR)/include/libiberty.h /$(TOOLS_DIR_NAME)/include
	$(call touch_done_marker_file,$(PKG_FULL_NAME)_$(PKG_SUFFIX))


$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
#	cd $(PKG_SRC_DIR) && \
#	echo -en '\n#undef STANDARD_STARTFILE_PREFIX_1\n#define STANDARD_STARTFILE_PREFIX_1 "/$(TOOLS_DIR_NAME)/lib/"\n' >> gcc/config/linux.h && \
#	echo -en '\n#undef STANDARD_STARTFILE_PREFIX_2\n#define STANDARD_STARTFILE_PREFIX_2 ""\n' >> gcc/config/linux.h 
	echo $(AS)
	echo $(LD)
	echo "Configure $(PKG_FULL_NAME) ..."
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	AS_FOR_TARGET=$(AS) AS_FOR_BUILD=$(AS) $(PKG_SRC_DIR)/configure \
	    --prefix=/$(TOOLS_DIR_NAME) \
	    --build=$(LFS_HOST) \
	    --host=$(LFS_TARGET) \
	    --target=$(LFS_TARGET) \
	    --with-mpfr=/$(TOOLCHAIN_DIR_NAME) \
	    --with-gmp=/$(TOOLCHAIN_DIR_NAME) \
	    --with-mpc=/$(TOOLCHAIN_DIR_NAME) \
	    --with-local-prefix=/$(TOOLS_DIR_NAME) \
	    --with-native-system-header-dir=/$(TOOLS_DIR_NAME)/include \
        --disable-multilib --disable-nls \
        --enable-languages=c,c++ --disable-libstdcxx-pch --with-system-zlib \
        --disable-libssp \
        --enable-checking=release --enable-libstdcxx-time

include scripts/build_rules.mk


#$(PKG_SRC_DIR)::
#	scripts/stage1/bin/fix_gcc_includes.sh $(PKG_SRC_DIR) $(TOOLS_DIR_NAME)


#	[ ! -d $(PKG_SRC_DIR) ] && mv $(PKG_DIR) $(PKG_SRC_DIR) || true


# LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/$(TOOLCHAIN_DIR_NAME)/lib
