#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

CUSTOM_ID="${CUSTOM_ID:-Custom-Minecraft-1.21.4-Fabric}"
FCL_ROOT="${FCL_ROOT:-/storage/emulated/0/FCL/.minecraft}"
VERSIONS_DIR="$FCL_ROOT/versions"
SOURCE_VERSION="${SOURCE_VERSION:-1.21.4-Fabric}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RUNTIME_JAR="$SCRIPT_DIR/custom-minecraft-runtime.jar"

echo "=== Custom Minecraft 1.21.4 Fabric installer ==="
echo

if [ ! -d "$VERSIONS_DIR" ]; then
    echo "ERROR: FCL versions directory not found:"
    echo "$VERSIONS_DIR"
    echo
    echo "If FCL is installed elsewhere, run:"
    echo 'FCL_ROOT="/path/to/.minecraft" bash install-fcl.sh'
    exit 1
fi

SOURCE_DIR="$VERSIONS_DIR/$SOURCE_VERSION"

if [ ! -d "$SOURCE_DIR" ]; then
    AUTO_SOURCE="$(find "$VERSIONS_DIR" -mindepth 1 -maxdepth 1 -type d \( -iname '*1.21.4*fabric*' -o -iname '*fabric*1.21.4*' \) | head -n 1 || true)"
    if [ -n "$AUTO_SOURCE" ]; then
        SOURCE_DIR="$AUTO_SOURCE"
        SOURCE_VERSION="$(basename "$AUTO_SOURCE")"
        echo "Fabric 1.21.4 profile found automatically:"
        echo "$SOURCE_DIR"
    else
        echo "ERROR: Installed Fabric 1.21.4 profile not found."
        echo
        echo "Checked:"
        echo "$VERSIONS_DIR/$SOURCE_VERSION"
        echo
        echo "Install Fabric 1.21.4 in FCL first, or pass its folder name:"
        echo 'SOURCE_VERSION="your-fabric-folder" bash install-fcl.sh'
        exit 2
    fi
fi

if [ ! -f "$RUNTIME_JAR" ]; then
    echo "ERROR: custom-minecraft-runtime.jar is missing next to install-fcl.sh"
    exit 3
fi

TARGET_DIR="$VERSIONS_DIR/$CUSTOM_ID"
TMP_DIR="$VERSIONS_DIR/.${CUSTOM_ID}.installing"
BACKUP_DIR=""

if [ -e "$TMP_DIR" ]; then
    rm -rf "$TMP_DIR"
fi

if [ -e "$TARGET_DIR" ]; then
    BACKUP_DIR="$VERSIONS_DIR/${CUSTOM_ID}.backup-$(date +%Y%m%d-%H%M%S)"
    echo "Existing custom version found."
    echo "Backup:"
    echo "$BACKUP_DIR"
    mv "$TARGET_DIR" "$BACKUP_DIR"
fi

echo
echo "[1/4] Cloning your installed Fabric profile locally..."
cp -a "$SOURCE_DIR" "$TMP_DIR"

echo "[2/4] Preparing separate version identity..."
SOURCE_JSON="$(find "$TMP_DIR" -maxdepth 1 -type f -name '*.json' | head -n 1 || true)"
if [ -n "$SOURCE_JSON" ]; then
    TARGET_JSON="$TMP_DIR/$CUSTOM_ID.json"
    if [ "$SOURCE_JSON" != "$TARGET_JSON" ]; then
        mv "$SOURCE_JSON" "$TARGET_JSON"
    fi

    sed -i -E '0,/"id"[[:space:]]*:[[:space:]]*"[^"]*"/s//"id": "'"$CUSTOM_ID"'"/' "$TARGET_JSON" || true
fi

SOURCE_JAR="$TMP_DIR/$SOURCE_VERSION.jar"
if [ -f "$SOURCE_JAR" ]; then
    cp -f "$SOURCE_JAR" "$TMP_DIR/$CUSTOM_ID.jar"
fi

echo "[3/4] Installing custom runtime layer..."
mkdir -p "$TMP_DIR/mods"
find "$TMP_DIR/mods" -maxdepth 1 -type f -name 'custom-minecraft-runtime*.jar' -delete || true
cp -f "$RUNTIME_JAR" "$TMP_DIR/mods/custom-minecraft-runtime.jar"

cat > "$TMP_DIR/CUSTOM-MINECRAFT-INFO.txt" <<EOF
Custom version: $CUSTOM_ID
Based locally on installed profile: $SOURCE_VERSION
Minecraft: 1.21.4
Runtime: custom-minecraft-runtime.jar

The repository/build bundle does not contain Mojang/Microsoft game code.
This version was assembled locally from your already installed Fabric profile.
EOF

echo "[4/4] Activating custom version..."
mv "$TMP_DIR" "$TARGET_DIR"

echo
echo "DONE"
echo
echo "Custom version:"
echo "$TARGET_DIR"
echo
echo "Runtime:"
echo "$TARGET_DIR/mods/custom-minecraft-runtime.jar"
echo
if [ -n "$BACKUP_DIR" ]; then
    echo "Previous version backup:"
    echo "$BACKUP_DIR"
    echo
fi
echo "Restart FCL, refresh the version list, and select:"
echo "$CUSTOM_ID"
