#!/bin/bash
# The script is required to install ansible before running playbooks on local envirnoment

# Updating system packages
echo "Updating the system..."
sudo dnf update -y

# Installing the EPEL repository
echo "Installing the EPEL repository..."
sudo dnf install epel-release -y

# Installing Ansible
echo "Installing Ansible..."
sudo dnf install ansible -y

# Checking the Ansible version
echo "Checking the Ansible version..."
ansible --version
