PRODUCT_VERSION_MAJOR = 23
PRODUCT_VERSION_MINOR = 0

ifeq ($(OCTAVI_VERSION_APPEND_TIME_OF_DAY),true)
    OCTAVI_BUILD_DATE := $(shell date -u +%Y%m%d_%H%M%S)
else
    OCTAVI_BUILD_DATE := $(shell date -u +%Y%m%d)
endif

# Set OCTAVI_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef OCTAVI_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "OCTAVI_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^OCTAVI_||g')
        OCTAVI_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to UNOFFICIAL
ifeq ($(filter RELEASE NIGHTLY SNAPSHOT EXPERIMENTAL,$(OCTAVI_BUILDTYPE)),)
    OCTAVI_BUILDTYPE := UNOFFICIAL
    OCTAVI_EXTRAVERSION :=
endif

ifeq ($(OCTAVI_BUILDTYPE), UNOFFICIAL)
    ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
        OCTAVI_EXTRAVERSION := -$(TARGET_UNOFFICIAL_BUILD_ID)
    endif
endif

OCTAVI_VERSION_SUFFIX := $(OCTAVI_BUILD_DATE)-$(OCTAVI_BUILDTYPE)$(OCTAVI_EXTRAVERSION)-$(OCTAVI_BUILD)

# Internal version
OCTAVI_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(OCTAVI_VERSION_SUFFIX)
OCTAVI_VERSION_PROP := sixteen

# Display version
OCTAVI_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR)-$(OCTAVI_VERSION_SUFFIX)

# octavios version properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.octavi.version=$(OCTAVI_VERSION) \
    ro.octavi.display.version=$(OCTAVI_DISPLAY_VERSION) \
    ro.octavi.build.date=$(OCTAVI_BUILD_DATE) \
    ro.octavi.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.octavi.releasetype=$(OCTAVI_BUILDTYPE)
