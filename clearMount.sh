#!/bin/bash
#

. "./env"

findmnt ${rootfs}tmp/ >/dev/null && umount ${rootfs}tmp/ || true
findmnt ${rootfs}var/tmp/ >/dev/null && umount ${rootfs}var/tmp/ || true