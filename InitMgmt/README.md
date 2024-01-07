# Ansible Playbook for System Initialization and Management

## Overview
This Ansible playbook is designed for comprehensive and automated initialization and management of Linux systems. It's suitable for both local and remote environments, targeting distributions like Debian/Ubuntu and Fedora/CentOS/Oracle/RedHat. The playbook includes tasks for setting up common packages, configuring user environments, and establishing secure SSH access.

## Features
- **Local and Remote Deployment**: Can be used on both local and remote machines for consistent environment setup.
- **Enhanced VIM and Screen Setup**: Configures VIM with NERDTree and sets up `screen` with several useful features.
- **User and Group Management**: Automates the creation of users and groups, along with setting passwords and configuring locales.
- **SSH Configuration**: Sets up secure SSH access with authorized keys.
- **Sudo Privileges**: Enables passwordless sudo access for specific user groups.
- **Custom User Environments**: Deploys personalized settings for tools like vim and screen.

## Prerequisites
- For local setup: Ansible needs to be installed on the machine. Run `bash ./scripts/init_install.sh` to install Ansible.
- For remote setup: SSH access and sudo privileges on the target machines.

## Usage

### Local Machine Setup
1. Update the vars/vault.yml file with your data and credentails like user, group, ssh public key etc
2. Run `bash ./scripts/init_install.sh` to install Ansible.
3. Use `hosts: localhost` in the playbook to target the local machine.
4. Run `ansible-playbook init_mgmt.yml` to execute the playbook locally.

### Remote Machine Setup
1. Add the remote machines to the `inventory` file.
2. Specify the group or hosts in the `- hosts` section of the playbook.
3. Run `ansible-playbook init_mgmt.yml` to execute the playbook on the specified remote machines.

## Configuration
- **Hosts**: Define target machines in the `hosts` inventory file for remote execution.
- **Variables**: Customize user details and system settings in `vars/vault.yml`.
- **Tasks**: Modify or extend tasks as needed.

## Security
- Secure your `vars/vault.yml` file, as it contains sensitive user information.
- Adjust SSH and sudo configurations according to your security policies.
