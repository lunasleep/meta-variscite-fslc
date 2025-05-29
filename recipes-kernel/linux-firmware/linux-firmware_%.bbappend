# Support additional firmware for bc43xx and wl18xx WIFI+BT modules (patched for https)

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRCREV_FORMAT = "linux-firmware"

SRCREV_brcm = "8081cd2bddb1569abe91eb50bd687a2066a33342"
BRANCH_brcm = "8.2.0.16"

# Replacing TI git:// sources with HTTPS cgit blobs
SRC_URI_append = " \
    git://github.com/varigit/bcm_4343w_fw.git;protocol=git;branch=${BRANCH_brcm};destsuffix=brcm;name=brcm \
    https://git.ti.com/cgit/wilink8-wlan/wl18xx_fw/plain/wl18xx-fw-4.bin;name=tiwlan;subdir=tiwlan \
    https://git.ti.com/cgit/ti-bt/service-packs/plain/initscripts/TIInit_11.8.32.bts;name=tibt;subdir=tibt \
    file://wl1271-nvs.bin \
"

SRC_URI[tiwlan.sha256sum] = "f24ee728fe1bcd6b1fcdf31efcc0f6985c0c31a05eec49bff092f7801b8aff16"
SRC_URI[tibt.sha256sum] = "3e5fd8e12f2665914b9da8d70e4cad3dcd8a9cf09eb130218405dc5c6bbbc563"

do_install_append() {
    # Create base dirs
    install -d ${D}${nonarch_base_libdir}/firmware
    install -d ${D}${nonarch_base_libdir}/firmware/brcm
    install -d ${D}${nonarch_base_libdir}/firmware/ti-connectivity

    # Broadcom
    install -m 0644 ${WORKDIR}/brcm/brcm/* ${D}${nonarch_base_libdir}/firmware/brcm/

    # TI Wi-Fi + BT
    install -m 0644 ${WORKDIR}/tiwlan/wl18xx-fw-4.bin ${D}${nonarch_base_libdir}/firmware/ti-connectivity/
    install -m 0644 ${WORKDIR}/tibt/TIInit_11.8.32.bts ${D}${nonarch_base_libdir}/firmware/ti-connectivity/
    install -m 0644 ${WORKDIR}/wl1271-nvs.bin ${D}${nonarch_base_libdir}/firmware/ti-connectivity/
}

FILES_${PN}-bcm4339 += " \
  ${nonarch_base_libdir}/firmware/brcm/BCM4335C0.hcd \
  ${nonarch_base_libdir}/firmware/brcm/brcmfmac4339-sdio.txt \
"

FILES_${PN}-bcm43430 += " \
  ${nonarch_base_libdir}/firmware/brcm/BCM43430A1.hcd \
  ${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.txt \
"
