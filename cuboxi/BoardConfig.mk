#
# Product-specific compile-time definitions.
#

include device/fsl/imx6/soc/imx6dq.mk
include device/fsl/cuboxi/build_id.mk
include device/fsl/imx6/BoardConfigCommon.mk
include device/fsl-proprietary/gpu-viv/fsl-gpu.mk
# CuBox-i now build for ext4. need to move to f2fs in the future
BUILD_TARGET_FS ?= ext4
include device/fsl/imx6/imx6_target_fs.mk

ifeq ($(BUILD_TARGET_FS),ubifs)
TARGET_RECOVERY_FSTAB = device/fsl/cuboxi/fstab_nand.freescale
# build ubifs for nand devices
PRODUCT_COPY_FILES +=	\
	device/fsl/cuboxi/fstab_nand.freescale:root/fstab.freescale
else
TARGET_RECOVERY_FSTAB = device/fsl/cuboxi/fstab.freescale
# build for ext4
PRODUCT_COPY_FILES +=	\
	device/fsl/cuboxi/fstab.freescale:root/fstab.freescale
endif # BUILD_TARGET_FS


TARGET_BOOTLOADER_BOARD_NAME := CUBOX-I
PRODUCT_MODEL := CuBox-i


BOARD_WLAN_DEVICE			 := bcmdhd
WPA_SUPPLICANT_VERSION			 := VER_0_8_X
WIFI_DRIVER_MODULE_PATH			 := "/system/lib/modules/brcmfmac.ko"
WIFI_DRIVER_MODULE_NAME			 := "brcmfmac"
WIFI_DRIVER_MODULE_ARG           	 := ""
TARGET_KERNEL_MODULES := \
   kernel_imx/drivers/net/wireless/brcm80211/brcmfmac/brcmfmac.ko:system/lib/modules/brcmfmac.ko	\
   kernel_imx/drivers/net/wireless/brcm80211/brcmutil/brcmutil.ko:system/lib/modules/brcmutil.ko
BOARD_WPA_SUPPLICANT_DRIVER      	 := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER             	 := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd


BOARD_MODEM_VENDOR := AMAZON
#BOARD_HAVE_HARDWARE_GPS := false
USE_QEMU_GPS_HARDWARE := true

#for accelerator sensor, need to define sensor type here
BOARD_HAS_SENSOR := true

# for recovery service
TARGET_SELECT_KEY := 28

# we don't support sparse image.
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

# uncomment below lins if use NAND
#TARGET_USERIMAGES_USE_UBIFS = true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 524288000

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
UBI_ROOT_INI := device/fsl/cuboxi/ubi/ubinize.ini
TARGET_MKUBIFS_ARGS := -m 4096 -e 516096 -c 4096 -x none
TARGET_UBIRAW_ARGS := -m 4096 -p 512KiB $(UBI_ROOT_INI)
endif

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
ifeq ($(TARGET_USERIMAGES_USE_EXT4),true)
$(error "TARGET_USERIMAGES_USE_UBIFS and TARGET_USERIMAGES_USE_EXT4 config open in same time, please only choose one target file system image")
endif
endif

BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init video=mxcfb0:dev=hdmi,1280x720M@60,if=RGB24 video=mxcfb1:off video=mxcfb2:off fbmem=10M vmalloc=400M androidboot.console=ttymxc0 androidboot.hardware=freescale

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
#UBI boot command line.
# Note: this NAND partition table must align with MFGTool's config.
BOARD_KERNEL_CMDLINE +=  mtdparts=gpmi-nand:16m(bootloader),16m(bootimg),128m(recovery),-(root) gpmi_debug_init ubi.mtd=3
endif

BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/fsl/cuboxi/bluetooth

USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

# camera hal v2
IMX_CAMERA_HAL_V2 := true
BOARD_HAVE_USB_CAMERA := true

# define frame buffer count
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

#define consumer IR HAL support
#IMX6_CONSUMER_IR_HAL := true

TARGET_BOOTLOADER_CONFIG := mx6_cubox-i_config
TARGET_KERNEL_DEFCONF := imx6_cubox-i_hummingboard_android_defconfig
# For Linux kernel 3.10.x uncomment the following
#TARGET_KERNEL_DEFCONF := imx_v7_cubox-i_hummingboard_android_defconfig
#TARGET_KERNEL_DTB := imx6q-cubox-i.dtb imx6dl-cubox-i.dtb imx6dl-hummingboard.dtb
BOARD_SEPOLICY_DIRS := \
       device/fsl/sabresd_6dq/sepolicy

BOARD_SEPOLICY_UNION := \
       app.te \
       file_contexts \
       fs_use \
       untrusted_app.te \
       genfs_contexts
