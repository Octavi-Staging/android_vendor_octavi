# Inherit mobile full common Octavi stuff
$(call inherit-product, vendor/octavi/config/common_mobile_full.mk)

# Inherit tablet common Octavi stuff
$(call inherit-product, vendor/octavi/config/tablet.mk)

$(call inherit-product, vendor/octavi/config/telephony.mk)
