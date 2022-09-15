#!/bin/bash
VAR1=$(dmidecode --string chassis-type)
echo $VAR1
case "$VAR1" in
        Notebook|Portable|Portable|'Hand Held'|'Sub Notebook'|'Lunch Box')
                sed -i 's/TLP_ENABLE=0/TLP_ENABLE=1/' /etc/default/tlp
                systemctl enable tlp
                systemctl start tlp
                ;;
        *)ln -s /dev/null /etc/systemd/system/tlp.service;;
esac
systemctl disable firstboot.service 
rm -f /etc/systemd/system/firstboot.service
rm -f /usr/local/bin/tlp.sh
