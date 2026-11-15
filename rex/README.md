# Ardentia for Rex

<b>English</b> · <a href="README.pt-BR.md">Português</a>

Reference for the Rex port. For the overview, the palette and the principles, start at the [main README](../README.md). Rex imports themes in the Ghostty format, so `Ardentia` is the [Ghostty theme](../ghostty/README.md) with a different header comment. The colors are the same. Imported through the interface of Rex Beta 0.1.0.

## What is in this folder

| Path | What it is |
| --- | --- |
| `Ardentia` | The theme. A Ghostty-format file with only color keys |
| `install.sh` | Imports the theme into Rex through its CLI |

## Install with the script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/rex/install.sh
```

The script runs `rex do client.theme.import`. Rex keeps imported themes in its own preferences, not in a themes folder, so the script copies nothing. Importing twice can add the theme twice.

The CLI only works with Remote Control on (Settings, Rex Server). With it off, the script prints the path of the file and the manual steps. If more than one Rex app is connected, set `REX_CLIENT` to the label or ID shown by `rex client ls`:

```bash
REX_CLIENT="my-mac" ./ardentia/rex/install.sh
```

The script does not turn on Remote Control, does not switch the active theme and does not edit `init.lua`.

## Install by hand

In Rex, open Settings, Themes, Import Theme and choose the `Ardentia` file from this folder.

## Activate

In Settings, Themes, Dark Mode, select Ardentia. Or, with Remote Control on:

```bash
rex do client.theme.change name=Ardentia
```

To tint the interface with the theme colors, turn on Tint with Theme in Settings, Interface, Appearance (Bleeding Edge channel).

## Port notes

- The 16 colors and the other keys are the ones in the [Ghostty reference](../ghostty/README.md).
- `split-divider-color` and `unfocused-split-fill` are Ghostty keys. Rex probably ignores them, and this was not tested. The active pane highlight is a Rex setting (Settings, Interface, Active Pane).
- `scripts/check-themes.ts` checks this file with the same rules as the Ghostty one.
