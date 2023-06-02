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
