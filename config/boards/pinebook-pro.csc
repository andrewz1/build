# Rockchip RK3399 hexa core 2G/4GB SoC Laptop eMMC USB3 WiFi
BOARD_NAME="Pinebook Pro"
BOARDFAMILY="rockchip64"
BOARD_MAINTAINER="TRSx80 ahoneybun"
BOOTCONFIG="pinebook-pro-rk3399_defconfig"
BOOT_FDT_FILE="rockchip/rk3399-pinebook-pro.dtb"
KERNEL_TARGET="current,edge"
KERNEL_TEST_TARGET="current"
FULL_DESKTOP="yes"
BOOT_LOGO="desktop"
BOOT_SCENARIO="blobless"
ASOUND_STATE="asound.state.pinebook-pro"
BOOTBRANCH_BOARD="tag:v2022.04"
BOOTPATCHDIR="u-boot-rockchip64-v2022.04"

function post_family_tweaks__PBP() {
	display_alert "$BOARD" "Installing board tweaks" "info"

	chroot $SDCARD /bin/bash -c "echo SuspendState=freeze >> /etc/systemd/sleep.conf"
	chroot $SDCARD /bin/bash -c "echo HandlePowerKey=ignore >> /etc/systemd/login.d"

	return 0
}

function post_family_tweaks_bsp__PBP_BSP() {
	display_alert "Installing BSP firmware and fixups"

	# special keys
	mkdir -p "${destination}"/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/
	cp $SRC/packages/bsp/pinebook-pro/pointers.xml "${destination}"/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/

	# touchpad and keyboard tweaks
	mkdir -p "${destination}"/etc/X11/xorg.conf.d/
	# from https://github.com/ayufan-rock64/linux-package/tree/master/root-pinebookpro
	cp "${SRC}"/packages/bsp/pinebook-pro/40-pinebookpro-touchpad.conf "${destination}"/etc/X11/xorg.conf.d/

	# keyboard hwdb
	mkdir -p "${destination}"/etc/udev/hwdb.d/
	cp "${SRC}"/packages/bsp/pinebook-pro/10-usb-kbd.hwdb "${destination}"/etc/udev/hwdb.d/

	return 0
}
