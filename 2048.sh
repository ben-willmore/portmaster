#!/bin/bash
# PORTMASTER: 2048.zip, 2048.sh

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
source $controlfolder/device_info.txt

get_controls

GAMEDIR="/$directory/ports/2048"

if [[ $CFW_NAME == "TheRA" ]]; then
  raloc="/opt/retroarch/bin"
  raconf=""
elif [[ $CFW_NAME == "RetroOZ" ]]; then
  raloc="/opt/retroarch/bin"
  raconf="--config /home/odroid/.config/retroarch/retroarch.cfg"
elif [[ $CFW_NAME == "ArkOS" ]] || [[ $CFW_NAME == "ArkOS wuMMLe" ]]; then
  raloc="/usr/local/bin"
  raconf=""
elif [[ $CFW_NAME == "muOS" ]]; then
  raloc="/usr/bin"
  if [ -f /run/muos/storage/info/config/retroarch.cfg ]; then
    raconf="--config /run/muos/storage/info/config/retroarch.cfg"
  else
    raconf="--config /mnt/mmc/MUOS/retroarch/retroarch.cfg"
  fi
elif [[ $CFW_NAME == "knulli" ]]; then
  raloc="/usr/bin"
  cp $GAMEDIR/config/retroarchcustom-$CFW_NAME.cfg.clean \
     $GAMEDIR/config/retroarchcustom-$CFW_NAME.cfg
  raconf="--config $GAMEDIR/config/retroarchcustom-$CFW_NAME.cfg"
else
  raloc="/usr/bin"
  raconf=""
fi

$GPTOKEYB "retroarch" &
$raloc/retroarch $raconf -L $GAMEDIR/2048_libretro.so.${DEVICE_ARCH}
