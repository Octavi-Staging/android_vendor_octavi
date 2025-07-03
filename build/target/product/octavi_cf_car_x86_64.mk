# SPDX-FileCopyrightText: 2024 The octavios Project
# SPDX-License-Identifier: Apache-2.0

$(call inherit-product, device/google/cuttlefish/vsoc_x86_64_only/auto/aosp_cf.mk)

include vendor/octavi/build/target/product/octavi_generic_car_target.mk

TARGET_NO_KERNEL_OVERRIDE := true

# Enable mainline checking
PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := relaxed

# Overrides
PRODUCT_NAME := octavi_cf_car_x86_64
PRODUCT_MODEL := octavios Cuttlefish car built for x86_64
