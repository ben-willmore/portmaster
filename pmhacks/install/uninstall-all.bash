#!/bin/bash

PORTS_DIR=`realpath ${1}`

SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

IFS=$'\n'
for origfile in `find "${PORTS_DIR}" -name "*.sh.pmhacks.orig"`; do
  port=`basename $(echo "${origfile}" | cut -f 1 -d '.')`
  echo Port "${port}:"
  echo Original file `basename "${origfile}"` found, restoring it

  if [[ ! -z `diff "${PORTS_DIR}/${port}.sh" \
                   "${SCRIPT_DIR}/../PMHacks-Template.bash"` ]]; then
    echo Saving modified file as ${PORTS_DIR}/${port}.sh.pmhacks.bak
    mv "${PORTS_DIR}/${port}.sh" "${PORTS_DIR}/${port}.sh.pmhacks.bak"
  fi

  mv "${PORTS_DIR}/${port}.sh.pmhacks.orig" "${PORTS_DIR}/$port.sh"
  echo ${port} 1>&2
done
