# Fixes for Portmaster ports on Knulli

Some ports are broken on knulli due because the system files are different from other platforms. This repository contains fixes for some of these ports.


# Install

Place the relevant .zip file in `/userdata/system/.local/share/Portmaster/autoinstall` and launch Portmaster, which should then autoinstall the port. Then follow any instructions from [https://portmaster.games/games.html](https://portmaster.games/games.html) to install the game files.


# Other fixes

These may be applicable to other other ports.

## Missing libFLAC.so.8

* Shadow Warrior
* UFO 50

These are missing [libFLAC.so.8](https://github.com/ben-willmore/portmaster/blob/main/daikatana/libs.aarch64/libFLAC.so.8). Install the port as normal, then copy libFLAC.so.8 to `<portfolder>/libs/libFLAC.so.8`. Other ports with the same problem may be fixed the same way, although the library folder may be called `libs.aarch64`, or you may need to create one called `libs.aarch64`.

## Problems with libEGL

A common problem seems to be that, when a port provides libGL.so.1, this is incompatible with the system's libEGL.so.1. This can be solved by adding [libEGL.so.1](https://github.com/ben-willmore/portmaster/blob/main/daikatana/gl4es.aarch64/libEGL.so.1) to the same folder as `libGL.so.`, and adding to the `.sh` file. Where you find:

`export SDL_VIDEO_GL_DRIVER="$GAMEDIR/gl4es.aarch64/libGL.so.1"`

Add:

`export SDL_VIDEO_EGL_DRIVER="$GAMEDIR/gl4es.aarch64/libEGL.so.1"`

Note that `gl4es.aarch64` may vary between ports, and your new line needs to match the existing one.