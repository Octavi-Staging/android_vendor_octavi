# Set Octavi specific identifier for Android Go enabled products
PRODUCT_TYPE := go

# Inherit mini common Octavi stuff
$(call inherit-product, vendor/octavi/config/common_mini_phone.mk)
