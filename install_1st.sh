#/bin/sh
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get install -y --force-yes qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils virt-manager qemu-system
sudo adduser root libvirtd
sudo adduser root kvm
sudo rm /etc/libvirt/libvirtd.conf
sudo cp libvirtd.conf /etc/libvirt/libvirtd.conf
chmod 777 /etc/libvirt/libvirtd.conf
sudo reboot -f
