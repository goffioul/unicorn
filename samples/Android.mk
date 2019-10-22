LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := unicorn-sample-arm
LOCAL_SRC_FILES := sample_arm.c
LOCAL_STATIC_LIBRARIES := libunicorn
LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/../include
LOCAL_CFLAGS := -Wno-unused-parameter
include $(BUILD_EXECUTABLE)
