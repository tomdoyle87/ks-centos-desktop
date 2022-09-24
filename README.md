#  ks-centos-desktop
**Disclaimer I am not associated with Centos/Fedora, Rocky Linux, Alma or Redhat.**

This is a kickstart receipe which will install all that is required for the Gnome Workstation on Centos Stream, Rocky Linux Or Almalinux. Root password is disabled. TLP is installed and enabled if OS is installed on a laptop to save battery life, epel repo used during install for this; not enabled once install is finished. For Stream/Rocky/Alma 9 (if installed on laptop), Gnome power profiles are disabled as not compatible with TLP and current concensus is that TLP still has the edge. 

## How To

cd ~<BR> 
git clone https://github.com/tomdoyle87/ks-centos-desktop.git<BR>
cd ks-centos-desktop<BR>
Download Boot iso for the distro of your choice<BR>
    
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
	    -map tlp.sh tlp.sh \
	    -map isolinux.cfg isolinux/isolinux.cfg \
	    -map grub.cfg /EFI/BOOT/grub.cfg

    isohybrid --uefi Saincheaptha.iso 
    implantisomd5 --supported-iso Saincheaptha.iso 
