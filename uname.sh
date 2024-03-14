#!/usr/bin/env bash

set -e

os_root="$(realpath "${OS_ROOT:-"/etc"}")"
fversion="${os_root}/os-version"
frelease="${os_root}/os-release"

if [ -f "${fversion}" ]; then
  system_name="$(< "${fversion}" grep 'SystemName=' | sed 's/SystemName=//g')"
  case ${system_name} in
  "UnionTech OS Server")
    echo -n "uos-server-$(< "${fversion}" grep 'MinorVersion=' | sed 's/MinorVersion=//g')$(< "${fversion}" grep 'EditionName=' | sed 's/EditionName=//g')"
    ;;
  "UnionTech OS Desktop")
    case $(< "${fversion}" grep 'OsBuild=' | sed 's/OsBuild=//g') in
    # uos-desktop-1050u3
    "11018.109")
      echo -n "uos-desktop-$(< "${fversion}" grep 'MinorVersion=' | sed 's/MinorVersion=//g')u3"
      ;;
    *)
      echo -n "uos-desktop-$(< "${fversion}" grep 'MinorVersion=' | sed 's/MinorVersion=//g')"
      ;;
    esac
    ;;
  *)
    echo -n "unknown"
    ;;
  esac
  exit 0
fi

if [ -f "${frelease}" ]; then
  echo -n "$(< "${frelease}" grep 'ID=' | grep -v 'VERSION_ID=' | grep -v 'PLATFORM_ID=' | sed 's/ID=//g' | sed 's/"//g')$(< "${frelease}" grep 'VERSION_ID=' | sed 's/VERSION_ID=//g' | sed 's/"//g')"
  exit 0
fi

echo "unknown"