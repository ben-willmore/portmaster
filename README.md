# Fixes for Portmaster ports on Knulli

A few ports are broken on knulli due because the system files are different from other platforms. This repository contains fixes for some of these ports.


# Install

Place the relevant .zip file in `/userdata/system/.local/share/Portmaster/autoinstall` and launch Portmaster, which should then autoinstall the port. Then follow any instructions from [https://portmaster.games/games.html](https://portmaster.games/games.html) to install the game files.


# Other fixes

These may be applicable to other other ports.

## Missing libFLAC.so.8 or libcrypto.so.1.1

Messages about these missing libraries can be fixed as follows:

* Install the port as normal
* Copy the relevant library from [here](https://github.com/ben-willmore/portmaster/blob/main/libs) to `<portfolder>/libs/` or `<portfolder/libs.aarch64` if they exist. If they don't, create a folder called `libs.aarch64` and put the file there.

**OR**

* Copy the relevant library from [here](https://github.com/ben-willmore/portmaster/blob/main/libs) to `<portfolder>/libs/` to `/usr/lib/`. Then run `batocera-save-overlay` to make the addition permanent. This should fix all ports with this problem, by making the library available to all programs.

### libFLAC.so.8:
* Exhumed
* NAM
* World War II GI

### libcrypto.1.1:
* Hurrican
* Moonlight

## Problems with libEGL

A common problem seems to be that, when a port provides libGL.so.1, this is incompatible with the system's libEGL.so.1. This can be solved by adding libEGL.so.1 to the same folder as `libGL.so.1`, and adding to the `.sh` file. Where you find:

`export SDL_VIDEO_GL_DRIVER="$GAMEDIR/gl4es.aarch64/libGL.so.1"`

Add:

`export SDL_VIDEO_EGL_DRIVER="$GAMEDIR/gl4es.aarch64/libEGL.so.1"`

Note that `gl4es.aarch64` may vary between ports, and your new line needs to match the existing one.

If the above doesn't work you may also need to put a new libGL.so.1 in the same folder as libEGL.so.1.

This is likely to be needed for the following:

### 64-bit:
* Billy Frontier

### 64-bit (put library in rlvm/lib and edit .sh):
* Air
* Clannad
* Kanon
* Little Busters!
* Planetarian

64-bit libraries are [here](https://github.com/ben-willmore/portmaster/blob/main/gl4es.aarch64)

### 32 bit:
* Bit Trip Runner 2
* Super Meat Boy
* Guacamelee
* Serious Sam - The First Encounter
* Serious Sam - The Second Encounter
* Waking Mars

32-bit-bit libraries are [here](https://github.com/ben-willmore/portmaster/blob/main/gl4es-armhf)
