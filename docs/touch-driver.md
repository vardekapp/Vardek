# Touch Setup

The Xeneon Edge™ touchscreen needs a small community driver on macOS — the
panel is otherwise display-only. This is a one-time setup.

## Install the driver

Touch input uses the open-source **[MacXeneonEdgeTouchDriver](https://github.com/ajvwhite/MacXeneonEdgeTouchDriver)**
with a small reliability patch (it fixes touches being dropped after sleep/wake
or replugging the panel). This repo ships an install script under [`touch/`](../touch)
that pins a known-good driver commit, applies the patch, builds it, and runs the
upstream installer.

Requires the Xcode command-line tools (`xcode-select --install`).

Clone or download this repo, then run:

```sh
./touch/install-touch-driver.sh
```

The script is idempotent — re-run it any time (e.g. after an update) to rebuild
the driver on the pinned commit.

## Accessibility permission

macOS requires an explicit grant before any software can synthesize clicks:

**System Settings → Privacy & Security → Accessibility** → enable
**MacXeneonEdgeTouchDriver**. The install script prints the exact binary path;
in the file picker press ⌘⇧G and paste it.

Then restart the driver:

```sh
launchctl kickstart -k "gui/$(id -u)/com.ajvwhite.MacXeneonEdgeTouchDriver"
```

Vardek's **Settings → System** shows whether the driver is detected and running.

## Notes

- Touch works everywhere on the panel, not just in Vardek — but Vardek's widgets
  (Macro Pad buttons, page dots) are designed for it.
- Re-running the install rebuilds the driver, which **invalidates the
  Accessibility grant** — re-enable it in System Settings afterwards.
- Touches off-target? The driver supports calibration; see its
  [README](https://github.com/ajvwhite/MacXeneonEdgeTouchDriver).
- Since 1.0.3: swipe left/right anywhere to change carousel pages, drag
  up/down to scroll a widget's content that overflows the panel (e.g. a full
  Calendar month grid).
