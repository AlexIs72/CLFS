get_done_marker_file_name = $(BUILD_DIR)/$(1).done

define touch_done_marker_file
#    touch_file=$(call get_done_marker_file_name,$(1),$(2))
    touch $(call get_done_marker_file_name,$(1))
#    touch $(BUILD_DIR)/$(1)-$(2).done
endef

