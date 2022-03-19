#!/usr/bin/env bash
#

set -e

myPath=$(dirname $(realpath $0))
. "${myPath}/preprocess.sh"

if [[ -e ${rootfs} ]]; then
  echo "exists"
  exit 0
fi

_PARENT=$(dirname ${rootfs})
mkdir -p ${_PARENT}
if btrfs inspect-internal rootid ${_PARENT} &>/dev/null; then
  set -- btrfs subvolume create ${rootfs} "&&" chattr +C ${rootfs}
else
  set -- mkdir -p ${rootfs}
fi

echo "${@}"
eval "${@}"

set -- tar xpf ${stage3_dir}stage3-*.tar.xz -C ${rootfs} --xattrs --xattrs-include='*.*' --exclude='./dev/*'
echo "${@}"
"${@}"

${myPath}/updateEnv.sh
