#!/bin/bash -eux

echo "==> Installing puppet-agent"

CODENAME="$(/usr/bin/lsb_release --codename --short)"

wget https://apt.puppetlabs.com/puppet6-release-${CODENAME}.deb
DEBIAN_FRONTEND=noninteractive dpkg -i puppet6-release-${CODENAME}.deb
apt update
apt install puppet-agent
rm puppet6-release-${CODENAME}.deb

# add puppet bin directory to the sudo secure path
SECURE_PATH="Defaults secure_path=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/opt/puppetlabs/bin\""
echo $SECURE_PATH > /etc/sudoers.d/secure-path
