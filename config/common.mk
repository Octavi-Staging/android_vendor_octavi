# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= OctaviOS

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/octavi/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/octavi/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/octavi/prebuilt/common/bin/50-lineage.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-lineage.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/octavi/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/octavi/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/octavi/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/octavi/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# Branding
include vendor/octavi/config/branding.mk

# Copy all octavi-specific init rc files
$(foreach f,$(wildcard vendor/octavi/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Copy all app permissions xml
$(foreach f,$(wildcard vendor/octavi/prebuilt/common/system_ext/etc/permissions/*.xml),\
        $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/$(notdir $f)))

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/octavi/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_045e_Product_0719.kl

# Fonts
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/octavi/prebuilt/fonts,$(TARGET_COPY_OUT_PRODUCT)/fonts)

# Game Overlay
PRODUCT_COPY_FILES += \
    vendor/octavi/prebuilt/common/etc/sysconfig/game_overlay.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/game_overlay.xml

# Quick Tap
PRODUCT_COPY_FILES += \
    vendor/octavi/prebuilt/common/etc/sysconfig/quick_tap.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/quick_tap.xml

# Include AOSP audio files
include vendor/octavi/config/aosp_audio.mk

# Include octavi audio files
include vendor/octavi/config/octavi_audio.mk

# Include extra packages
include vendor/octavi/config/packages.mk

# Props
include vendor/octavi/config/props.mk

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Overlays
PRODUCT_PACKAGES += \
    CustomConfigOverlay \
    CustomLauncherOverlay \
    CustomSettingsOverlay

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Bootanimation
PRODUCT_COPY_FILES += \
    vendor/octavi/bootanimation/bootanimation.zip:$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip

# Charger
ifeq ($(USE_PIXEL_CHARGER),true)
PRODUCT_PACKAGES += \
    product_charger_res_images
endif

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

# Root
PRODUCT_PACKAGES += \
    adb_root

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI

PRODUCT_BROKEN_VERIFY_USES_LIBRARIES := true
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/octavi/overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/octavi/overlay/common

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/octavi/config/partner_gms.mk

ifeq ($(EXTRA_UDFPS_ANIMATIONS),true)
PRODUCT_PACKAGES += \
    UdfpsResources
endif

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    FaceUnlockService
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Fonts
include vendor/octavi/config/fonts.mk

# Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Smartspace
PRODUCT_PACKAGES += \
    DeviceIntelligenceNetworkPrebuilt \
    DevicePersonalizationPrebuiltPixel2021 \
    PixelConfigOverlayCommon

PRODUCT_COPY_FILES += \
    vendor/octavi/prebuilt/common/etc/permissions/privapp-permissions-google-as.xml:product/etc/permissions/privapp-permissions-google-as.xml

# Sounds
include vendor/octavi/config/sounds.mk

# Themes
$(call inherit-product, vendor/octavi/config/themes.mk)
-include $(WORKSPACE)/build_env/image-auto-bits.mk
