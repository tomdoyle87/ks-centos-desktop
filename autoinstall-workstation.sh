#!/bin/bash
set +o history
dnf -y upgrade
dnf install -y @Workstation @container-management @gnome-apps @internet-applications kexec-tools
systemctl set-default graphical.target
cd /usr/share/xsessions/
rm -f com.redhat.Kiosk.desktop gnome-custom-session.desktop xinit-compat.desktop
sed -i '12s/.*/Name=Gnome Classic on Xorg/' gnome-classic.desktop
sed -i '12s/.*/Name=Gnome on Xorg/' gnome.desktop
sed -i '12s/.*/Name=Gnome on Xorg/' gnome-xorg.desktop
cd /usr/share/wayland-sessions
sed -i '12s/.*/Name=Gnome Classic/' gnome-classic-wayland.desktop
sed -i '12s/.*/Name=Gnome/' gnome.desktop
# TLP Powersavings only enabled for Laptops
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
reboot 0
