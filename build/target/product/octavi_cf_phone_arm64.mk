# SPDX-FileCopyrightText: 2024 The octavios Project
# SPDX-License-Identifier: Apache-2.0

$(call inherit-product, device/google/cuttlefish/vsoc_arm64/phone/aosp_cf.mk)

include vendor/octavi/build/target/product/octavi_generic_target.mk

TARGET_NO_KERNEL_OVERRIDE := true

# Overrides
PRODUCT_NAME := octavi_cf_phone_arm64
PRODUCT_MODEL := octavios Cuttlefish phone built for arm64
