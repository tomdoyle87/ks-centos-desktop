#  ks-centos-desktop
**Disclaimer I am not associated with Centos/Fedora, Rocky projects or Redhat.**

This is a kickstart receipe which will install all that is required for the Gnome Workstation on centos 8/stream or Rocky Linux. Root password is disabled and dhcp by default. TLP is installed and enabled if OS is installed on a laptop to save battery life, epel repo used during install for this; not enabled once installed os is booted. For Rocky 9 (if installed on laptop), Gnome power profiles are disabled as not compatible with TLP and current concensus is that TLP still has the edge. 

## How To

### Rocky Linux:

rocky-ks.cfg can be used for either Rocky Linux 8 or 9 details below:<BR>
  
cd ~<BR> 
git clone https://github.com/tomdoyle87/ks-centos-desktop.git<BR>
cd ks-centos-desktop<BR>
wget https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-boot.iso **or** wget https://download.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-9.0-x86_64-boot.iso<BR>
mkdir Rocky<BR>
sudo mount -o loop Rocky-8.6-x86_64-boot.iso Rocky/ **or** sudo mount -o loop Rocky-9.0-x86_64-boot.iso Rocky/<BR> 
mkdir Rocky.new<BR>
sudo rsync -av Rocky/ Rocky.new/<BR>
sudo cp rocky-ks.cfg firstboot.service tlp.sh Rocky.new/<BR>
cd Rocky.new/<BR>
sudo sed -i '/menu default/d' isolinux/isolinux.cfg<BR>
sudo vi isolinux/isolinux.cfg

**Update label linux as follows:**

    label linux
      menu label ^Install Rocky Linux Workstation
      menu default 
      kernel vmlinuz
      append initrd=initrd.img inst.repo=cdrom inst.ks=cdrom:/rocky-ks.cfg quiet
 
sudo mkisofs -o ./Rocky-ks.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -V "Rocky-x86_64-boot" .<BR>
<BR>
sudo chown $USER:$USER Rocky-ks.iso

### Centos8-Stream:

cd ~<BR>
git clone https://github.com/tomdoyle87/ks-centos-desktop.git<BR>
cd ks-centos-desktop<BR>
wget http://uk.mirror.nsec.pt/centos/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-20210803-boot.iso<BR>
mkdir Centos8<BR>
sudo mount -o loop CentOS-Stream-8-x86_64-20210803-boot.iso Centos8/<BR>
mkdir Centos8.new<BR>
sudo rsync -av Centos8/ Centos8.new/<BR>
sudo cp centos8-ks.cfg Centos8.new/<BR>
cd Centos8.new/<BR>
sudo sed -i '/menu default/d' isolinux/isolinux.cfg<BR>
sudo vi isolinux/isolinux.cfg

**Update label linux as follows:**

    label linux
      menu label ^Install CentOS Stream 8-stream
      menu default 
      kernel vmlinuz
      append initrd=initrd.img inst.stage2=hd:LABEL=CentOS-Stream-8-x86_64-dvd inst.ks=cdrom:/dev/cdrom:/centos8-ks.cfg

sudo mkisofs -o ./Centos8-stream-ks.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -l -r -T -v -V "CentOS-Stream-8-x86_64-dvd" .<BR>
<BR>
sudo chown $USER:$USER Centos8-stream-ks.iso<BR>

### Removal
Once you have copied the iso to a safe place for use, you can safely remove as follows:<BR>
<BR>
cd ~/ks-centos-desktop/<BR>
sudo umount Rocky/ **or** sudo umount Centos8/<BR>
cd ..<BR>
sudo rm -r ks-centos-desktop/<BR>

### Alternative installer-script
Currently I am unable to make an iso, that will boot on my test laptops. Through my research, others have reported similar issues since Rhel 8.3. I've narrowed down the issue to the ISO generation (mkisofs), but as of yet be unable to find an ISO generation method that works (images work fine on virtualized). I will continue to look into this and if any body can provide instructions or hints on the correct procedure, it will be gratefully received. In the meantime, I've produced a script which can be run after a minimal install (I recommend setting up an admin (non-root) user), from an offical media. I've tested the script on Rocky Linux 8 & 9, should also work on centos stream and almalinux. Can be downloaded here:<BR>
<BR>
https://raw.githubusercontent.com/tomdoyle87/ks-centos-desktop/main/autoinstall-workstation.sh
<BR>
<BR>
To run issue:<BR>
<BR>
sudo su
. autoinstall-workstation.sh

<BR>
<BR>
ISO generation source: https://gist.github.com/brasey/cb503c6d0344728d15c4
