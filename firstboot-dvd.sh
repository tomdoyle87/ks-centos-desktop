#!/bin/bash
ping -c3 1.1.1.1 || exit 0 #script only runs if online
OS=$(awk -F= '/^PRETTY_NAME/{print $2}' /etc/os-release)
case $OS in

  *"Rocky Linux 8.6"*)
	dnf config-manager --set-enabled powertools
		dnf install -y epel-release
    ;;

  *"Rocky Linux 9.0"*)
	dnf config-manager --set-enabled crb
		dnf install -y epel-release
		
    ;;

  *"CentOS Stream 8"*)
	dnf config-manager --set-enabled powertools
		dnf install -y pel-release epel-next-release
    ;;

  *"CentOS Stream 9"*)
	dnf config-manager --set-enabled powertools
		dnf install -y epel-release epel-next-release
    ;;

  *"AlmaLinux 8.6"*)
	dnf config-manager --set-enabled powertools
		dnf install -y epel-release
    ;;

  *"AlmaLinux 9.0"*)
	dnf config-manager --set-enabled crb
		dnf install -y epel-release
    ;;

  *)
    echo -n "unknown"
    ;;
esac
systemctl disable firstboot.service 
rm -f /etc/systemd/system/firstboot.service
rm -f /usr/local/bin/firstboot.s
