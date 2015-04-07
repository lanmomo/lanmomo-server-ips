# server-ips

IPs for LAN Montmorency DHCP reservation and DNS zone.

## Instructions

Add the new entries to the `ips.txt` file (be careful to respect the current format):

    vim src/ips.txt

Build the `dhcp.xml` and `lanmomo.ca` files:

    ./build.sh

Commit and push your changes:

    git add -A && git commit -m 'Updated ips.txt file.' && git push
