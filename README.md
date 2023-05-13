# fedora-ansible
1. Copy `default.config.yml` to `<custom>.config.yml` and customize variables
2. Add secrets to `vault.yml`
3. `make deps` to install playbook dependencies
4. `make vault` to encrypt vault.yml
5. `make install` to run playbook

## Get PCI IDs for config.yml
Install `lspci`:
```
sudo dnf install -y pciutils
```
