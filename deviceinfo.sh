#!/bin/bash
RED='\033[0;31m'
NC='\033[0m' # No Color
#For installing integrated service in all the devices at once
xcodebuild -version
sw_vers 
CM=`idevice_id -l`
ARRAY=($CM)
for deviceid in "${ARRAY[@]}"
do
  echo -e "${RED} UDID  $deviceid${NC} "
  echo -e ${RED} OS Version : `ideviceinfo -u $deviceid -k ProductVersion` ${NC}

  echo "--------------------Done-----------------------------------"
done

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
