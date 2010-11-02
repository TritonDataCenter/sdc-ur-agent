#!/bin/bash

cat << __END__
boot-file=/platform/i86pc/kernel/amd64/unix
whoami=/platform/i86pc/kernel/amd64/unix
console=text
admin-nic=a4:ba:db:1e:1a:df
boot-args= -k
bootargs= -k
mfg-name=i86pc
impl-arch-name=i86pc
plat-max-ncpus=32
boot-max-ncpus=16
boot-ncpus=16
keyboard-layout=Unknown
ata-dma-enabled=1
atapi-cd-dma-enabled=1
ttyb-rts-dtr-off=false
ttyb-ignore-cd=true
ttya-rts-dtr-off=false
ttya-ignore-cd=true
ttyb-mode=9600,8,n,1,-
ttya-mode=9600,8,n,1,-
lba-access-ok=1
__END__

exit 0
