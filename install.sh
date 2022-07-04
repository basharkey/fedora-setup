#!/usr/bin/env bash
sudo dnf install -y ansible
ansible-galaxy install -r requirements.yml

ansible-playbook main.yml -i hosts.yml -e @vault.yml --ask-vault-pass
