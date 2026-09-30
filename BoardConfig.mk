#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#
# Copyright (C) 2024-2025 The OrangeFox Recovery Project
# SPDX-License-Identifier: GPL-3.0-or-later
#

DEVICE_PATH := device/xiaomi/myron


# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

BUILD_BROKEN_NINJA_USES_ENV_VARS += RTIC_MPGEN
BUILD_BROKEN_PLUGIN_VALIDATION := soong-libaosprecovery_defaults soong-libguitwrp_defaults soong-libminuitwrp_defaults soong-vold_defaults

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := oryon

# Power
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Bootloader
PRODUCT_PLATFORM := canoe
TARGET_BOOTLOADER_BOARD_NAME := $(PRODUCT_RELEASE_NAME)
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := sm8850
TARGET_BOARD_PLATFORM_GPU := qcom-adreno840
QCOM_BOARD_PLATFORMS += sm8850

# Kernel
TARGET_KERNEL_ARCH            := arm64
TARGET_KERNEL_HEADER_ARCH     := arm64
BOARD_KERNEL_IMAGE_NAME       := Image
BOARD_BOOT_HEADER_VERSION     := 4
BOARD_KERNEL_PAGESIZE         := 4096
TARGET_PREBUILT_KERNEL        := $(DEVICE_PATH)/prebuilt/kernel
BOARD_MKBOOTIMG_ARGS          += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS          += --pagesize $(BOARD_KERNEL_PAGESIZE)

BOARD_RAMDISK_USE_LZ4 := true

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    init_boot \
    odm \
    product \
    system \
    system_dlkm \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot \
    vendor_dlkm

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_RECOVERY_KEY_PATH                := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM               := SHA256_RSA4096
BOARD_AVB_ALGORITHM                        := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX          := 0
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 0

# Partitions
BOARD_RECOVERYIMAGE_PARTITION_SIZE     := 104857600

# Dynamic Partition
BOARD_SUPER_PARTITION_SIZE := 14495514624
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 14485028864
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := \
	system system_ext product vendor vendor_dlkm odm

BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := erofs))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs

# File systems
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Crypto
BOARD_USES_METADATA_PARTITION := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
AERA_INCLUDE_CRYPTO := true
AERA_INCLUDE_CRYPTO_FBE := true
AERA_INCLUDE_FBE_METADATA_DECRYPT := true
AERA_USE_FSCRYPT_POLICY := 2

# Recovery
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
AERA_INCLUDE_FASTBOOTD := true
AERA_SKIP_ADDITIONAL_FSTAB := true
AERA_UI_ADAPTIVE_RESOLUTION := true

# Tool
AERA_INCLUDE_LIBRESETPROP := true
AERA_INCLUDE_LPDUMP := true
AERA_INCLUDE_LPTOOLS := true
AERA_INCLUDE_REPACKTOOLS := true
AERA_INCLUDE_RESETPROP := true

# Debug
TARGET_USES_LOGD := true
AERA_INCLUDE_LOGCAT := true
TARGET_RECOVERY_DEVICE_MODULES += debuggerd
TARGET_RECOVERY_DEVICE_MODULES += strace
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/debuggerd
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/strace

# AERA display
AERA_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
AERA_DEFAULT_BRIGHTNESS := 1200
AERA_FRAMERATE := 120
AERA_MAX_BRIGHTNESS := 4094
AERA_NO_SCREEN_BLANK := true
AERA_SCREEN_BLANK_ON_BOOT := true
AERA_THEME := portrait_hdpi
TARGET_USES_VULKAN := true

# AERA file system
RECOVERY_SDCARD_ON_DATA := true
TARGET_USES_MKE2FS := true
AERA_ENABLE_FS_COMPRESSION := true
AERA_INCLUDE_FUSE_EXFAT := true
AERA_INCLUDE_FUSE_NTFS := true
AERA_INCLUDE_NTFS_3G := true
AERA_NO_EXFAT_FUSE := true

# Vibrator(Using force feedback patch)
#AERA_SUPPORT_INPUT_AIDL_HAPTICS := true

# Other AERA configurations
TARGET_RECOVERY_QCOM_RTC_FIX := true
AERA_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone45/temp" # CPU-0-0-0
AERA_EXCLUDE_APEX := true
AERA_EXCLUDE_DEFAULT_USB_INIT := true
AERA_DEFAULT_LANGUAGE := zh_CN
AERA_EXTRA_LANGUAGES := true
AERA_LOAD_VENDOR_MODULES := "msm_kgsl.ko governor_gpubw_mon.ko governor_msm_adreno_tz.ko governor_msm_adreno_ro.ko gpucc-chora.ko gpucc-sm4450.ko gpu_stats.ko gpu_freq_stats.ko msm_drm.ko drm_display_helper.ko msm_ext_display.ko hdmi_dlkm.ko lt9611uxc.ko msm_hfi_core.ko sync_fence.ko msm_hw_fence.ko panel_event_notifier.ko dump_display.ko msm_sharedmem.ko qcom-amoled-regulator.ko qpnp-lcdb-regulator.ko qcom-spmi-wled.ko qti_btl.ko qti_amoled_ecm.ko hwmon.ko hdcp_qseecom_dlkm.ko smmu_proxy_dlkm.ko altmode-glink.ko qcedev-mod_dlkm.ko qcrypto-msm_dlkm.ko qce50_dlkm.ko qrng_dlkm.ko smcinvoke_dlkm.ko tmecom-intf_dlkm.ko tz_log_dlkm.ko qsee_ipc_irq_bridge.ko spcom.ko spss_utils.ko qcom_spss.ko qcom_q6v5_pas.ko qcom_q6v5.ko qcom_sysmon.ko qcom_glink_spss.ko rproc_qcom_common.ko mitee_dlkm.ko qmi_helpers.ko pdr_interface.ko qcom_pdr_msg.ko qcom_glink.ko qcom_glink_smem.ko qcom_smd.ko qcom_pil_info.ko qcom_ramdump.ko qcom_va_minidump.ko nxp-nci.ko stm_nfc_i2c.ko stm_st54se_gpio.ko qcom-hv-haptics.ko leds-qpnp-vibrator-ldo.ko ledtrig-pattern.ko swr_haptics_dlkm.ko focaltech_touch_3683.ko xiaomi_touch.ko"
AERA_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true
AERA_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true
AERA_USE_TOOLBOX := true
AERA_INPUT_BLACKLIST    := "hbtp_vm:qcom-hv-haptics:uinput-xiaomi"

# Version
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
AERA_DEVICE_VERSION := REDMI_K90_Pro_Max

# se_omapi
AERA_INCLUDE_OMAPI := true