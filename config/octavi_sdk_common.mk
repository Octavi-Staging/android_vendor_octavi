# Permissions for octavi sdk services
PRODUCT_COPY_FILES += \
    vendor/octavi/config/permissions/org.octavios.globalactions.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.octavios.globalactions.xml \
    vendor/octavi/config/permissions/org.octavios.hardware.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.octavios.hardware.xml \
    vendor/octavi/config/permissions/org.octavios.health.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.octavios.health.xml \
    vendor/octavi/config/permissions/org.octavios.livedisplay.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.octavios.livedisplay.xml \
    vendor/octavi/config/permissions/org.octavios.profiles.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.octavios.profiles.xml \
    vendor/octavi/config/permissions/org.octavios.settings.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.octavios.settings.xml \
    vendor/octavi/config/permissions/org.octavios.trust.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.octavios.trust.xml

# Octavi Platform Library
PRODUCT_PACKAGES += \
    org.octavios.platform-res \
    org.octavios.platform

# AOSP has no support of loading framework resources from /system_ext
# so the SDK has to stay in /system for now
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/framework/oat/%/org.octavios.platform.odex \
    system/framework/oat/%/org.octavios.platform.vdex \
    system/framework/org.octavios.platform-res.apk \
    system/framework/org.octavios.platform.jar
