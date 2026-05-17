#!/system/bin/sh
MODPATH="${0%/*}"
. $MODPATH/common_func.sh

LOG_DIR="/data/adb/Box-Brain/Integrity-Box-Logs"
mkdir -p "$LOG_DIR"
LOG="$LOG_DIR/service.log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $*" | tee -a "$LOG"
}

log "Lite service started."

# Background update loop
(
    while true; do
        # Wait for network (up to 30 mins)
        wait_for_network 1800
        
        log "Running scheduled update..."
        sh "$MODPATH/update_all.sh"
        
        # Sleep for 24 hours
        sleep 86400
    done
) &

# --- Basic Prop Spoofing (Minimal) ---
# Fixing common detection points without over-spoofing
# We specifically avoid ro.boot.vbmeta.avb_version=2.0 to prevent detection on new devices

resetprop ro.boot.vbmeta.device_state locked
resetprop vendor.boot.vbmeta.device_state locked
resetprop ro.boot.verifiedbootstate green
resetprop vendor.boot.verifiedbootstate green
resetprop ro.boot.flash.locked 1
resetprop ro.secure 1
resetprop ro.build.type user
resetprop ro.build.tags release-keys

log "Basic props applied."
