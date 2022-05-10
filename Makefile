.PHONY: boot.ign microshift.ign

fedora-coreos-35.20220424.3.0-live.x86_64.iso:
	podman run --privileged --pull=always --rm -v .:/data -w /data quay.io/coreos/coreos-installer:release download -f iso

boot.ign:
	podman run --interactive --pull=always --rm -v "${PWD}":/data -w /data --security-opt label=disable  quay.io/coreos/butane:release \
       --pretty --strict -d /data < boot.bu > boot.ign

microshift.ign:
	podman run --interactive --pull=always --rm -v "${PWD}":/data -w /data --security-opt label=disable  quay.io/coreos/butane:release \
       --pretty --strict -d /data < microshift.bu > microshift.ign

embed:
	podman run --privileged --pull=always --rm -v .:/data -w /data quay.io/coreos/coreos-installer:release iso ignition embed -f -i boot.ign ./fedora-coreos-35.20220424.3.0-live.x86_64.iso

all: fedora-coreos-35.20220424.3.0-live.x86_64.iso microshift.ign boot.ign embed
