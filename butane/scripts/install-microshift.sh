#!/bin/bash
set -eux

curl -L -o /etc/yum.repos.d/fedora-modular.repo https://src.fedoraproject.org/rpms/fedora-repos/raw/rawhide/f/fedora-modular.repo
curl -L -o /etc/yum.repos.d/fedora-updates-modular.repo https://src.fedoraproject.org/rpms/fedora-repos/raw/rawhide/f/fedora-updates-modular.repo
curl -L -o /etc/yum.repos.d/group_redhat-et-microshift-fedora-35.repo https://copr.fedorainfracloud.org/coprs/g/redhat-et/microshift/repo/fedora-35/group_redhat-et-microshift-fedora-35.repo
rpm-ostree ex module enable cri-o:1.21
rpm-ostree install cri-o cri-tools microshift

# Install WiFi firmware
rpm-ostree install iwl7260-firmware

curl -L https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable-4.8/openshift-client-linux-4.8.52.tar.gz -o /tmp/oc.tar.gz
tar xzf /tmp/oc.tar.gz -C /usr/local/bin/

touch /var/lib/.microshift-installed

systemctl reboot
