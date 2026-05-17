#!/system/bin/sh
MODPATH="${0%/*}"
. $MODPATH/common_func.sh

# This script runs during late-start service but before boot is complete.
# For the lite version, we mostly rely on service.sh for background tasks.
# We ensure permissions are correct.

chmod 755 "$MODPATH/update_all.sh"
chmod 755 "$MODPATH/service.sh"

# Minimal late prop fixes if needed
resetprop ro.boot.vbmeta.device_state locked
resetprop vendor.boot.vbmeta.device_state locked
