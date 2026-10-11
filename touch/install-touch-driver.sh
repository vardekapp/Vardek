#!/bin/bash
# Install MacXeneonEdgeTouchDriver from upstream, pinned commit.
# Idempotent: clones on first run, fetches + checks out on re-run.
set -euo pipefail

DRIVER_REPO="https://github.com/ajvwhite/MacXeneonEdgeTouchDriver.git"
DRIVER_COMMIT="52dac0e2227802597ea422a384204a246312bbb6"
DRIVER_ROOT="$HOME/Library/Application Support/Vardek/touch-driver"
DRIVER_BIN="$HOME/Library/Application Support/MacXeneonEdgeTouchDriver/bin/MacXeneonEdgeTouchDriver"
PATCH_DIR="$(cd "$(dirname "$0")" && pwd)/patches"

# Clone or fetch + checkout pinned commit.
if [[ ! -d "$DRIVER_ROOT" ]]; then
  echo "Cloning MacXeneonEdgeTouchDriver..."
  git clone "$DRIVER_REPO" "$DRIVER_ROOT"
fi

(
  cd "$DRIVER_ROOT"
  # Only hit the network if the pinned commit isn't already local (re-runs at the
  # same pin skip the fetch entirely).
  git cat-file -e "$DRIVER_COMMIT^{commit}" 2>/dev/null || git fetch origin
  git checkout --detach "$DRIVER_COMMIT"
  # Reset any previously applied patches and stray files (including ignored
  # build output), then re-apply any Vardek patches on the pinned commit —
  # idempotent across re-runs. Patches live in the Vardek repo
  # (scripts/patches/). None are carried at this pin: upstream now re-resolves
  # the display on touch-down and HID match, which covered the old retry patch.
  git reset --hard "$DRIVER_COMMIT"
  git clean -fdx
  # Refuse to build anything but the audited commit.
  [[ "$(git rev-parse HEAD)" == "$DRIVER_COMMIT" ]] || { echo "error: touch driver is not at the pinned commit" >&2; exit 1; }
  for patch in "$PATCH_DIR"/*.patch; do
    [[ -e "$patch" ]] || continue
    echo "Applying $(basename "$patch")..."
    git apply "$patch"
  done
)

# Run upstream installer.
echo "Running upstream installer..."
(cd "$DRIVER_ROOT" && ./Scripts/install.sh)

# TCC + calibration checklist.
cat <<CHECKLIST

===================================================================
  Touch Driver Installation Complete
===================================================================

Next: System Settings - Privacy & Security, enable the driver under BOTH:
  - Accessibility (called "Device Control and Data Access" on macOS 26)
  - Input Monitoring
  Grant access to: MacXeneonEdgeTouchDriver
  (Full path: $DRIVER_BIN)
  Tip: the file picker hides ~/Library - press Cmd+Shift+G and
  paste the path above, or Cmd+Shift+. to show hidden folders.
  The driver keeps running and waits; touch starts once both are granted.
  Check without side effects (exit 0 = both granted):
    "$DRIVER_BIN" --check-permissions
  If it does not pick up the grants, restart it:
    launchctl kickstart -k "gui/\$(id -u)/com.ajvwhite.MacXeneonEdgeTouchDriver"

Keep grants across re-installs: CODESIGN_IDENTITY="<identity>" make install-touch

Calibration (optional; only if touches are off-target):
  cd "$DRIVER_ROOT"
  swift run DisplayInfo    # shows vendor/model info

  Edit: "$HOME/Library/Application Support/MacXeneonEdgeTouchDriver/config.json"
  Adjust vendor and model fields per DisplayInfo output.

Status: Vardek -> Settings -> System
  "installed - running" once the Accessibility grant is complete.

===================================================================
CHECKLIST
