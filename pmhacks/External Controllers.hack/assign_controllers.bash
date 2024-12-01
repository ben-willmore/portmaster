#!/bin/bash

N_DEVICES=`ls /dev/input/event* | wc -l`
echo $N_DEVICES input devices found
  
case $N_DEVICES in
  [123]*)
    echo No external controllers connected, doing nothing
    should_activate=false
    ;;
  4)
    echo One external controller connected
    echo Assigning player 1 to external controller
    echo and player 2 to internal controller
    export HACKSDL_MAP_INDEX_0=1
    export HACKSDL_MAP_INDEX_1=0
    should_activate=true
    ;;
  5)
    echo Two external controllers connected
    echo Assigning players 1 and 2 to external controllers
    echo and player 3 to internal controller
    export HACKSDL_MAP_INDEX_0=1
    export HACKSDL_MAP_INDEX_1=2
    export HACKSDL_MAP_INDEX_2=0    
    should_activate=true
    ;;
  6)
    echo Three external controllers connected
    echo Assigning players 1-3 to external controllers
    echo and player 4 to internal controller
    export HACKSDL_MAP_INDEX_0=1
    export HACKSDL_MAP_INDEX_1=2
    export HACKSDL_MAP_INDEX_2=3
    export HACKSDL_MAP_INDEX_3=0
    should_activate=true
    ;;
  7)
    echo Four external controllers connected
    echo Assigning players 1-4 to external controllers
    export HACKSDL_MAP_INDEX_0=1
    export HACKSDL_MAP_INDEX_1=2
    export HACKSDL_MAP_INDEX_2=3
    export HACKSDL_MAP_INDEX_3=4
    should_activate=true
    ;;
esac
