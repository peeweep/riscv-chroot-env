### RISC-V chroot environment on Gentoo Linux for qemu-user

If possible, it will create a BtrFS subvolume to store the stage3, and disable the CoW.

#### depends on:

* bubblewrap
* qemu-user binary (static linked)
  ```bash
  # can be installed on gentoo linux by:
  echo "app-emulation/qemu static-user QEMU_USER_TARGETS: riscv32 riscv64" >>/etc/portage/package.use/qemu
  emerge -vj app-emulation/qemu --autounmask # may need to do something more by yourself here
  ```
* [Register binary format handlers](https://wiki.gentoo.org/wiki/Embedded_Handbook/General/Compiling_with_qemu_user_chroot#Register_binary_format_handlers)

#### init

1. modify `./env` to set proper values
2. option: add/delete/modify files under `./conf.d/` to do custom settings (the default number of jobs is: nproc - 2),
   all files under this dir will be pasted to `<chroot-rootfs>/etc/portage/`,
   except `make.conf`, which will be appended to `<chroot-rootfs>/etc/portage/make.conf`.

```bash
# Get the latest stage3 tarball
./getLatest.sh # default to use 'rv64_lp64d-openrc'

./createRootFS.sh [instance-name] # this name should not be started in a '-'
```

#### chroot *(the daily used)*

```bash
./chroot.sh [instance-name]
# you can set an alias to use it at any place
```

#### update portage config
```bash
./updateEnv.sh [instance-name]
```

#### clear tmpfs

```bash
./clearMount.sh [instance-name]
```

#### destroy

```bash
./deleteRootFS.sh [instance-name]
```
