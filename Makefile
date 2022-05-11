ISO=fedora-coreos-35.20220424.3.0-live.x86_64.iso
.PHONY: boot.ign microshift.ign

$(ISO):
	podman run --privileged --pull=always --rm -v ./workdir:/data -w /data quay.io/coreos/coreos-installer:release download -f iso

boot.ign:
	podman run --interactive --pull=always --rm -v ./workdir:/data/workdir -v ./butane:/data -w /data --security-opt label=disable quay.io/coreos/butane:release \
       --pretty --strict -d /data < ./butane/boot.bu > ./workdir/boot.ign

microshift.ign:
	podman run --interactive --pull=always --rm -v ./butane:/data -w /data --security-opt label=disable  quay.io/coreos/butane:release \
       --pretty --strict -d /data < ./butane/microshift.bu > ./workdir/microshift.ign

embed:
	podman run --privileged --pull=always --rm -v ./workdir:/data -w /data quay.io/coreos/coreos-installer:release iso ignition embed -f -i boot.ign $(ISO)

all: $(ISO) microshift.ign boot.ign embed
