deps:
	sudo apt install --no-install-recommends -y ansible
	ansible-galaxy install -r requirements.yml
vault:
	ansible-vault encrypt vault.yml
install:
	ansible-playbook main.yml -i hosts.yml -e @vault.yml --ask-vault-pass --ask-become-pass
