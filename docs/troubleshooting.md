# Troubleshooting

## Dashboard shows "waiting for daemon…"

The background service didn't start or is still starting. It usually resolves in
a couple of seconds. If it persists:

- Check the log: `~/Library/Logs/Vardek/daemon.log`.
- Another process may hold port **8137**. Quit Vardek, check with
  `lsof -i :8137`, then relaunch.

## Panel opens on the wrong display

Vardek picks the display running exactly 2560×720. If the Edge is set to a
different resolution, restore it in System Settings → Displays. You can also pin
a display in Settings → System.

## A widget shows no data

- Live-data widgets reach the internet only for their declared hosts — check
  your network.
- Key-based widgets (add-on widgets like UniFi Network need one; none of the
  bundled widgets do) need their API key entered in the widget's settings — a
  missing key shows an auth prompt in the widget.

## Touch stopped working

Usually the Accessibility grant was lost (driver update) or the sleep/wake race
— see [Touch setup](touch-driver.md). Unplugging and replugging the panel's
USB-C also helps.

## No CPU/GPU temperatures

Temperatures come from Apple Silicon sensors. On Intel Macs the load/memory/
network readings work but temperature tiles stay empty.

## Launched app is hidden behind the panel

macOS reopens apps at their last window position. Exit fullscreen (green
button), drag the app's window to your main display, re-enter fullscreen — the
position sticks.

## Start fresh

Quit Vardek and delete `~/Library/Application Support/Vardek/` (your layout,
wallpaper and installed widgets — Keychain keys are kept). Relaunch for a clean
default.
