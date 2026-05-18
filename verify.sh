#!/system/bin/sh

# Get the directory where this script is located
MODDIR="${0%/*}"
HASHFILE="$MODDIR/hash"

# Check if hash file exists
if [ ! -f "$HASHFILE" ]; then
    echo " ✦ Integrity hash file not found at: $HASHFILE"
    exit 1
fi

while IFS='|' read -r RELPATH EXPECT_SHA256; do
    # Skip empty lines
    [ -z "$RELPATH" ] && continue
    
    FILE="$MODDIR/$RELPATH"
    
    # Check if file exists
    if [ ! -f "$FILE" ]; then
        echo " ✦ File $RELPATH missing!"
        exit 1
    fi

    # Compute actual SHA256
    ACTUAL_SHA256=$(sha256sum "$FILE" | awk '{print $1}')

    # Compare
    if [ "$ACTUAL_SHA256" != "$EXPECT_SHA256" ]; then
        echo " ✦ Integrity mismatch: $RELPATH"
        exit 1
    fi
done < "$HASHFILE"

echo " ✦ Integrity verified successfully."
exit 0
