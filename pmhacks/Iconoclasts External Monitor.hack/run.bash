#!/bin/bash

echo Moving aside settings file
settings_file="/$directory/ports/iconoclasts/gamedata/data"

if [ -f "${settings_file}" ]; then
  mv "${settings_file}" "${settings_file}.disabled"
fi
