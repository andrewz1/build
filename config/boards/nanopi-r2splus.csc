# Rockchip RK3328 quad core 1GB 2 x GBE USB2 eMMC
BOARD_NAME="Nanopi R2S Plus"
BOARDFAMILY="rockchip64"
BOARD_MAINTAINER=""
BOOTCONFIG="nanopi-r2splus-rk3328_defconfig"
KERNEL_TARGET="current,edge"
KERNEL_TEST_TARGET="current"
DEFAULT_CONSOLE="serial"
MODULES="g_serial"
MODULES_BLACKLIST="rockchipdrm analogix_dp dw_mipi_dsi dw_hdmi gpu_sched lima hantro_vpu"
SERIALCON="ttyS2:1500000,ttyGS0"
HAS_VIDEO_OUTPUT="no"
BOOT_FDT_FILE="rockchip/rk3328-nanopi-r2splus.dtb"

function post_family_tweaks__nanopi-r2s_rename_USB_LAN() {
	display_alert "$BOARD" "Installing board tweaks" "info"

	# rename USB based network to lan0
	mkdir -p $SDCARD/etc/udev/rules.d/
	echo 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="r8152", KERNEL=="eth1", NAME="lan0"' > $SDCARD/etc/udev/rules.d/70-rename-lan.rules

	return 0
}
