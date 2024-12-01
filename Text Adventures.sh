#!/bin/bash
# PORTMASTER: textadventures.zip, Text Adventures.sh

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
get_controls

GAMEDIR="/$directory/ports/textadventures"
cd "$GAMEDIR/saves"

RES=`batocera-resolution currentResolution`
case ${RES} in
  640x480)
    fontsize=16
    consolewidth=640
    consoleheight=480
    ;;
  1280x720)
    fontsize=24
    consolewidth=1088
    consoleheight=672
    ;;
  *)
    fontsize=18
    consolewidth=-1
    consoleheight=-1
    ;;
esac

sed "s/%%FONTSIZE%%/${fontsize}/" ../sdlterm/sdlterm.cfg.template \
 | sed "s/%%CONSOLEWIDTH%%/${consolewidth}/" \
 | sed "s/%%CONSOLEHEIGHT%%/${consoleheight}/" \
 > ../sdlterm/sdlterm.cfg

$ESUDO chmod 666 /dev/uinput
$GPTOKEYB "sdlterm" -c ../sdlterm/sdlterm.gptk &

../sdlterm/sdlterm -c ../sdlterm/sdlterm.cfg 2>&1 | tee log.txt

$ESUDO kill -9 $(pidof gptokeyb)
$ESUDO systemctl restart oga_events &
