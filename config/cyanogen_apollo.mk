# Inherit some common cyanogenmod stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit AOSP device configuration for passion.
$(call inherit-product, device/samsung/apollo/full_apollo.mk)

# Include GSM stuff
$(call inherit-product, vendor/cm/config/gsm.mk)

#
# Setup device specific product configuration.
#
PRODUCT_NAME := cyanogen_apollo
PRODUCT_BRAND := samsung
PRODUCT_DEVICE := apollo
PRODUCT_MODEL := GT-I5800
PRODUCT_MANUFACTURER := samsung

UTC_DATE := $(shell date +%s)
DATE     := $(shell date +%Y%m%d)

PRODUCT_BUILD_PROP_OVERRIDES := \
BUILD_ID=GWK74 \
BUILD_DISPLAY_ID=GWK74 \
PRODUCT_NAME=${PRODUCT_MODEL} \
TARGET_DEVICE=APOLLO \
BUILD_FINGERPRINT=SAMSUNG/APOLLO/GT-I5800/GT-I5801:2.3.7/GT-I5800/GT-I5801/${UTC_DATE}:user/release-keys \
PRODUCT_BRAND=SAMSUNG \
PRIVATE_BUILD_DESC="apollo-user 2.3.7 GT-I5800 ${UTC_DATE} release-keys" \
BUILD_NUMBER=${DATE} \
BUILD_VERSION_TAGS=release-keys \
TARGET_BUILD_TYPE=user \
USER=CyanogenDefy

# Add the FM app
PRODUCT_PACKAGES += FM

# Extra RIL settings
PRODUCT_PROPERTY_OVERRIDES += \
    ro.ril.enable.managed.roaming=1 \
    ro.ril.oem.nosim.ecclist=911,112,999,000,08,118,120,122,110,119,995 \
    ro.ril.emc.mode=2

#
# Set ro.modversion
#
ifdef CYANOGEN_NIGHTLY
    PRODUCT_PROPERTY_OVERRIDES += \
        ro.modversion=CyanogenMod-7-$(shell date +%m%d%Y)-NIGHTLY-GT-I5800
else
    ifdef CYANOGEN_RELEASE
        PRODUCT_PROPERTY_OVERRIDES += \
            ro.modversion=CyanogenMod-7.1.0-GT-I5800
    else
        PRODUCT_PROPERTY_OVERRIDES += \
            ro.modversion=CyanogenMod-7.1.0-GT-I5800-KANG
    endif
endif

#
# Move dalvik cache to data partition where there is more room to solve startup problems
#
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.dexopt-data-only=1

PRODUCT_COPY_FILES +=  \
    vendor/cyanogen/prebuilt/ldpi/media/bootanimation.zip:system/media/bootanimation.zip
