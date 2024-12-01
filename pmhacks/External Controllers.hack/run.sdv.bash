#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
HACK_DIR="${SCRIPT_DIR}/sdv"
gamedir=/$directory/ports/stardewvalley

if [[ -f "${SCRIPT_DIR}/enabled" ]]; then
  echo External Controllers hack enabled

  . "${SCRIPT_DIR}/assign_controllers.bash"

  if [[ ${should_activate} == 'true' ]]; then
    echo Activating HackSDL for SDV

    #export HACKSDL_DEBUG="1"
    export HACKSDL_LIBSDL_NAME="libSDL2-2.0.so.0"

    # copy library to SDV directory
    if [[ ! -f "$gamedir/libs/hacksdl.aarch64.so" ]]; then
      cp "${SCRIPT_DIR}/sdv/hacksdl.aarch64.so" "$gamedir/libs/"
    fi

    # patch SDV files to enable library
    (cd $gamedir; \
     "${HACK_DIR}/patch.aarch64" -p0 -R -s -f --dry-run >/dev/null < "${HACK_DIR}/hacksdl.enable.patch" || "${HACK_DIR}/patch.aarch64" -b -p0 < "${HACK_DIR}/hacksdl.enable.patch";
    )
  fi

else
  echo External Controllers hack disabled

  echo Deactivating HackSDL for SDV

  # remove library from SDV directory
  if [[ -f "$gamedir/libs/hacksdl.aarch64.so" ]]; then
    rm "$gamedir/libs/hacksdl.aarch64.so"
  fi

  # unpatch SDV files to disable library
  (cd $gamedir; \
   "${HACK_DIR}/patch.aarch64" -p0 -s -f --dry-run >/dev/null < "${HACK_DIR}/hacksdl.enable.patch" || "${HACK_DIR}/patch.aarch64" -R -b -p0 < "${HACK_DIR}/hacksdl.enable.patch";
  )

fi
