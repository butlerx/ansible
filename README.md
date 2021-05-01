# rpi-ansible

## Requirements

- Flash a **clean** Raspbian Lite image on an SD card URL: https://www.raspberrypi.org/downloads/raspbian/ Mac: Use
  [ApplePI-Baker](https://www.tweaking4all.com/software/macosx-software/macosx-apple-pi-baker/)
- Enable SSH on the Raspberry (it is disabled by default). You can:
  - use `raspi-config` to enable SSH
  - create a file `/boot/ssh`
- Find the IP address your router will give to the RPI
- You need Ansible installed on your local computer (not the Raspberry Pi)
- Install SSHPass:

## Installation

install dependencies

```
ansible-galaxy install -r requirements.yml
```

then run the playbook

```
ansible-playbook site.yml
```
