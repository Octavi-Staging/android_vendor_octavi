# Inherit common Octavi stuff
$(call inherit-product, vendor/octavi/config/common.mk)

# Inherit Octavi car device tree
$(call inherit-product, device/octavi/car/octavi_car.mk)
