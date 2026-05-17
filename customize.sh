#!/system/bin/sh

# Minimal installation for Lite version
MODDIR="${0%/*}"

ui_print "========================================="
ui_print "      Integrity Box (Lite) Installer     "
ui_print "========================================="
ui_print " ✦ Only Auto-Update Keybox & Fingerprint "
ui_print " ✦ Removed UI and bloat                  "
ui_print " ✦ Fixed AVB detection issue             "
ui_print "========================================="

# Permissions
set_perm_recursive "$MODPATH" 0 0 0755 0644
chmod 755 "$MODPATH/update_all.sh"
chmod 755 "$MODPATH/service.sh"
chmod 755 "$MODPATH/post-fs-data.sh"

# Initial keybox setup
if [ -d "$MODPATH/keybox" ]; then
  mkdir -p /data/adb/tricky_store
  cp "$MODPATH/keybox/keybox3.xml" /data/adb/tricky_store/keybox.xml
  chmod 600 /data/adb/tricky_store/keybox.xml
fi

ui_print " ✦ Done. Update will run in background."
