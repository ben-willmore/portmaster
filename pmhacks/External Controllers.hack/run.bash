#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ ${PM_PORTNAME} == StardewValley ]]; then
  source "${SCRIPT_DIR}/run.sdv.bash"

else
  if [[ -f "${SCRIPT_DIR}/enabled" ]]; then
    echo External Controllers hack enabled

    . "${SCRIPT_DIR}/assign_controllers.bash"

    if [[ ${should_activate} == 'true' ]]; then
        echo Activating HackSDL
        export LD_PRELOAD="${SCRIPT_DIR}/lib/hacksdl.aarch64.so"
    fi

  else
    echo External Controllers hack disabled, doing nothing

  fi

fi
