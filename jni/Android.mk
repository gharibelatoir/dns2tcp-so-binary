LOCAL_PATH := $(call my-dir)

# تعريف قائمة الملفات المشتركة
DNS2TCP_SRC := \
    ../client/options.c \
    ../client/socket.c \
    ../client/auth.c \
    ../client/requests.c \
    ../client/client.c \
    ../client/session.c \
    ../client/rr.c \
    ../client/queue.c \
    ../client/select.c \
    ../client/command.c \
    ../common/base64.c \
    ../common/dns.c \
    ../common/list.c \
    ../common/mycrypto.c \
    ../common/hmac_sha1.c \
    ../common/myrand.c \
    ../common/mystrnlen.c \
    ../common/config.c \
    ../common/memdump.c \
    ../common/crc16.c

# 1. بناء المكتبة المشتركة (.so) - هنا أضفنا ملف main.c وأوامر التصدير
include $(CLEAR_VARS)
LOCAL_MODULE    := dns2tcpc
LOCAL_CFLAGS    := -fcommon -Dfull_android -DJNI_BUILD
LOCAL_C_INCLUDES := $(LOCAL_PATH)
# أضفنا ../client/main.c هنا لكي تظهر دالة الـ JNI داخل الـ .so
LOCAL_SRC_FILES := ../client/main.c $(DNS2TCP_SRC)
LOCAL_LDLIBS    := -llog
# هذا السطر يمنع المترجم من حذف أسماء الدوال الديناميكية
LOCAL_LDFLAGS   := -Wl,--export-dynamic
include $(BUILD_SHARED_LIBRARY)

# 2. بناء الملف التنفيذي (Binary)
include $(CLEAR_VARS)
LOCAL_MODULE    := dns2tcpc_bin
LOCAL_CFLAGS    := -fcommon -Dfull_android
LOCAL_C_INCLUDES := $(LOCAL_PATH)
LOCAL_SRC_FILES := ../client/main.c $(DNS2TCP_SRC)
LOCAL_LDLIBS    := -llog
include $(BUILD_EXECUTABLE)
