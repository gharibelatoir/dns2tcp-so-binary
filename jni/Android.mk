LOCAL_PATH := $(call my-dir)/..

include $(CLEAR_VARS)

LOCAL_MODULE    := dns2tcpc
LOCAL_CFLAGS    := -fcommon -Dfull_android

# تجميع كل الملفات الضرورية من مجلدات المشروع
LOCAL_SRC_FILES := \
    client/main.c \
    client/options.c \
    client/socket.c \
    client/auth.c \
    client/requests.c \
    common/base64.c \
    common/compression.c \
    common/list.c

LOCAL_LDLIBS := -llog

include $(BUILD_SHARED_LIBRARY) # لإنتاج ملف .so

include $(CLEAR_VARS)
LOCAL_MODULE    := dns2tcpc_bin
LOCAL_SRC_FILES := $(LOCAL_SRC_FILES)
LOCAL_CFLAGS    := -fcommon -Dfull_android
include $(BUILD_EXECUTABLE) # لإنتاج ملف تنفيذي (Binary)
