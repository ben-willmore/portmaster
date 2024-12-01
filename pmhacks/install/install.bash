#!/bin/bash

PORTS_DIR="${1}"
COMPAT_FILE="${2}"

SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

IFS=$'\n'
for port in `cat "${COMPAT_FILE}"`; do
  if [[ -f "${PORTS_DIR}/${port}.sh" ]]; then
    echo File found: "${PORTS_DIR}/$port.sh"

    if [[ ! -z `grep "PMHacks" "${PORTS_DIR}/$port.sh"` ]]; then
      echo PMHacks code found, doing nothing

    else
      echo PMHacks code not found, installing it
      rm -f "${PORTS_DIR}/$port.sh.orig"
      mv "${PORTS_DIR}/${port}.sh" "${PORTS_DIR}/${port}.sh.pmhacks.orig"
      cp "${SCRIPT_DIR}/../PMHacks-Template.bash" "${PORTS_DIR}/${port}.sh"
      echo ${port} 1>&2
    fi

  else
    echo File not found: "${PORTS_DIR}/${port}.sh" 
  fi

done
