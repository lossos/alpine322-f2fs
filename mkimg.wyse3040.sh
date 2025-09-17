#!/bin/sh
#
# Custom Alpine Profil for Wyse 3040 with F2FS-Support

profile_mkimg.wyse3040() {
	profile_standard

	profile_description="Custom Alpine 3.22 für Wyse 3040 mit F2FS-Support und Realtek-Treibern"

	apks="$apks f2fs-tools f2fs-tools-libs mmc-utils"
	apks="$apks alpine-conf zsh alpine-zsh-config"
	apks="$apks linux-firmware-realtek linux-firmware-rtl_nic"
    apks="$apks grub-efi grub f2fs-tools-static"
    apks="$apks dosfstools squashfs-tools doas"

	kernel_config="$kernel_config
		CONFIG_F2FS_FS=y
		CONFIG_F2FS_FS_XATTR=y
		CONFIG_F2FS_FS_POSIX_ACL=y
		CONFIG_F2FS_FS_SECURITY=y
		CONFIG_R8169=y
	"

	timezone="Europe/Berlin"
	locale="de_DE.UTF-8"
	keymap="de"

}