# fedora-ansible
1. Edit hosts.yml file
2. Edit vault.yml file
3. `make deps` install playbook dependencies and encrypt vault.yml
3. `make install` run playbook

## Get PCI IDs for hosts file
Install `lspci`:
```
sudo dnf install -y pciutils
```

Devices to assign `vfio-pci` driver:
```
lspci -n
```
```
vfio_bind_ids:
  - 10de:1b80
  - 10de:10f0
  - 1102:0012
```

Devices to passthrough to respective VM:
```
lscpi
```
```
passthrough_vms:
  - name: win10-vfio
    pci_devices:
      - "05:00.0"
      - "06:00.0"
      - "0a:00.0"
      - "0a:00.1"
```
