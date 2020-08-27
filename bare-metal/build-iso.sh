#!/bin/sh

SOURCE_DIR_SYSLINUX="/vagrant/bare-metal/"
SOURCE_DIR_PRESEED="/vagrant/http/"
SOURCE_ORIG_ISO="/tmp/mini.iso"
SOURCE_ORIG_ISO_URL="http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/current/legacy-images/netboot/mini.iso"

DEST_ISO_DIR="/vagrant/box/bare-metal/"
DEST_ISO_NAME="custom-mini.iso"

ISO_MOUNT_DIR="/tmp/iso-orig/"
ISO_BUILD_DIR="/tmp/iso-extracted/"
INITRD_DIR="/tmp/iso-initrd/"
MBR_FILE="/tmp/ubuntu_isohybrid_mbr.img"

### Downlaod mini.iso if not already present
if [ ! -f ${SOURCE_ORIG_ISO} ]; then
   /usr/bin/wget -O ${SOURCE_ORIG_ISO} ${SOURCE_ORIG_ISO_URL}
fi

### Mount the original ISO and copy to build-dir
rm -rf ${ISO_MOUNT_DIR}
mkdir -p ${ISO_MOUNT_DIR}
mount -o loop ${SOURCE_ORIG_ISO} ${ISO_MOUNT_DIR}

rm -rf ${ISO_BUILD_DIR}
mkdir -p ${ISO_BUILD_DIR}
cp -rT ${ISO_MOUNT_DIR} ${ISO_BUILD_DIR}

umount ${ISO_MOUNT_DIR}

### Left here for ducumentation reasons
## Extract init.rd
#(cd /tmp/iso-preseed/ && gzip -d < ${BUILD_DIR}/initrd.gz | cpio -id)

### Build the addon ramdisks with the preseed files
rm -rf ${INITRD_DIR}
mkdir -p ${INITRD_DIR}
cp /vagrant/http/preseed-common.cfg ${INITRD_DIR}
cp /vagrant/http/preseed-rootonly.cfg "${INITRD_DIR}preseed.cfg"
(cd ${INITRD_DIR} && find . | cpio -o -H newC | gzip) > ${ISO_BUILD_DIR}/initrd-rootonly.gz
chmod -w -R ${BUILD_DIR}/initrd-rootonly.gz

rm -rf ${INITRD_DIR}
mkdir -p ${INITRD_DIR}
cp /vagrant/http/preseed-common.cfg ${INITRD_DIR}
cp /vagrant/http/preseed-rootdata.cfg "${INITRD_DIR}preseed.cfg"
(cd ${INITRD_DIR} && find . | cpio -o -H newC | gzip) > ${ISO_BUILD_DIR}/initrd-rootdata.gz
chmod -w -R ${BUILD_DIR}/initrd-rootdata.gz

### Copy SYSLINUX FILES
cp -f ${SOURCE_DIR_SYSLINUX}txt.cfg ${ISO_BUILD_DIR}
dd if="${SOURCE_ORIG_ISO}" bs=1 count=446 of="${MBR_FILE}"

mkdir -p ${DEST_ISO_DIR}

xorriso -as mkisofs -r -V "CUSTOM" \
            -J -l \
            -isohybrid-mbr "${MBR_FILE}" \
            -c boot.cat \
            -b isolinux.bin \
               -no-emul-boot -boot-load-size 4 -boot-info-table \
            -eltorito-alt-boot \
            -e boot/grub/efi.img \
               -no-emul-boot -isohybrid-gpt-basdat \
            -o "${DEST_ISO_DIR}${DEST_ISO_NAME}" \
            "${ISO_BUILD_DIR}"

rm "$MBR_FILE"
