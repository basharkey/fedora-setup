deps:
	sudo apt install --no-install-recommends -y ansible
	ansible-galaxy install -r requirements.yml
vault:
	ansible-vault encrypt vault.yml
desktop:
	ansible-playbook main.yml -i hosts.yml --ask-become-pass --tags "desktop"
music:
	ansible-playbook main.yml -i hosts.yml --ask-become-pass --extra-vars "override=music" --tags "music"
