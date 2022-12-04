deps:
	sudo dnf install -y ansible
	ansible-galaxy install -r requirements.yml
vault:
	ansible-vault encrypt vault.yml
install:
	ansible-playbook main.yml -i hosts.yml -e @vault.yml --ask-vault-pass
