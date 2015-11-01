#!/bin/bash

# Directories
BUILD=build
SRC=src

# Delete current build
rm -rf "$BUILD"

# Prepare build
mkdir "$BUILD"

DHCP="$BUILD/dhcpd.conf"

# Build

cat > "$DHCP" << EOF
#
# Configuration file for ISC dhcpd for LAN Montmorency 2015-11
#
#

ddns-update-style none;

option domain-name "lanmomo.org";
option domain-name-servers 172.16.16.1;

default-lease-time 6000;
max-lease-time 72000;

authoritative;

log-facility local7;

# Main DHCP pool

subnet 172.16.16.0 netmask 255.255.252.0 {
   range 172.16.18.1 172.16.19.254;
   option routers 172.16.16.1;
}

EOF

cat "$SRC/ips.txt" | while read line; do

    # Variables
    host=$(echo "$line" | cut -f 1 -d ';')
    desc=$(echo "$line" | cut -f 3 -d ';')
    ip=$(echo "$line" | cut -f 4 -d ';')
    mac=$(echo "$line" | cut -f 5 -d ';')

    # Build lanmomo.org
    echo "$host 86400 IN A $ip" >> "$BUILD/lanmomo.org"


    cat >> "$DHCP" << EOF

host $host {
    hardware ethernet $mac;
    fixed-address $ip;
}

EOF

done
