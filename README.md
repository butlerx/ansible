# ansible

Ansible automation for raspberrypi and scaleway vpc

## Requirements

- Ansible >3.0
- SSHPass
- passwordstore password manager and repo

## Installation

install dependencies

```bash
ansible-galaxy install -r requirements.yml
```

then run the playbook

```bash
ansible-playbook site.yml
```
