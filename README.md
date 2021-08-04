#  ks-centos-desktop
**Disclaimer I am not associated with Centos/Fedora, Rocky projects or Redhat.**

This is a kickstart receipe which will install all that is required for the Gnome Workstation on centos 8/stream or Rocky Linux. Root password is disabled and dhcp by default. TLP is installed and enabled if installed on laptop to save battery life, epel repo used during install for this; not enabled once installed os is booted. 

## How To

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
<BR>
*Essentially the same for Centos 8 (non-stream) just replace the wget url with a download for am centos8 iso and update the mount command.*

### Rocky8:
  
cd ~<BR> 
git clone https://github.com/tomdoyle87/ks-centos-desktop.git<BR>
cd ks-centos-desktop<BR>
wget https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.4-x86_64-boot.iso<BR>
mkdir Rocky8<BR>
sudo mount -o loop Rocky-8.4-x86_64-boot.iso Rocky8/<BR>
mkdir Rocky8.new<BR>
sudo rsync -av Rocky8/ Rocky8.new/<BR>
sudo cp rocky-ks.cfg Rocky8.new/<BR>
cd Rocky8.new/<BR>
sudo vi isolinux/isolinux.cfg

**Update label linux as follows:**

    label linux
      menu label ^Install Rocky Linux 8
      menu default 
      kernel vmlinuz
      append initrd=initrd.img inst.stage2=hd:LABEL=CentOS-Stream-8-x86_64-dvd inst.ks=cdrom:/dev/cdrom:/rocky-ks.cfg
 
sudo mkisofs -o ./Rocky8-ks.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -l -r -T -v -V "Rocky-8-4-x86_64-dvd" .<BR>
<BR>
sudo chown $USER:$USER Rocky8-ks.iso

### Removal
Once you have copied the iso to a safe place for use, you can safely remove as follows:<BR>
<BR>
cd ~/ks-centos-desktop/<BR>
sudo umount Rocky8/ **or** sudo umount Centos8<BR>
cd ..<BR>
sudo rm -r ks-centos-desktop/<BR>
<BR>
<BR>
source: https://gist.github.com/brasey/cb503c6d0344728d15c4
