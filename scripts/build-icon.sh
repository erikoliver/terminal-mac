#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
scratch="$(mktemp -d /tmp/terminal-mac-icon.XXXXXX)"
trap 'rm -rf "$scratch"' EXIT
iconset="$scratch/TerminalMac.iconset"
mkdir "$iconset"
for size in 16 32 128 256 512; do
  sips -z "$size" "$size" resources/TerminalMac.png --out "$iconset/icon_${size}x${size}.png" >/dev/null
  retina=$((size * 2))
  sips -z "$retina" "$retina" resources/TerminalMac.png --out "$iconset/icon_${size}x${size}@2x.png" >/dev/null
done
iconutil -c icns "$iconset" -o resources/TerminalMac.icns
echo 'Built: resources/TerminalMac.icns'
