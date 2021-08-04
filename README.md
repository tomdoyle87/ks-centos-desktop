#  ks-centos-desktop
**Disclaimer I am not associated with Centos/Fedora, Rocky projects or Redhat.**

This is a kickstart receipe which will install all that is required for the Gnome Workstation on centos 8/stream or Rocky Linux. Root password is disabled and dhcp by default. TLP is installed and enabled if installed on laptop to save battery life. 

isolinux.cfg, menu entry:

label linux<BR>
&nbsp;&nbsp;menu label ^Install \*Rocky Linux 8\* or \*Centos Linux 8\*<BR>
&nbsp;&nbsp;menu default<BR>
&nbsp;&nbsp;kernel vmlinuz<BR>
&nbsp;&nbsp;append initrd=initrd.img inst.stage2=hd:LABEL=\*ISO Label\* inst.ks=cdrom:/dev/cdrom:/\*ks.cfg\* or \*rocky-ks.cfg\*

Please enjoy any thoughts/issues are welcome. 
