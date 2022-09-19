#!/bin/bash
VAR1=$(dmidecode --string chassis-type)
case "$VAR1" in
        Notebook|Portable|Portable|'Hand Held'|'Sub Notebook'|'Lunch Box')
        	dnf -y install epel-release
        	dnf -y install tlp
                sed -i 's/TLP_ENABLE=0/TLP_ENABLE=1/' /etc/default/tlp
                systemctl enable tlp
                systemctl start tlp
                # disable epel, as its only required to install tlp. 
        	sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/epel.repo
        	dnf clean all
        	[ -f /etc/default/tlp ] && sed -i 's/TLP_ENABLE=0/TLP_ENABLE=1/' /etc/default/tlp || systemctl mask power-profiles-daemon.service
        	systemctl enable tlp
                systemctl start tlp
                #setup monthly check for tlp updates
                set -f
                cat <<EOF >>/lib/systemd/system/tlp-update.service
[Unit]
Description=Check For TLP updates
After=network.target
[Service]
ExecStart=dnf --disablerepo=* --enablerepo=epel update -y
[Install]
WantedBy=multi-user.target
EOF
		cat <<EOF >>/lib/systemd/system/tlp-update.timer
[Unit]
Description=Timer for Check For TLP updates
[Timer]
OnCalendar=*-*-01 13:00:00
[Install]
WantedBy=timers.target
EOF
		set +f
		systemctl enable --now tlp-update.timer
                ;;
        *)echo tlp not required;;
esac
systemctl disable firstboot.service 
rm -f /etc/systemd/system/firstboot.service
rm -f /usr/local/bin/tlp.sh
