LOCAL_PATH := $(call my-dir)

QEMU_TARGET_SRC := \
	qemu/target-arm/cpu.c		\
	qemu/target-arm/unicorn_arm.c	\
	qemu/target-arm/crypto_helper.c	\
	qemu/target-arm/helper.c	\
	qemu/target-arm/op_helper.c	\
	qemu/target-arm/psci.c		\
	qemu/target-arm/translate.c	\
	qemu/target-arm/iwmmxt_helper.c	\
	qemu/target-arm/neon_helper.c	\
	qemu/ioport.c			\
	qemu/cpus.c			\
	qemu/cpu-exec.c			\
	qemu/translate-all.c		\
	qemu/memory_mapping.c		\
	qemu/cputlb.c			\
	qemu/tcg/optimize.c		\
	qemu/tcg/tcg.c			\
	qemu/hw/arm/virt.c		\
	qemu/hw/arm/tosa.c		\
	qemu/memory.c			\
	qemu/fpu/softfloat.c		\
	qemu/exec.c

QEMU_CORE_SRC_GENERATED := \
	qemu-gen/qapi-visit.c	\
	qemu-gen/qapi-types.c

QEMU_CORE_SRC := \
	$(QEMU_CORE_SRC_GENERATED)		\
       	qemu/util/crc32c.c			\
	qemu/util/bitops.c			\
	qemu/util/host-utils.c			\
	qemu/util/module.c			\
	qemu/util/qemu-thread-posix.c		\
	qemu/util/bitmap.c			\
	qemu/util/aes.c				\
	qemu/util/cutils.c			\
	qemu/util/oslib-posix.c			\
	qemu/util/qemu-timer-common.c		\
	qemu/util/getauxval.c			\
	qemu/util/error.c			\
	qemu/glib_compat.c			\
	qemu/tcg-runtime.c			\
	qemu/vl.c				\
	qemu/accel.c				\
	qemu/qemu-log.c				\
	qemu/qemu-timer.c			\
	qemu/qom/cpu.c				\
	qemu/qom/object.c			\
	qemu/qom/qom-qobject.c			\
	qemu/qom/container.c			\
	qemu/hw/core/qdev.c			\
	qemu/hw/core/machine.c			\
	qemu/qapi/qapi-visit-core.c		\
	qemu/qapi/qmp-input-visitor.c		\
	qemu/qapi/qmp-output-visitor.c		\
	qemu/qapi/qapi-dealloc-visitor.c	\
	qemu/qapi/string-input-visitor.c	\
	qemu/qobject/qdict.c			\
	qemu/qobject/qlist.c			\
	qemu/qobject/qstring.c			\
	qemu/qobject/qint.c			\
	qemu/qobject/qbool.c			\
	qemu/qobject/qerror.c			\
	qemu/qobject/qfloat.c

QEMU_CFLAGS := \
	-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE		\
	-Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings	\
	-Wmissing-prototypes -fno-strict-aliasing -fno-common			\
	-Wendif-labels -Wmissing-include-dirs -Wempty-body			\
	-Wnested-externs -Wformat-security -Wformat-y2k -Winit-self		\
	-Wignored-qualifiers -Wold-style-definition				\
	-Wtype-limits -fstack-protector-strong -Wno-unused-parameter		\
	-Wno-missing-field-initializers -Wno-sometimes-uninitialized		\
	-Wno-constant-conversion -Wno-pointer-arith -Wno-unused-variable

UNICORN_SRC := \
	$(QEMU_CORE_SRC)	\
	uc.c			\
	list.c

UNICORN_CFLAGS := \
	$(QEMU_CFLAGS)				\
	-DUNICORN_HAS_ARM -DUNICORN_HAS_ARMEB	\
	-fvisibility=hidden

include $(CLEAR_VARS)
LOCAL_MODULE := libunicorn-arm
LOCAL_SRC_FILES := $(QEMU_TARGET_SRC)
LOCAL_CFLAGS := \
	$(UNICORN_CFLAGS) -DNEED_CPU_H \
	-include $(LOCAL_PATH)/qemu/arm.h
LOCAL_C_INCLUDES := \
        $(LOCAL_PATH)/include \
	$(LOCAL_PATH)/qemu/include \
	$(LOCAL_PATH)/qemu/target-arm \
	$(LOCAL_PATH)/qemu \
	$(LOCAL_PATH)/qemu-gen \
	$(LOCAL_PATH)/qemu/tcg \
	$(LOCAL_PATH)/qemu/tcg/i386 \
	$(LOCAL_PATH)/host-x86 \
	$(LOCAL_PATH)/target-arm
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libunicorn-armeb
LOCAL_SRC_FILES := $(QEMU_TARGET_SRC)
LOCAL_CFLAGS := \
	$(UNICORN_CFLAGS) -DNEED_CPU_H \
	-include $(LOCAL_PATH)/qemu/armeb.h
LOCAL_C_INCLUDES := \
        $(LOCAL_PATH)/include \
	$(LOCAL_PATH)/qemu/include \
	$(LOCAL_PATH)/qemu/target-arm \
	$(LOCAL_PATH)/qemu \
	$(LOCAL_PATH)/qemu-gen \
	$(LOCAL_PATH)/qemu/tcg \
	$(LOCAL_PATH)/qemu/tcg/i386 \
	$(LOCAL_PATH)/host-x86 \
	$(LOCAL_PATH)/target-armeb
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libunicorn
LOCAL_SRC_FILES := $(UNICORN_SRC)
LOCAL_CFLAGS := $(UNICORN_CFLAGS)
LOCAL_C_INCLUDES := \
        $(LOCAL_PATH)/include \
	$(LOCAL_PATH)/qemu/include \
	$(LOCAL_PATH)/qemu \
	$(LOCAL_PATH)/qemu-gen \
	$(LOCAL_PATH)/qemu/tcg \
	$(LOCAL_PATH)/qemu/tcg/i386 \
	$(LOCAL_PATH)/host-x86
LOCAL_WHOLE_STATIC_LIBRARIES := libunicorn-arm libunicorn-armeb
include $(BUILD_STATIC_LIBRARY)
