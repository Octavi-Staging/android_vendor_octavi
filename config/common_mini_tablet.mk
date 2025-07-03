# Inherit mobile mini common Octavi stuff
$(call inherit-product, vendor/octavi/config/common_mobile_mini.mk)

# Inherit tablet common Octavi stuff
$(call inherit-product, vendor/octavi/config/tablet.mk)

$(call inherit-product, vendor/octavi/config/telephony.mk)
