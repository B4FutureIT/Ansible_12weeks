# Useful commands
```
ansible localhost -m setup

$ ansible localhost -m setup -a 'filter=ansible_all_ipv6_addresses'
available
localhost | SUCCESS => {
    "ansible_facts": {
        "ansible_all_ipv6_addresses": [
            "2a02:a31d:a2ea:e000::3845",
            "fe80::8460:4f26:9e68:9f38",
            "fe80::d8c2:44ff:fe97:cd7",
            "fe80::42:aeff:fe8f:5ea7"
        ]
    },
    "changed": false
}
```