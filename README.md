# meta-avocado

Avocado layer for Yocto

## Description

AvocadOS is a composable runtime managed by Peridio.

## Dependencies

* [kas](https://kas.readthedocs.io/en/latest/userguide.html#dependencies-installation)

## Setup

Create a build directory and clone meta-avocado into that directory.
In this example we create a build directory for the `qemuarm64-secureboot`
machine.

```bash
mkdir build-qemuarm64-secureboot
cd build-qemuarm64-secureboot
git clone git@github.com/peridio/meta-avocado
```

## Build

This repository has been officially tested for the following machines:

* Qemu Arm64 Secureboot

Machine configuration files may bring in other layers and are found at:
`meta-avocado/conf/kas/machine`

To build for a machine

```bash
  kas build meta-avocado/conf/kas/machine/qemuarm64-secureboot.yml
```

## Runtime

Testing of the runtime can be done using the `qemuarm64-secureboot` machine.
Build this configuration, then execute the following to produce the runtime
artifacts:

Convert the fwup archive into an image

```bash
fwup -a \
-t complete \
-i build/tmp/deploy/images/qemuarm64-secureboot/avocado-image-base-qemuarm64-secureboot.fw \
-d build/tmp/deploy/images/qemuarm64-secureboot/avocado-image-base-qemuarm64-secureboot.img
```

Resize the image:

```bash
qemu-img resize --shrink -f raw build/tmp/deploy/images/qemuarm64-secureboot/avocado-image-base-qemuarm64-secureboot.img 512M
```

Boot the qemu machine:

```bash
qemu-system-aarch64 \
  -M virt,secure=on,highmem=off \
  -bios build/tmp/deploy/images/qemuarm64-secureboot/flash.bin \
  -cpu cortex-a53 \
  -device sdhci-pci \
  -device sd-card,drive=mmc \
  -device virtio-net-device,netdev=eth0 \
  -device virtio-rng-device,rng=rng0 \
  -drive file=build/tmp/deploy/images/qemuarm64-secureboot/avocado-image-base-qemuarm64-secureboot.img,if=none,format=raw,id=mmc \
  -m 1024 \
  -netdev user,id=eth0,hostfwd=tcp::10022-:22 \
  -no-acpi \
  -nographic \
  -object rng-random,filename=/dev/urandom,id=rng0 \
  -rtc base=utc,clock=host \
  -smp 2
```
