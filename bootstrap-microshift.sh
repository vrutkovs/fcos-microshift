#!/bin/bash
set -eux

systemctl enable --now microshift

OPERATOR_SDK_VERSION="v1.20.0"

curl -L -o /usr/local/bin/operator-sdk https://github.com/operator-framework/operator-sdk/releases/download/${OPERATOR_SDK_VERSION}/operator-sdk_linux_amd64
chmod a+x /usr/local/bin/operator-sdk

# TODO: wait for file to appear here
cp -rvf /var/lib/microshift/resources/kubeadmin/kubeconfig /tmp/kubeconfig
export KUBECONFIG=/tmp/kubeconfig
operator-sdk olm install

oc create -f https://operatorhub.io/install/argocd-operator.yaml

oc apply -f /etc/microshift/manifests/argocg-settings.yaml
oc apply -f /etc/microshift/manifests/cluster-app.yaml

touch /var/lib/.microshift-provisioned
