# Support additional firmware for bcm43xx WIFI+BT modules.
#
# TI WiLink (wl18xx) firmware was removed: the git.ti.com cgit blob endpoint is
# dead (do_fetch wget exit 8) and the imx8mm Variscite DART boards use the
# Broadcom/Cypress WiFi+BT chip (brcmfmac), not TI WiLink. Nothing in this BSP or
# the eight layer references ti-connectivity/wl18xx/wl1271/TIInit at runtime.

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRCREV_FORMAT = "linux-firmware"

SRCREV_brcm = "8081cd2bddb1569abe91eb50bd687a2066a33342"
BRANCH_brcm = "8.2.0.16"

SRC_URI_append = " \
    git://github.com/varigit/bcm_4343w_fw.git;protocol=git;branch=${BRANCH_brcm};destsuffix=brcm;name=brcm \
"

do_install_append() {
    install -d ${D}${nonarch_base_libdir}/firmware
    install -d ${D}${nonarch_base_libdir}/firmware/brcm

    # Broadcom
    install -m 0644 ${WORKDIR}/brcm/brcm/* ${D}${nonarch_base_libdir}/firmware/brcm/
}

FILES_${PN}-bcm4339 += " \
  ${nonarch_base_libdir}/firmware/brcm/BCM4335C0.hcd \
  ${nonarch_base_libdir}/firmware/brcm/brcmfmac4339-sdio.txt \
"

FILES_${PN}-bcm43430 += " \
  ${nonarch_base_libdir}/firmware/brcm/BCM43430A1.hcd \
  ${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.txt \
"
