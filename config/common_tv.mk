# Inherit common Octavi stuff
$(call inherit-product, vendor/octavi/config/common.mk)

# Include AOSP audio files
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioTv.mk)

# Inherit Octavi atv device tree
$(call inherit-product, device/octavi/atv/octavi_atv.mk)

# AOSP packages
PRODUCT_PACKAGES += \
    LeanbackIME

# Octavi packages
PRODUCT_PACKAGES += \
    Catapult \
    OctaviCustomizer

PRODUCT_PACKAGE_OVERLAYS += vendor/octavi/overlay/tv
