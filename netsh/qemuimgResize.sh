qemu-img resize /var/lib/libvirt/images/$1.img $2
virsh pool-refresh default
