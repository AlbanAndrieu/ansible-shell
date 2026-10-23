#!/bin/bash
# set -xv

if [ "$0" = "${BASH_SOURCE[0]}" ]; then
  echo "This script has to be sourced and not executed..."
  exit 1
fi

case "${OSTYPE}" in
linux*) export SYSTEM=LINUX ;;
darwin*) export SYSTEM=OSX ;;
win*) export SYSTEM=Windows ;;
cygwin*) export SYSTEM=Cygwin ;;
msys*) export SYSTEM=MSYS ;;
bsd*) export SYSTEM=BSD ;;
solaris*) export SYSTEM=SOLARIS ;;
*) export SYSTEM=UNKNOWN ;;
esac
echo "SYSTEM : ${SYSTEM}"

if [ -f /etc/os-release ]; then
  # freedesktop.org and systemd
  # shellcheck source=/dev/null
  . /etc/os-release
  OS=${NAME}
  VER=${VERSION_ID}
elif type lsb_release >/dev/null 2>&1; then
  # linuxbase.org
  OS=$(lsb_release -si)
  VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
  # For some versions of Debian/Ubuntu without lsb_release command
  # shellcheck source=/dev/null
  . /etc/lsb-release
  OS=${DISTRIB_ID}
  VER=${DISTRIB_RELEASE}
elif [ -f /etc/debian_version ]; then
  # Older Debian/Ubuntu/etc.
  OS=Debian
  VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
  # Older SuSE/etc.
  OS=SuSE
  VER=$(cat /etc/SuSe-release)
elif type sw_vers >/dev/null 2>&1; then
  # macOS
  OS=$(sw_vers -productName)
  VER=$(sw_vers -productVersion)
elif [ -f /etc/redhat-release ]; then
  # Older Red Hat, CentOS, Docker etc.
  OS=$(uname -s) # Linux
  VER=$(uname -r)
else
  # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
  OS=$(uname -s)
  VER=$(uname -r)
fi
echo " OS : ${OS}"
# echo "VER : ${VER}"

# Numeric compare; versions are passed as arguments so "15.6.1" works too
function float_gt {
  perl -e 'print(($ARGV[0] > $ARGV[1]) ? 1 : 0)' "$1" "$2"
}

if [ "$(float_gt "${VER}" 20)" = 1 ]; then
  echo "  VER : ${VER} gt"
else
  echo "  VER : ${VER} lt"
fi

if type lsb_release >/dev/null 2>&1; then
  lsb_release -a 2>/dev/null
fi
