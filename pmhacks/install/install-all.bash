#!/bin/bash

PORTS_DIR="${1}"

SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

for hack in "${SCRIPT_DIR}"/../*.hack; do
  echo Installing hack `basename "${hack}"`
  "${SCRIPT_DIR}/install.bash" "${PORTS_DIR}" "${hack}/compatible-ports.txt"
done
