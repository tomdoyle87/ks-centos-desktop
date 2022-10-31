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
    	    -map dvd/AppStream/ /AppStream/ \
    	    -map dvd/BaseOS/ /BaseOS
    
    isohybrid --uefi Saincheaptha-DVD.iso
    implantisomd5 --supported-iso Saincheaptha-DVD.iso
    sudo umount dvd/
