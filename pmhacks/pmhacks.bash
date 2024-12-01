#!/bin/bash

PORTS_DIR=/${directory}/ports
SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

for hack in $SCRIPT_DIR/*.hack; do
  if [[ ! -z `grep -x "${PM_PORTNAME}" "${hack}/compatible-ports.txt"` ]]; then
    echo $hack is compatible with ${PM_PORTNAME}
    . "${hack}/run.bash"

  else
    echo $hack is not compatible with ${PM_PORTNAME}

  fi

done
