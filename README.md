# fedora-setup
## List pci devices
`sudo dnf install -y pciutils`
`lspci`

`sudo dnf install -y libvirt-daemon`
`sudo systemctl start libvirtd`
`sudo virsh nodedev-list | grep pci`
## Run playbook
`sudo dnf install -y ansible`
`ansible-galaxy install -r requirements.yml`
`ansible-playbook main.yml -i hosts.yml -e @vault.yml --ask-vault-pass`

# Disable hypervisor can supposedly casue performance issues
```
 <cpu mode='host-model' check='none'>
    // ...
    <feature policy='disable' name='hypervisor'/>
 </cpu>
```
