## archiso
This repository contains the files I use to generate my custom Arch Linux ISO, with the broadcom-wl-dkms package pre-installed. The reason it is pre-installed is so that I can connect to 
the Wi-Fi on my laptops with Broadcom chips. To use this repo yourself, run (as root):

	wget -cqO- https://git.io/va654 | tar -xz
	cp -a archiso/archlive /root/
	cp -a archiso/customrepo /root/
	cd ~/archlive
	./build.sh -v


