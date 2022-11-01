#  ks-centos-desktop
**Disclaimer I am not associated with Centos/Fedora, Rocky Linux, Alma or Redhat.**

This is a kickstart receipe which will install all that is required for the Gnome Workstation on Centos Stream, Rocky Linux Or Almalinux. Root password is disabled. TLP is installed and enabled if OS is installed on a laptop to save battery life. Epel & powertools/crb repos enabled by default. For Stream/Rocky/Alma 9 Gnome power profiles is disabled.

Also comes with a custom firewalld based one the one used in fedora, with ssh inbound disabled. 

## How To
### Boot ISO

Download Boot iso for the distro of your choice this will need to placed the ks-centos-desktop directory, which is created below.<BR>

    cd ~
    git clone https://github.com/tomdoyle87/ks-centos-desktop.git
    cd ks-centos-desktop
    
	/usr/bin/xorriso \
    	-indev *.iso \
    	-outdev Saincheaptha.iso \
    	-boot_image any replay \
    	-joliet on \
    	-system_id LINUX \
    	-compliance joliet_long_names \
    	-volid Saincheaptha-x86_64-boot \
    	-map ks.cfg ks.cfg \
    	-map firstboot.service firstboot.service \
    	-map firstboot.sh firstboot.sh \
    	-map isolinux.cfg isolinux/isolinux.cfg \
    	-map grub.cfg /EFI/BOOT/grub.cfg \
    	-map firewalld-workstation.conf firewalld-workstation.conf \
    	-map Saincheaptha.xml Saincheaptha.xml

    isohybrid --uefi Saincheaptha.iso 
    implantisomd5 --supported-iso Saincheaptha.iso --force

### DVD ISO

Too Add tlp to the dvd iso we need to create a local repo. To begin with you need to download the tlp & tlp-rdw for the distro you chose above. You can find out the rpms required here: https://rpmfind.net/linux/rpm2html/search.php?query=tlp*&submit=Search+...&system=epel&arch=. So for example for RHEL 8:
	
    sudo dnf install createrepo or  sudo apt-get install createrepo-c
    cd ~/ks-centos-desktop
    wget https://rpmfind.net/linux/epel/8/Everything/x86_64/Packages/t/tlp-1.2.2-4.el8.noarch.rpm
    wget https://rpmfind.net/linux/epel/8/Everything/x86_64/Packages/t/tlp-rdw-1.2.2-4.el8.noarch.rpm
    mkdir tlp
    mv tlp-1.2.2-4.el8.noarch.rpm tlp-rdw-1.2.2-4.el8.noarch.rpm tlp/
    createrepo tlp or createrepo-c tlp
	
	
You need to create a boot iso, using the instuctions above. Then please download a DVD iso for this distro and version you chose above, to the ks-centos-desktop directory.<BR>

    cd ~/ks-centos-desktop 
    mkdir dvd 
    sudo mount -o loop *dvd*iso dvd/ 
    
	/usr/bin/xorriso \
	    -indev Saincheaptha.iso \
	    -outdev Saincheaptha-DVD.iso \
	    -boot_image any replay \
	    -joliet on \
	    -system_id LINUX \
	    -compliance joliet_long_names \
	    -volid Saincheaptha-x86_64-boot \
	    -map dvd-ks.cfg ks.cfg \
	    -map firstboot-dvd.sh firstboot.sh \
	    -map dvd/AppStream/ /AppStream/ \
	    -map dvd/BaseOS/ /BaseOS/ \
	    -map tlp/ tlp/
    
    isohybrid --uefi Saincheaptha-DVD.iso
    implantisomd5 --supported-iso Saincheaptha-DVD.iso
    sudo umount dvd/
