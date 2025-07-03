# Inherit mobile full common Octavi stuff
$(call inherit-product, vendor/octavi/config/common_mobile_full.mk)

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode?=true

# Inherit tablet common Octavi stuff
$(call inherit-product, vendor/octavi/config/tablet.mk)

$(call inherit-product, vendor/octavi/config/telephony.mk)

PRODUCT_PACKAGE_OVERLAYS += vendor/octavi/overlay/foldable_book
