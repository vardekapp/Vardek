# Touch Setup

The Xeneon Edge™ touchscreen needs a small community driver on macOS — the
panel is otherwise display-only. This is a one-time setup.

## Install the driver

Touch input uses the open-source **[MacXeneonEdgeTouchDriver](https://github.com/ajvwhite/MacXeneonEdgeTouchDriver)**,
unmodified. This repo ships an install script under [`touch/`](../touch) that
pins a reviewed driver commit, builds it, and runs the upstream installer.

Requires the Xcode command-line tools (`xcode-select --install`).

Clone or download this repo, then run:

```sh
./touch/install-touch-driver.sh
```

The script is idempotent — re-run it any time (e.g. after an update) to rebuild
the driver on the pinned commit.

## Permissions

macOS requires two explicit grants before the driver can read the panel and
synthesize clicks. Enable **MacXeneonEdgeTouchDriver** in both:

- **System Settings → Privacy & Security → Accessibility** (called **Device
  Control and Data Access** on macOS 26) — lets the driver click.
- **System Settings → Privacy & Security → Input Monitoring** — lets the driver
  read the touch panel.

The install script prints the exact binary path; in the file picker press ⌘⇧G
and paste it. Until both are granted the driver keeps running and waits — touch
starts once you approve. If it doesn't pick the grants up, restart it:

```sh
launchctl kickstart -k "gui/$(id -u)/com.ajvwhite.MacXeneonEdgeTouchDriver"
```

To check the grants without side effects (exit status 0 means both are granted):

```sh
"$HOME/Library/Application Support/MacXeneonEdgeTouchDriver/bin/MacXeneonEdgeTouchDriver" --check-permissions
```

Vardek's **Settings → System** shows whether the driver is detected and running.

## Notes

- Touch works everywhere on the panel, not just in Vardek — but Vardek's widgets
  (Macro Pad buttons, page dots) are designed for it.
- **Single touch only.** The Edge™ panel is a 5-point touchscreen, but this
  driver handles one finger at a time. Pinch, two-finger scroll and other
  multi-touch gestures are not available.
- Re-running the install rebuilds the driver, which can **invalidate the
  grants** — re-enable them in System Settings afterwards. To keep them, install
  with a code-signing identity: `CODESIGN_IDENTITY="<identity>" ./touch/install-touch-driver.sh`.
- Driver behaviour: the first tap on an inactive window activates it before
  clicking (if the window can't be confirmed, the touch is dropped), two quick
  nearby taps act as a double-click, and typing focus returns to where it was
  after a touch. These come from the upstream driver; its
  [README](https://github.com/ajvwhite/MacXeneonEdgeTouchDriver) lists the options.
- Touches off-target? The driver supports calibration; see its README.
- Since 1.0.3: swipe left/right anywhere to change carousel pages, drag
  up/down to scroll a widget's content that overflows the panel (e.g. a full
  Calendar month grid).
