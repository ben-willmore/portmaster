#!/bin/bash

if [[ "${PM_PORTNAME}" == "Grand Theft Auto 3" ]]; then
  ini_file=/$directory/ports/gta3/re3.ini

elif [[ "${PM_PORTNAME}" == "Grand Theft Auto Vice City" ]]; then
  ini_file=/$directory/ports/gtavc/reVC.ini

fi

echo Modifying GTA ini file
cp "${ini_file}" "${ini_file}.bak"
grep -v Width "${ini_file}.bak" | grep -v Height > "${ini_file}"
