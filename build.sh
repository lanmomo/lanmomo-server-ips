#!/bin/bash

# Directories
BUILD=build
SRC=src

# Delete current build
rm -rf $BUILD

# Prepare build
mkdir $BUILD

# Build
cat $SRC/ips.txt | while read line ; do

    # Variables
    host=$(echo "$line" | cut -f 1)
    desc=$(echo "$line" | cut -f 3)
    ip=$(echo "$line" | cut -f 4)
    mac=$(echo "$line" | cut -f 5)

    # Build lanmomo.ca
    echo "${host}.lan 86400 IN A ${ip}" >> $BUILD/lanmomo.ca

    # Build dhcp.xml
    cat >> $BUILD/dhcp.xml << EOF
			<staticmap>
				<mac>${mac}</mac>
				<ipaddr>${ip}</ipaddr>
				<hostname>${host}</hostname>
				<descr>${desc}</descr>
				<filename/>
				<rootpath/>
				<defaultleasetime/>
				<maxleasetime/>
				<gateway/>
				<domain/>
				<domainsearchlist/>
				<ddnsdomain/>
				<tftp/>
				<ldap/>
			</staticmap>
EOF

done
