# OctaviOS Versioning
PRODUCT_VERSION_MAJOR := 16
PRODUCT_VERSION_MINOR := 0

OCTAVI_BUILD_TYPE ?= UNOFFICIAL

# Get current UTC date components
OCTAVI_DATE_YEAR := $(shell date -u +%Y)
OCTAVI_DATE_MONTH := $(shell date -u +%m)
OCTAVI_DATE_DAY := $(shell date -u +%d)
OCTAVI_DATE_HOUR := $(shell date -u +%H)
OCTAVI_DATE_MINUTE := $(shell date -u +%M)

# Final build date in YYYYMMDD-HHMM format
OCTAVI_BUILD_DATE := $(OCTAVI_DATE_YEAR)$(OCTAVI_DATE_MONTH)$(OCTAVI_DATE_DAY)-$(OCTAVI_DATE_HOUR)$(OCTAVI_DATE_MINUTE)

# Target product short name
TARGET_PRODUCT_SHORT := $(subst octavi_,,$(OCTAVI_BUILD))

# OFFICIAL device check
ifeq ($(OCTAVI_BUILD_TYPE), OFFICIAL)
  OCTAVI_OFFICIAL_LIST := $(shell cat vendor/octavi/octavi.devices)
  ifeq ($(filter $(OCTAVI_BUILD), $(OCTAVI_OFFICIAL_LIST)), $(OCTAVI_BUILD))
    IS_OFFICIAL := true
    OCTAVI_BUILD_TYPE := OFFICIAL
  endif
  ifneq ($(IS_OFFICIAL), true)
    OCTAVI_BUILD_TYPE := UNOFFICIAL
    $(error Device is not official "$(OCTAVI_BUILD)")
  endif
endif

# Extra version suffix if unofficial
ifeq ($(OCTAVI_BUILD_TYPE), UNOFFICIAL)
  ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
    OCTAVI_EXTRAVERSION := -$(TARGET_UNOFFICIAL_BUILD_ID)
  endif
endif

# Complete version suffix
OCTAVI_VERSION_SUFFIX := $(OCTAVI_BUILD_DATE)-$(OCTAVI_BUILD_TYPE)$(OCTAVI_EXTRAVERSION)-$(OCTAVI_BUILD)

# Internal and Display versions
OCTAVI_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(OCTAVI_VERSION_SUFFIX)
OCTAVI_DISPLAY_VERSION := OctaviOS-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(OCTAVI_BUILD_TYPE)
OCTAVI_FINGERPRINT := OctaviOS/$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)/$(TARGET_PRODUCT_SHORT)/$(OCTAVI_BUILD_DATE)

# OctaviOS Version Props
PRODUCT_SYSTEM_PROPERTIES += \
    ro.octavi.version=$(OCTAVI_VERSION) \
    ro.octavi.display.version=$(OCTAVI_DISPLAY_VERSION) \
    ro.octavi.build.date=$(OCTAVI_BUILD_DATE) \
    ro.octavi.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.octavi.releasetype=$(OCTAVI_BUILD_TYPE) \
    ro.octavi.fingerprint=$(OCTAVI_FINGERPRINT) \
    ro.octavi.device=$(OCTAVI_BUILD)
