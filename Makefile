fedora-coreos-35.20220410.3.1-live.x86_64.iso:
	podman run --privileged --pull=always --rm -v .:/data -w /data quay.io/coreos/coreos-installer:release download -f iso

boot.ign:
	podman run --interactive --pull=always --rm -v "${PWD}":/data -w /data --security-opt label=disable  quay.io/coreos/butane:release \
       --pretty --strict -d /data < boot.bu > boot.ign

embed:
	podman run --privileged --pull=always --rm -v .:/data -w /data quay.io/coreos/coreos-installer:release iso ignition embed -i boot.ign ./fedora-coreos-35.20220410.3.1-live.x86_64.iso

all: fedora-coreos-35.20220410.3.1-live.x86_64.iso boot.ign embed
