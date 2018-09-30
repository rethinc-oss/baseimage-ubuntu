#!/bin/bash -eux

echo "==> Removing Packages"

apt -y purge btrfs-tools cpp cpp-5 ed gcc gcc-5 krb5-locales language-pack-gnome-en \
       language-pack-gnome-en-base language-selector-common laptop-detect lxc-common \
       lxcfs lxd lxd-client make nfs-common ntfs-3g patch plymouth \
       plymouth-theme-ubuntu-text popularity-contest screen snapd ufw vim vim-common \
       vim-runtime vim-tiny fakeroot keyutils libalgorithm-diff-perl \
       libalgorithm-diff-xs-perl libalgorithm-merge-perl libasan2 libatomic1 \
       libc-dev-bin libc6-dev libcc1-0 libcilkrts5 libdrm2 libfakeroot libgcc-5-dev \
       libgomp1 libisl15 libitm1 liblsan0 libmpc3 libmpx0 libnfsidmap2 libplymouth4 \
       libquadmath0 libstdc++-5-dev libtirpc1 libtsan0 libubsan0 linux-libc-dev \
       manpages-dev rpcbind
       
