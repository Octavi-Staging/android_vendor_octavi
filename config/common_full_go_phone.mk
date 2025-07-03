# Set Octavi specific identifier for Android Go enabled products
PRODUCT_TYPE := go

# Inherit full common Octavi stuff
$(call inherit-product, vendor/octavi/config/common_full_phone.mk)
