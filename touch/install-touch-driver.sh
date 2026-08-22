#!/bin/bash
# Install MacXeneonEdgeTouchDriver from upstream, pinned commit.
# Idempotent: clones on first run, fetches + checks out on re-run.
set -euo pipefail

DRIVER_REPO="https://github.com/ajvwhite/MacXeneonEdgeTouchDriver.git"
DRIVER_COMMIT="13c0f34e982d9372f0aa7e3180e903b289324f7d"
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
  git checkout "$DRIVER_COMMIT"
  # Reset any previously applied patches, then re-apply Vardek patches on the
  # pinned commit — idempotent across re-runs. Patches live in the Vardek repo
  # (scripts/patches/) so re-installs never lose the display-retry fix.
  git checkout -- .
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

Next: System Settings - Privacy & Security - Accessibility
  Grant access to: MacXeneonEdgeTouchDriver
  (Full path: $DRIVER_BIN)
  Tip: the file picker hides ~/Library - press Cmd+Shift+G and
  paste the path above, or Cmd+Shift+. to show hidden folders.
  Accessibility is the only grant needed (macOS never prompts for
  Input Monitoring; the driver's HID access does not require it).
  After granting, restart the driver:
    launchctl kickstart -k "gui/\$(id -u)/com.ajvwhite.MacXeneonEdgeTouchDriver"

Calibration (optional; only if touches are off-target):
  cd "$DRIVER_ROOT"
  swift run DisplayInfo    # shows vendor/model info

  Edit: "$HOME/Library/Application Support/MacXeneonEdgeTouchDriver/config.json"
  Adjust vendor and model fields per DisplayInfo output.

Status: Open Admin (http://127.0.0.1:8137/admin) -> System
  "installed - running" once the Accessibility grant is complete.

===================================================================
CHECKLIST
