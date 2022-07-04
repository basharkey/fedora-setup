#!/usr/bin/env bash
sudo dnf install -y ansible python3 python3-virtualenv
ansible-galaxy install -r requirements.yml

virtualenv .
source bin/activate
bin/pip3 install lxml selinux

ansible-playbook main.yml -i hosts.yml -e @vault.yml --ask-vault-pass
