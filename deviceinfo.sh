#!/bin/bash
echo "Read it from here"
date "Current Time in IST
TZ="Asia/Kolkata" date
echo "----------------------Network Details---------------------------------"
ifconfig | grep inet | grep -v inet6
echo "----------------------OS and Xcode Details---------------------------------"
echo " xcodebuild "xcodebuild -version
echo "Mac OS" sw_vers 
echo "CPU "sysctl -n machdep.cpu.brand_string
echo "CPU Count "sysctl -n hw.logicalcpu
RED='\033[0;31m'
NC='\033[0m' # No Color
#For installing integrated service in all the devices at once

echo "--------------------Connected Device Details-----------------------------------"
CM=`idevice_id -l`
ARRAY=($CM)
for deviceid in "${ARRAY[@]}"
do
  echo -e "${RED} UDID  $deviceid${NC} "
  echo -e ${RED} iOS Version : `ideviceinfo -u $deviceid -k ProductVersion` ${NC}
  echo -e ${RED} iOS SerialNumber : `ideviceinfo -u $deviceid -k SerialNumber` ${NC}
  echo -e ${RED} iOS ProductName : `ideviceinfo -u $deviceid -k ProductName` ${NC}
   echo -e ${RED} ProductType: `ideviceinfo -u $deviceid -k ProductType` ${NC}
  echo -e ${RED} iOS HardwareModel : `ideviceinfo -u $deviceid -k HardwareModel` ${NC}
  echo -e ${RED} Password: `ideviceinfo -u $deviceid -k PasswordProtected` ${NC}
  ps -aef | grep $deviceid
  echo "------------------------------------------------------------------------------"
done
echo "USB_TETHERING"
jq '.USB_TETHERING' /opt/build/private-rbox/settings.json 
echo "------------------------------Profile Details-----------------------------------"
PROFILE="/opt/build/WebDriverBuild13.4/Build/Products/Debug-iphoneos/WebDriverAgentRunner-Runner.app/embedded.mobileprovision"

# Extract the plist from the provisioning profile
security cms -D -i "$PROFILE" > profile.plist

# Extract the entitlements
echo "Extracting Entitlements..."
/usr/libexec/PlistBuddy -c "Print Entitlements" profile.plist > entitlements.plist
cat entitlements.plist

# Extract the ProvisionedDevices
echo "Extracting Provisioned Devices..."
/usr/libexec/PlistBuddy -c "Print ProvisionedDevices" profile.plist

# Extract the TeamName
echo "Extracting Team Name..."
/usr/libexec/PlistBuddy -c "Print TeamName" profile.plist

# Clean up
rm profile.plist
rm entitlements.plist
