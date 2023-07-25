# Sensitive Phone Numbers list
PRODUCT_COPY_FILES += \
    vendor/octavi/prebuilt/common/etc/sensitive_pn.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sensitive_pn.xml

# World APN list
PRODUCT_PACKAGES += \
    apns-conf.xml

# Telephony packages
PRODUCT_PACKAGES += \
    messaging \
    Stk

ifneq ($(WITH_GAPPS),true)
# Default ringtone
PRODUCT_PRODUCT_PROPERTIES += \
    ro.config.ringtone=The_big_adventure.ogg
endif

# Tethering - allow without requiring a provisioning app
# (for devices that check this)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    net.tethering.noprovisioning=true
