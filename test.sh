#!/usr/bin/env bash

set -e

assert() {
  os_root="test/${1:?}" && \
  expected="${1:?}" && \
  got="$(OS_ROOT="${os_root}" bash uname.sh)" && \
  if [ "${got}" != "${expected}" ]; then
    echo "[FAILED] os_root: ${os_root}  expected: ${expected}  got: ${got}" && exit 1
  else
    echo "[PASSED] os_root: ${os_root}  expected: ${expected}  got: ${got}"
  fi
}

assert "debian7"
assert "debian8"
assert "debian9"
assert "debian10"
assert "debian11"
assert "debian12"

assert "centos7"
assert "centos8"

assert "ubuntu12.04"
assert "ubuntu14.04"
assert "ubuntu16.04"
assert "ubuntu18.04"
assert "ubuntu20.04"
assert "ubuntu22.04"

assert "deepin20.9"

assert "uos-desktop-1050u3"
assert "uos-desktop-1070u1"
assert "uos-server-1050e"

echo "==================== ALL TESTS PASSED ===================="