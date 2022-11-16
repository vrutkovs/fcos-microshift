#!/usr/bin/bash
set -x

wipefs -a /dev/sda
ignition_file='/var/lib/microshift.ign'
firstboot_args='console=tty0'
install_device='/dev/sdb'
cmd="coreos-installer install --firstboot-args=${firstboot_args}"
cmd+=" --ignition=${ignition_file}"
cmd+=" ${install_device}"
if $cmd; then
    echo "Install Succeeded!"
    exit 0
else
    echo "Install Failed!"
    exit 1
fi
