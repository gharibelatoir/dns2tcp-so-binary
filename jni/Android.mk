LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE    := dns2tcpc
LOCAL_CFLAGS    := -fcommon -Dfull_android
LOCAL_C_INCLUDES := $(LOCAL_PATH)

# قائمة الملفات الموجودة فعلياً في مجلداتك
LOCAL_SRC_FILES := \
    ../client/main.c \
    ../client/options.c \
    ../client/socket.c \
    ../client/auth.c \
    ../client/requests.c \
    ../client/client.c \
    ../client/session.c \
    ../common/base64.c \
    ../common/dns.c \
    ../common/list.c \
    ../common/mycrypto.c \
    ../common/hmac_sha1.c \
    ../common/myrand.c

LOCAL_LDLIBS := -llog
include $(BUILD_SHARED_LIBRARY)

# بناء الملف التنفيذي
include $(CLEAR_VARS)
LOCAL_MODULE    := dns2tcpc_bin
LOCAL_C_INCLUDES := $(LOCAL_C_INCLUDES)
LOCAL_SRC_FILES := $(LOCAL_SRC_FILES)
LOCAL_CFLAGS    := -fcommon -Dfull_android
include $(BUILD_EXECUTABLE)
