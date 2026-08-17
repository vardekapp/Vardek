# Setup

## Requirements

- macOS 13 (Ventura) or later
- Apple Silicon Mac (CPU/GPU temperature sensors are Apple Silicon-only)
- A Corsair Xeneon Edge™ connected via USB-C (recommended; Vardek also runs on
  any display so you can try it)

## Install

1. Download `Vardek-<version>.dmg` from the [latest release](https://github.com/vardekapp/Vardek/releases/latest).
2. Open it and drag **Vardek** to **Applications**.
3. Launch Vardek. The app is signed and notarized by Apple — macOS may show a
   one-time confirmation on first open.

## First launch

- Vardek detects the Xeneon Edge™ automatically (it looks for a display running
  exactly 2560×720) and opens the dashboard fullscreen on it. No Edge connected?
  It uses your main display so you can explore.
- A fresh install starts with the System Sensors widget. Open **Settings**
  (Vardek menu → Settings…, or ⌘,) to add and arrange more widgets.

**No Xeneon Edge?** The widget grid is tuned for the Edge's 2560×720 shape, so
running fullscreen on a normal 16:9/16:10 Mac display stretches it. Exit
fullscreen (green traffic-light button, see below) and resize the window to
something close to that aspect ratio instead — see
[vardek.app/mac-setup](https://vardek.app/mac-setup/) for recommended sizes per
display (e.g. ~1600×450 on a 1080p/1440p external monitor, ~1280×360 on a
13"–14" MacBook).

## The window

The dashboard is a normal Mac window in native fullscreen:

- The green traffic-light button (or moving the cursor to the top of the panel)
  exits fullscreen to a movable, resizable window — and re-enters it.
- **⌘R** reloads the dashboard; **⌘W** closes a window; closing the dashboard
  window quits Vardek.
- **⌘?** opens the in-app Help.

## Launch at Login

Vardek menu → **Launch at Login** puts the dashboard up automatically after
every restart.

## Next

- [Touch setup](touch-driver.md) — enable the touchscreen.
- [Troubleshooting](troubleshooting.md) — if something looks wrong.
