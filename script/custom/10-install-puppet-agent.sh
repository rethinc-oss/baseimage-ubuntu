#!/bin/bash -eux

echo "==> Installing puppet-agent"

CODENAME="$(/usr/bin/lsb_release --codename --short)"

wget https://apt.puppetlabs.com/puppet5-release-${CODENAME}.deb
DEBIAN_FRONTEND=noninteractive dpkg -i puppet5-release-${CODENAME}.deb
apt update
apt install puppet-agent
