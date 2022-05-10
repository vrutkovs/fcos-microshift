#!/usr/bin/bash
set -x

ignition_file='/var/lib/microshift.ign'
firstboot_args='console=tty0'
if [ -b /dev/sda ]; then
    install_device='/dev/sda'
elif [ -b /dev/nvme0 ]; then
    install_device='/dev/nvme0'
else
    echo "Can't find appropriate device to install to" 1>&2
    poststatus 'failure'
    return 1
fi
cmd="coreos-installer install --firstboot-args=${firstboot_args}"
cmd+=" --ignition=${ignition_file}"
cmd+=" ${install_device}"
if $cmd; then
    echo "Install Succeeded!"
    return 0
else
    echo "Install Failed!"
    return 1
fi
