#!/bin/bash
RED='\033[0;31m'
NC='\033[0m' # No Color
#For installing integrated service in all the devices at once

if [ $# -eq 1 ]
then
CM=$1
else
CM=`idevice_id -l`
fi

ARRAY=($CM)
for deviceid in "${ARRAY[@]}"
do
  echo -e "${RED} UDID  $deviceid${NC} "
  echo -e ${RED} OS Version : `ideviceinfo -u $deviceid -k ProductVersion` ${NC}

  echo "--------------------Done-----------------------------------"
done

