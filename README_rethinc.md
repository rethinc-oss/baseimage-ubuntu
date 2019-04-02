packer build -only=virtualbox-iso -var-file="rethinc.json" ubuntu.json
packer build -only=vmware-iso -var-file="rethinc.json" ubuntu.json

Upgrade to next Ubuntu Release:
-------------------------------

rethinc.json:
vm_name, iso_checksum, iso_checksum_type, iso_name, iso_url

vgrant-rethinc.tpl:
config.vm.box
