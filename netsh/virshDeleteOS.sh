virsh destroy $1
virsh undefine $1
virsh vol-delete $1.img --pool default
