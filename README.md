# Vardek

A local, Mac-native widget dashboard for the **Corsair Xeneon Edge™** touchscreen
(the 2560×720 USB-C secondary panel).

**Website:** [vardek.app](https://vardek.app) · **Download:** [latest release](https://github.com/vardekapp/Vardek/releases/latest)

![Vardek dashboard — macro buttons, system sensors, and clock on the Xeneon Edge](assets/screenshots/dashboard.png)

## What it is

The Xeneon Edge™ ships with a widget dashboard that only runs inside Corsair iCUE
on Windows. On macOS the panel is just a second display. Vardek rebuilds that
layer natively for the Mac: a full-screen, touch-driven grid of widgets that
fills the strip and runs entirely on your machine — no cloud, no account, no
telemetry.

## Requirements

- macOS 13 (Ventura) or later
- Apple Silicon Mac (CPU/GPU temperature sensors are Apple Silicon-only)
- A Corsair Xeneon Edge™ over USB-C (optional — Vardek also runs on any display
  so you can try it)

## Install

1. Download `Vardek-<version>.dmg` from the [latest release](https://github.com/vardekapp/Vardek/releases/latest).
2. Open it and drag **Vardek** to **Applications**.
3. Launch Vardek. The app is signed and notarized by Apple.

Verify the download against `SHA256SUMS` if you like:

```
shasum -a 256 -c SHA256SUMS
```

## Documentation

- [Setup](docs/setup.md) — install and first launch.
- [Touch setup](docs/touch-driver.md) — enable the touchscreen (community driver).
- [Troubleshooting](docs/troubleshooting.md) — common fixes.

## Widgets

Eight widgets ship bundled: Clock, Calendar, System Sensors, Sensor Gauge,
Macro Pad, F1 Schedule, UniFi Network, and Weather. Drop your own into
`~/Library/Application Support/Vardek/widgets/` and rescan.

**Add-on widgets:** install more after the fact — no app update — from
**[vardekapp/vardek-widgets](https://github.com/vardekapp/vardek-widgets)**.
That repo is open source; grab a widget, drop it in the folder above, rescan.
Authoring guide and PRs welcome there too.

| | |
|---|---|
| ![Weather](assets/screenshots/weather.png) | ![Calendar](assets/screenshots/calendar.png) |
| **Weather** — current conditions, hourly, 5-day | **Calendar** — three-month grid |
| ![F1 Schedule](assets/screenshots/f1.png) | ![UniFi Network](assets/screenshots/unifi.png) |
| **F1 Schedule** — next race, driver & constructor standings | **UniFi Network** — device and client status |

## Admin

Manage everything from a browser Admin page (`http://127.0.0.1:8137/admin`) — no config
files to hand-edit. Live status, widget library and placement, per-widget settings,
layout profiles, background, brightness, and sensor picks.

| | |
|---|---|
| ![Admin — Status](assets/screenshots/admin-status.png) | ![Admin — Widgets](assets/screenshots/admin-widgets.png) |
| **Status** — daemon, panel, and connection state at a glance | **Widgets** — the library, placement on the grid, and per-widget settings |
| ![Admin — System](assets/screenshots/admin-system.png) | |
| **System** — sensors, background, brightness, and profiles | |

## Privacy

Local-only by design. All components run on your Mac over `127.0.0.1`; nothing
listens on your network. The only traffic that leaves your Mac is the specific
API call a widget you enable makes (e.g. Weather fetching a forecast), limited
to the exact hosts that widget declares. Full details at
[vardek.app](https://vardek.app).

## License

Vardek is proprietary and **not open source**. Binary builds are free to use
under the End User License Agreement bundled with the app. See [`LICENSE`](LICENSE)
and [`THIRD-PARTY-NOTICES.md`](THIRD-PARTY-NOTICES.md).

"Corsair" and "Xeneon" are trademarks of their respective owner; Vardek
references them only for hardware compatibility and is not affiliated with or
endorsed by Corsair.
