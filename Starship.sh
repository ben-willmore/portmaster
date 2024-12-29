#!/bin/bash
# PORTMASTER: starship.zip, Starship.sh
# PORTMASTER:

XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
elif [ -d "$XDG_DATA_HOME/PortMaster/" ]; then
  controlfolder="$XDG_DATA_HOME/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

source $controlfolder/control.txt

[ -f "${controlfolder}/mod_${CFW_NAME}.txt" ] && source "${controlfolder}/mod_${CFW_NAME}.txt"

get_controls

GAMEDIR=/$directory/ports/starship
CONFDIR="$GAMEDIR/conf/"

mkdir -p "$GAMEDIR/conf/data"

cd $GAMEDIR

> "$GAMEDIR/log.txt" && exec > >(tee "$GAMEDIR/log.txt") 2>&1

# Exports
export PATCHER_FILE="$GAMEDIR/tools/patchscript"
export PATCHER_GAME="$(basename "${0%.*}")" # This gets the current script filename without the extension
export PATCHER_TIME="5 minutes"

# Extract assets
if [[ ! -f $GAMEDIR/sf64.otr ]]; then
  find "$GAMEDIR/gamedata" -type f | while read file
  do
    checksum=$(md5sum "$file" | awk '{print $1}')
    if [[ "$checksum" == 741a94eee093c4c8684e66b89f8685e8 ]]; then
      if [ -f "$controlfolder/utils/patcher.txt" ]; then
        cp $file $GAMEDIR/baserom.us.rev1.z64
        source "$controlfolder/utils/patcher.txt"
        $ESUDO kill -9 $(pidof gptokeyb)
        rm $file $GAMEDIR/baserom.us.rev1.z64
      else
        echo "This port requires the latest version of PortMaster." > $CUR_TTY
      fi
      break
    fi
  done
else
  echo Got sf64.otr assets file, not re-extracting
fi

export SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig"

if [ -f "${controlfolder}/libgl_${CFW_NAME}.txt" ]; then 
  source "${controlfolder}/libgl_${CFW_NAME}.txt"
else
  source "${controlfolder}/libgl_default.txt"
fi

$GPTOKEYB "Starship" &

echo Running Starship
pm_platform_helper "$GAMEDIR/Starship"

./Starship

pm_finish
