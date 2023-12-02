# Virtual Lab Automation Project

## Overview

This project automates the setup and management of a virtual lab environment using Vagrant and Ansible. It involves creating five virtual machines (VMs), generating an Ansible inventory file, conducting connectivity tests, collecting data from all machines, and creating a detailed report of the infrastructure.

## Key Components

- **Vagrant**: Utilized for provisioning and managing the VMs.
- **Ansible**: Employed for configuration management and data collection from VMs.
- **Bash Script (`inventory.sh`)**: Generates an Ansible inventory file.
- **Ansible CMDB (`ansible-cmdb`)**: Ansible-cmd takes the output of Ansible's fact gathering and converts it into a static HTML overview page (and other things) containing system configuration information. Please check the https://ansible-cmdb.readthedocs.io/en/latest/ URL.


## Workflow

### 1. VM Creation with Vagrant
   - Vagrant is configured to create 5 VMs as defined in the `Vagrantfile`.
   - Each VM is based on the `generic/ubuntu2004` box, with specific memory and CPU configurations.
   - VMs are provisioned using an Ansible playbook, as specified in the Vagrant configuration.

   - A script that generates an Ansible inventory file named `vagrant_inventory.ini`.
   - Extracts VM information, including IP addresses and SSH credentials.

   - Conducts a connectivity test for all VMs using Ansible's ping module.

##### Vagrant Configuration (`Vagrantfile`)

```ruby
Vagrant.configure("2") do |config|
  config.vm.provider :libvirt do |libvirt|
    libvirt.driver = "kvm"
  end

  (1..5).each do |i|
    config.vm.define "vm0#{i}" do |vm|
      vm.vm.box = "generic/ubuntu2004"
      vm.vm.provider :libvirt do |libvirt|
        libvirt.memory = 512
        libvirt.cpus = 1
      end
      vm.vm.provision "ansible" do |ansible|
        ansible.playbook = "playbook.yml"
      end
    end
  end
end
```
```bash
vagrant up
```



### 2. Generate Ansible Inventory File
The script generates the ansible inventory vagrant_inventory.ini file. 

```bash
#!/bin/bash

INVENTORY_FILE="vagrant_inventory.ini"
ANSIBLE_GROUP="[lab]"

rm -f $INVENTORY_FILE
echo $ANSIBLE_GROUP > $INVENTORY_FILE

vagrant status | grep running | awk '{print $1}' | while read VM_NAME; do
    vagrant ssh-config $VM_NAME | while read LINE; do
        if [[ $LINE == *"HostName"* ]]; then
            IP=$(echo $LINE | awk '{print $2}')
            echo "$VM_NAME ansible_host=$IP ansible_user=vagrant ansible_ssh_pass=vagrant" >> $INVENTORY_FILE
        fi
    done
done
```
```bash
./inventory.sh 
Inventory file was generated in the vagrant_inventory.ini file
```
### 3. Sample Ansible Commands
Test VM Connectivity:

```bash
ansible -i vagrant_inventory.ini all -m ping -o
```

### 4. Data Collection with Ansible
   - Uses Ansible's setup module to collect comprehensive data from each VM.
   - Data is stored in the `infra` directory.

```bash
mkdir infra/
ansible -i vagrant_inventory.ini -m setup --tree infra/ all
```

### 5. Infrastructure Report Generation (`infra.html`)

#### Generate Infrastructure Report:
Generates a detailed HTML report of the infrastructure using `ansible-cmdb`.

```bash
ansible-cmdb infra/ > infra.html
```

### Usage Instructions
- Start the VMs with vagrant up.
- Execute the inventory.sh script to generate the inventory file.
- Test VM connectivity using Ansible's ping module.
- Collect data from VMs using the Ansible setup module.
- Generate an HTML report of the infrastructure with ansible-cmdb.
