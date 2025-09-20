#!/bin/sh
#
# Custom Alpine Profil for Wyse 3040 with F2FS-Support

profile_mkimg.wyse3040() {
	profile_standard

	profile_description="Custom Alpine 3.22 for Wyse 3040 with F2FS-Support and Realtek-Drivers"

    arch="x86_64"
    output_format="iso"
    kernel_flavors="lts"
    initfs_features="$initfs_features usb usb-storage network f2fs"
    modloop_extra="$modloop_extra f2fs r8169 mmc_core mmc_block sdhci sdhci_acpi sdhci_pci crc32 crc32c libcrc32c"
    kernel_cmdline="quiet loglevel=2 nmi_watchdog=0 audit=0 mitigations=off"

	apks="$apks f2fs-tools f2fs-tools-libs mmc-utils"
	apks="$apks alpine-conf zsh alpine-zsh-config"
	apks="$apks linux-firmware-realtek linux-firmware-rtl_nic"
    apks="$apks grub-efi grub f2fs-tools-static"
	apks="$apks parted util-linux net-tools"
    apks="$apks dosfstools squashfs-tools doas"
    apks="$apks linux-firmware-i915"           # Intel GPU firmware
    apks="$apks linux-firmware-intel"          # Intel Bluetooth/WiFi firmware
    apks="$apks linux-firmware-brcm"           # Broadcom WiFi/BT (if present)
    apks="$apks linux-firmware-realtek"        # Realtek ethernet

    # Debug
    # apks="$apks dmidecode hwinfo pciutils hwinfo linux-tools lshw"
	# apks="$apks pciutils usbutils"
 
	kernel_config="$kernel_config
		CONFIG_F2FS_FS=y
		CONFIG_F2FS_FS_XATTR=y
		CONFIG_F2FS_FS_POSIX_ACL=y
		CONFIG_F2FS_FS_SECURITY=y
		CONFIG_R8169=y
	"

    # Include kernel packages properly
    local _k _a
    for _k in $kernel_flavors; do
        apks="$apks linux-$_k"
        for _a in $kernel_addons; do
            apks="$apks $_a-$_k"
        done
    done

}
