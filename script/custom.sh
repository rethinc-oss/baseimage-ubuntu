#!/bin/bash -eux

SCRIPTS=(`ls /tmp/custom-scripts`)

# If there are no scripts, skip the execution
if [ ${#SCRIPTS[@]} -eq 0 ]; then
    exit 0
fi

echo "==> Executing provided custom scripts"
DEBIAN_FRONTEND=noninteractive apt-get -y -q install dos2unix

for SCRIPT in ${SCRIPTS[@]}; do
    echo "--- Executing: ${SCRIPT}"
    /usr/bin/dos2unix /tmp/custom-scripts/${SCRIPT}
    /bin/chmod +x /tmp/custom-scripts/${SCRIPT}
    /bin/bash -c "/tmp/custom-scripts/${SCRIPT}"
done

DEBIAN_FRONTEND=noninteractive apt-get -y -q purge dos2unix
