#!/bin/bash

INVENTORY_FILE="vagrant_inventory.ini"
ANSIBLE_GROUP="[lab]"

rm -f $INVENTORY_FILE
echo $ANSIBLE_GROUP > $INVENTORY_FILE

vagrant status | grep running | awk '{print $1}' | while read VM_NAME; do
    # Pobranie informacji SSH dla maszyny
    vagrant ssh-config $VM_NAME | while read LINE; do
        if [[ $LINE == *"HostName"* ]]; then
            IP=$(echo $LINE | awk '{print $2}')
            echo "$VM_NAME ansible_host=$IP ansible_user=vagrant ansible_ssh_pass=vagrant" >> $INVENTORY_FILE
        fi
    done
done

echo "Inventory file was generated in the $INVENTORY_FILE file"

