# fedora-setup
Ansible playbooks used to setup Fedora

sudo dnf install -y ansible
ansible-playbook main.yml -i hosts.yml -e @vault.yml --ask-vault-pass

# Disable hypervisor can supposedly casue performance issues
 <cpu mode='host-model' check='none'>
    // ...
    <feature policy='disable' name='hypervisor'/>
 </cpu>
