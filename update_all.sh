#!/system/bin/sh
MODPATH="/data/adb/modules/playintegrityfix"

if [ -f "$MODPATH/common_func.sh" ]; then
    . "$MODPATH/common_func.sh"
else
    exit 1
fi

# Paths
A="/data/adb"
B="$A/tricky_store"
C="$A/Box-Brain/Integrity-Box-Logs"
LOG="$C/autopilot.log"
mkdir -p "$C"

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') | $*" | tee -a "$LOG"
}

# --- 1. Update Keybox ---
log "Starting Keybox update..."
E="$(mktemp -p /data/local/tmp)"
F="$B/keybox.xml"
H="$B/.k"
I="aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcm"
J="NvbnRlbnQuY29tL01lb3dEdW1wL01lb3dEdW1wL3JlZ"
K="nMvaGVhZHMvbWFpbi9OdWxsVm9pZC9"
LOL="TaG9ja1dhdmUudGFy"

# Decode URL
U=$(printf '%s%s%s%s' "$I" "$J" "$K" "$LOL" | tr -d '\n' | Z)

detect_downloader
if [ -z "$DOWNLOADER" ]; then
    log "No downloader available"
else
    if [ "$DL_MODE" = "curl" ]; then
        curl -fsSL --insecure "$U" -o "$E"
    else
        $DOWNLOADER wget -q --no-check-certificate -O "$E" "$U"
    fi

    if [ -s "$E" ]; then
        # Multi-stage decoding
        for i in $(seq 1 10); do
            T="$(mktemp -p /data/local/tmp)"
            base64 -d "$E" > "$T" 2>/dev/null
            rm -f "$E"
            E="$T"
        done
        # Hex & ROT13
        xxd -r -p "$E" > "$H" 2>/dev/null
        tr 'A-Za-z' 'N-ZA-Mn-za-m' < "$H" > "$F"
        rm -f "$E" "$H"
        chmod 600 "$F"
        log "Keybox updated."
    else
        log "Failed to download Keybox."
    fi
fi

# --- 2. Update Fingerprint ---
log "Starting Fingerprint update..."
FP_URL="https://raw.githubusercontent.com/MeowDump/Integrity-Box/refs/heads/main/fingerprint/custom.pif.prop"
FP_DEST="$MODPATH/custom.pif.prop"
E="$(mktemp -p /data/local/tmp)"

if [ "$DL_MODE" = "curl" ]; then
    curl -fsSL --insecure "$FP_URL" -o "$E"
else
    $DOWNLOADER wget -q --no-check-certificate -O "$E" "$FP_URL"
fi

if [ -s "$E" ]; then
    cp -f "$E" "$FP_DEST"
    chmod 644 "$FP_DEST"
    rm -f "$E"
    log "Fingerprint updated."
else
    log "Failed to download Fingerprint."
fi

# --- 3. Restart GMS ---
log "Restarting GMS processes..."
am force-stop com.google.android.gms.unstable 2>/dev/null
am force-stop com.google.android.gms 2>/dev/null
am force-stop com.android.vending 2>/dev/null
log "Update complete."
