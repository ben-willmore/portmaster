# Fixes for Portmaster ports on Knulli

Some ports are broken on knulli due because the system files are different from other platforms. This repository contains fixes for some of these ports.


# Install

Place the relevant .zip file in `/userdata/system/.local/share/Portmaster/autoinstall` and launch Portmaster, which should then autoinstall the port. Then follow any instructions from [https://portmaster.games/games.html](https://portmaster.games/games.html) to install the game files.


# Other fixes

These may be applicable to other other ports.

## Missing libFLAC.so.8 or libcrypto.so.1.1

* Shadow Warrior

Messages about these missing libraries can be fixed as follows:

* Install the port as normal
* Copy the relevant library from [here](https://github.com/ben-willmore/portmaster/blob/main/libs) to `<portfolder>/libs/` or `<portfolder/libs.aarch64` if they exist. If they don't create a folder called `libs.aarch64` and put the file there.


## Problems with libEGL

A common problem seems to be that, when a port provides libGL.so.1, this is incompatible with the system's libEGL.so.1. This can be solved by adding [libEGL.so.1](https://github.com/ben-willmore/portmaster/blob/main/libs/libEGL.so.1) to the same folder as `libGL.so.`, and adding to the `.sh` file. Where you find:

`export SDL_VIDEO_GL_DRIVER="$GAMEDIR/gl4es.aarch64/libGL.so.1"`

Add:

`export SDL_VIDEO_EGL_DRIVER="$GAMEDIR/gl4es.aarch64/libEGL.so.1"`

Note that `gl4es.aarch64` may vary between ports, and your new line needs to match the existing one.
