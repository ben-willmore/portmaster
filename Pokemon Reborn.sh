#!/bin/bash
XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

# PortMaster header
if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
elif [ -d "$XDG_DATA_HOME/PortMaster/" ]; then
  controlfolder="$XDG_DATA_HOME/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

# Source the controls and device info
source $controlfolder/control.txt

# Source custom mod files from the portmaster folder
[ -f "${controlfolder}/mod_${CFW_NAME}.txt" ] && source "${controlfolder}/mod_${CFW_NAME}.txt"
# Pull the controller configs for native controls
get_controls

# Directory setup
GAMEDIR=/$directory/ports/reborn
CONFDIR="$GAMEDIR/conf/"
mkdir -p "$GAMEDIR/conf"

# Enable logging
> "$GAMEDIR/log.txt" && exec > >(tee "$GAMEDIR/log.txt") 2>&1

# Exports
export LD_LIBRARY_PATH="$GAMEDIR/libs.${DEVICE_ARCH}:$LD_LIBRARY_PATH"
export SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig"
export TEXTINPUTINTERACTIVE="Y"
export XDG_DATA_HOME="$CONFDIR"
export LC_ALL=C
export LANG=C
cd $GAMEDIR

# Move the mkxp.json preset
mv preset/mkxp.json ./mkxp.json

# Gptk and run port
$GPTOKEYB "mkxp-z.${DEVICE_ARCH}" -c "./reborn.gptk" &
pm_platform_helper $GAMEDIR/mkxp-z.${DEVICE_ARCH}
./mkxp-z.${DEVICE_ARCH}

# Cleanup
pm_finish