# CuBox-i mk file.
# Based on sabre-sd

$(call inherit-product, device/fsl/imx6/imx6.mk)
$(call inherit-product-if-exists,vendor/google/products/gms.mk)

ifneq ($(wildcard device/fsl/sabresd_6dq/fstab_nand.freescale),)
$(shell touch device/fsl/sabresd_6dq/fstab_nand.freescale)
endif

ifneq ($(wildcard device/fsl/sabresd_6dq/fstab.freescale),)
$(shell touch device/fsl/sabresd_6dq/fstab.freescale)
endif

# Overrides
PRODUCT_NAME := cuboxi
PRODUCT_DEVICE := cuboxi

PRODUCT_COPY_FILES += \
	device/fsl/cuboxi/required_hardware.xml:system/etc/permissions/required_hardware.xml \
	device/fsl/cuboxi/init.rc:root/init.freescale.rc \
	device/fsl/cuboxi/audio_policy.conf:system/etc/audio_policy.conf \
	device/fsl/cuboxi/audio_effects.conf:system/vendor/etc/audio_effects.conf

# GPU files

DEVICE_PACKAGE_OVERLAYS := device/fsl/cuboxi/overlay

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_AAPT_CONFIG += xlarge large tvdpi hdpi

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/native/data/etc/android.hardware.faketouch.xml:system/etc/permissions/android.hardware.faketouch.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

# for PDK build, include only when the dir exists
# too early to use $(TARGET_BUILD_PDK)
ifneq ($(wildcard packages/wallpapers/LivePicker),)
PRODUCT_COPY_FILES += \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml
endif

PRODUCT_COPY_FILES += \
	device/fsl/cuboxi/firmware/brcm/brcmfmac-sdio.bin:system/etc/firmware/brcm/brcmfmac-sdio.bin \
	device/fsl/cuboxi/firmware/brcm/brcmfmac-sdio.txt:system/etc/firmware/brcm/brcmfmac-sdio.txt \
	device/fsl/cuboxi/firmware/brcm/bcm4329.hcd:system/etc/firmware/brcm/BCM4329B1.hcd \
	device/fsl/cuboxi/rc.wifi:system/bin/wifi/rc.wifi

#PRODUCT_COPY_FILES += \
#	device/fsl/cuboxi/media_profiles_480p.xml:system/etc/media_profiles.xml
# Bluetooth support
PRODUCT_COPY_FILES += \
        system/bluetooth/data/main.nonsmartphone.conf:system/etc/bluetooth/main.conf
PRODUCT_PACKAGES +=	\
	bt_vendor.conf	\
	brcm_patchram_plus	\
	FileManager-1.1.6	\
	ethernet
	

