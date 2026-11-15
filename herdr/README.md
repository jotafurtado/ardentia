# Ardentia for herdr

<b>English</b> · <a href="README.pt-BR.md">Português</a>

Reference for the herdr port. For the overview, the palette and the principles, start at the [main README](../README.md). The app theme was written against the Herdr app repository at commit `d0c8daf` (version 0.1.15). The terminal block was written against herdr 0.9.5 and passes `herdr config check`. Neither was reviewed in an open window.

## Two products, two files

Two products answer to the name herdr, and each one takes a different file.

- **The Herdr desktop app** reads themes from `themes/<name>.json` in its configuration folder. It uses `ardentia.json`.
- **The terminal herdr** (the `herdr` binary) has no theme files. It takes a `[theme]` table in its `config.toml`, with a `[theme.custom]` table that overrides 19 color tokens on top of a built-in theme. It uses `ardentia.toml`.

## What is in this folder

| Path | What it is |
| --- | --- |
| `ardentia.json` | The theme for the Herdr desktop app: terminal colors, the 16 ANSI colors and the panel colors |
| `ardentia.toml` | The block to paste into the `config.toml` of the terminal herdr: a base theme and the 19 tokens |
| `install.sh` | Copies `ardentia.json` into the app's themes folder and prints where `ardentia.toml` is |

## Herdr app

### Install with the script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/herdr/install.sh
```

The script copies `ardentia.json` to the `themes` folder of the app's configuration folder: `$HERDR_APP_HOME` when it is set, else `$XDG_CONFIG_HOME/herdr-app`, else `~/.config/herdr-app`. That is the order the app itself follows. It creates the folder if it is missing and prints where the file went. To send the theme somewhere else, set `HERDR_APP_HOME`:

```bash
HERDR_APP_HOME="/path/to/herdr-app" ./ardentia/herdr/install.sh
```

The script does not switch the active theme. For the terminal herdr it only prints the path of `ardentia.toml`: it does not create, read or edit any `config.toml`.

### Install by hand

Copy `ardentia.json` from this folder to `~/.config/herdr-app/themes/`. Keep the file name: the app calls the theme by it.

```bash
mkdir -p ~/.config/herdr-app/themes
cp ardentia/herdr/ardentia.json ~/.config/herdr-app/themes/
```

### Apply

In the app, open Settings, Look, and pick `ardentia` under Theme, in the Dark group. Or run the `app.theme` command against the open window:

```bash
herdr-app do app.theme --name ardentia
```

The app lists a theme by its file name, so Ardentia shows up in lowercase.

## Terminal herdr

### Use the block

1. Open your `config.toml`. On Linux and macOS it is `~/.config/herdr/config.toml`, on Windows `%APPDATA%\herdr\config.toml`. `herdr --help` prints the path in use.
2. Paste the contents of `ardentia.toml` at the end of the file. If the file already has a `[theme]` or `[theme.custom]` table, delete it first: a repeated table is a TOML error.
3. Validate the file:

   ```bash
   herdr config check
   ```

4. Reload the configuration, with the command below or with `reload config` in herdr's global menu:

   ```bash
   herdr server reload-config
   ```

herdr's documentation says the theme comes from the client's local configuration, and that the menu action reloads both the client's settings and the server's configuration.

### Colors inside the panes

The block colors herdr's own interface: sidebar, tab bar, floating panels, separators. It does not set the 16 ANSI colors, the background or the default text of the programs running in the panes. Those come from the host terminal. The natural pair is the Ghostty port, in [`../ghostty/`](../ghostty/), which gives the panes the Nota background and the same 16 colors listed below.

## Color map of the app theme

The base keys, which color the terminals:

| Key | Ardentia color | Hex | Use |
| --- | --- | --- | --- |
| `background` | Nota | `#161a30` | terminal background, fill of text fields in the panels |
| `foreground` | Texto | `#dde2fa` | terminal text |
| `selection` | Ardentia at 24% over Nota | `#234b58` | selection |
| `cursor` | Ardentia | `#4de8d8` | cursor |

The keys under `colors`, which color the panels:

| Key | Ardentia color | Hex | Use |
| --- | --- | --- | --- |
| `canvas` | Abismo | `#0b0d1a` | behind the pane cards |
| `chrome` | Fundo | `#101326` | sidebar, tab bar, status bar |
| `surface` | Nota | `#161a30` | cards and previews |
| `popover` | Fundo | `#101326` | menus, command palette, dialogs, find bar |
| `raised` | Relevo | `#1d2240` | active tab, secondary button |
| `hover` | Relevo | `#1d2240` | item under the pointer |
| `selected` | Relevo | `#1d2240` | selected row: active space, focused agent, current menu item |
| `border` | Borda | `#272d52` | dividers, pane outline |
| `input` | Borda forte | `#3a4273` | outline of text fields and secondary buttons, switch turned off |
| `ring` | Suave | `#a8b0db` | hover outline of a choice on the welcome screen |
| `foreground` | Texto | `#dde2fa` | interface text |
| `muted` | Suave | `#a8b0db` | labels, inactive tabs, status bar |
| `dim` | Tênue | `#8791c2` | descriptions, hints, icons at rest |
| `accent` | Ardentia | `#4de8d8` | outline of the focused pane and field, switch turned on |
| `accent_foreground` | Abismo | `#0b0d1a` | text and knob over the accent |
| `solid` | Ardentia | `#4de8d8` | primary button |
| `solid_foreground` | Abismo | `#0b0d1a` | text of the primary button |
| `working` | Lanterna | `#ffcc70` | spinner of an agent at work |
| `blocked` | Coral | `#ff7383` | "Needs you" badge, warning and error text |
| `done` | Maré | `#7cb2ff` | mark of an agent that finished |
| `idle` | Tênue | `#8791c2` | ring of an idle agent |
| `unknown` | Base-40 | `#4a5388` | dot of a space with no agent status, in the collapsed sidebar |

## The 16 colors

They are the `ansi` list of `ardentia.json`, in this order.

| Index | ANSI name | Ardentia color | Hex |
| --- | --- | --- | --- |
| 0 | black | Relevo | `#1d2240` |
| 1 | red | Coral | `#ff7383` |
| 2 | green | Sargaço | `#b4ee7c` |
| 3 | yellow | Lanterna | `#ffcc70` |
| 4 | blue | Maré | `#7cb2ff` |
| 5 | magenta | Anêmona | `#b9a0ff` |
| 6 | cyan | Ardentia | `#4de8d8` |
| 7 | white | Suave | `#a8b0db` |
| 8 | bright black | Tênue | `#8791c2` |
| 9 | bright red | Coral | `#ff7383` |
| 10 | bright green | Sargaço | `#b4ee7c` |
| 11 | bright yellow | Lanterna clara | `#ffe2a8` |
| 12 | bright blue | Maré clara | `#a9ccff` |
| 13 | bright magenta | Água-viva | `#ff7ac6` |
| 14 | bright cyan | Ardentia clara | `#8ff5ea` |
| 15 | bright white | Texto | `#dde2fa` |

## Color map of the terminal block

The base theme is `tokyo-night`. The 19 tokens below are the whole palette of herdr 0.9.5, so nothing of the base shows.

| Token | Ardentia color | Hex | Use |
| --- | --- | --- | --- |
| `accent` | Ardentia | `#4de8d8` | highlights, outline of the active pane, focused tab |
| `panel_bg` | Fundo | `#101326` | tab bar, floating panels, overlays, modals |
| `sidebar_bg` | Fundo | `#101326` | sidebar |
| `active_row_bg` | Relevo | `#1d2240` | row of the active space and of the focused agent |
| `selection_bg` | Borda | `#272d52` | cursor row in Navigate mode |
| `surface0` | Relevo | `#1d2240` | selected or focused item, tabs out of focus |
| `surface1` | Borda | `#272d52` | one step lighter, such as a row being dragged |
| `surface_dim` | Borda | `#272d52` | separators, scrollbar track of a pane out of focus |
| `overlay0` | Tênue | `#8791c2` | secondary text, labels of tabs out of focus, hints |
| `overlay1` | Suave | `#a8b0db` | supporting text one step brighter |
| `subtext0` | Suave | `#a8b0db` | names of spaces out of focus, labels |
| `text` | Texto | `#dde2fa` | main text |
| `mauve` | Anêmona | `#b9a0ff` | branch name |
| `green` | Sargaço | `#b4ee7c` | idle agent, connected, installed |
| `yellow` | Lanterna | `#ffcc70` | agent at work, connecting |
| `red` | Coral | `#ff7383` | blocked agent, needs attention, confirmation before removing or closing |
| `blue` | Maré | `#7cb2ff` | notification of finished work, agent that finished in the compact view |
| `teal` | Ardentia | `#4de8d8` | agent that finished, in the sidebar |
| `peach` | Estrela | `#ffa26b` | interrupted and warning states, according to a comment in the source |

## Port notes

Both files:

- Every color is one of the palette's own, except the selection in `ardentia.json`. Neither format is used with alpha here, so the selection is the mix computed ahead of time, Ardentia at 24% over Nota, which gives `#234b58`. It is the same selection the Obsidian and Ghostty ports draw.
- The terminal background is Nota, the surface the contrast ratios in the main README were measured against.
- The two products name agent states in different ways. The app names the state (`working`, `blocked`, `done`, `idle`); the terminal herdr names the hue (`yellow`, `red`, `teal`, `green`) and decides by itself which hue each state takes. In the app, `working`, `blocked` and `done` are Lanterna, Coral and Maré. In the terminal, a working agent is Lanterna and a blocked one is Coral, and a finished one is Ardentia in the sidebar and Maré in the compact view and in notifications. An idle agent is Tênue in the app and Sargaço in the terminal.

The app theme:

- The file sets every panel color. Without `colors` the app derives them by mixing the terminal background with white or black and draws interface text in a fixed near-white, all outside the palette.
- The file accepts only `background`, `foreground`, `selection`, `cursor`, `ansi` and `colors`. The app refuses any other key, so there is no name, author or version inside it.
- `canvas` is Abismo and the panes are Nota cards over it, like the islands of the Obsidian port.
- `muted` is Suave and `dim` is Tênue. In the app's panels `dim` is running text: descriptions in Settings, folder paths, hints. Base-40 measures 2.5:1 over Fundo and would not be readable there. Tênue measures 6.0:1.
- `input` is the outline of text fields, not their fill. The panels fill a field with `background`. The same key draws the track of a switch turned off and the tree lines of the agents list, which sit over rows in `raised`. In the colors the app derives, `input` is stronger than `border`, so here it is Borda forte, one step above Borda.
- `selected` is Relevo, the same color as `hover`, like a selected list item in the Zed and VS Code ports. Over Borda, text in `dim` would measure 4.3:1.
- `working`, `blocked` and `done` are Lanterna, Coral and Maré. They follow what the app does by itself with a theme that has no `colors`: the yellow, the red and the blue of the 16 colors. The app's panels reuse `blocked` for warning and error text, which therefore shows in Coral.
- `unknown` colors the dot of a space where no agent reports a status. It is not an error, so it is Base-40, the color for what should almost disappear.
- `ring` is not in the list of names the app documents for `theme()`, but the app resolves it, and the `win98` theme that ships with the app sets it. Without it the app derives a gray outside the palette, so the file sets it to Suave.
- Black, the first of the 16 colors, is Relevo, almost the color of the background. It works as a background and as text over a colored background. A program that writes in black over the default background is unreadable.
- The format has no key for the text under the cursor or for selected text.
- A layout's own `colors`, and the `colors` in the app's `settings.json`, win over the theme's. The Terminals layout that ships with the app sets its own, so there Ardentia shows only in part.
- The values are `#rrggbb`. The app's panels append two alpha digits to some of them, such as `blocked` and `accent`, to draw translucent fills, which only works with six digits.

The terminal block:

- The terminal herdr has no theme file and no themes folder. A theme is a built-in name plus overrides, so the port is a block to paste and not a file to install.
- The tokens were read in herdr 0.9.5: the list in the configuration reference, and what each one paints in the source code at tag `v0.9.5`. A later version may add or rename tokens. A token added later would take the color of the base theme, which is why the base is `tokyo-night`, the built-in theme closest to Ardentia's dark blues.
- In herdr 0.9.5, `herdr config check` reports an unknown theme name and an unknown token. It did not report an invalid color value in a test.
- `panel_bg` and `sidebar_bg` are Fundo, the color of sidebars and tab strips in every port. With a host terminal in Nota, the panes stay one step lighter than the interface around them.
- `overlay0` is the muted text of the whole interface, including the labels of tabs out of focus, so it is Tênue: 5.1:1 over Relevo and 6.0:1 over Fundo. Over the cursor row of Navigate mode, in Borda, the same text measures 4.3:1. The same token draws the outline of a pane out of focus, which is therefore brighter than Borda.
- `peach` can be set, but nothing in the 0.9.5 source paints with it.
- `surface_dim` is drawn as the line of the separators and as the scrollbar track, over the sidebar and the panels. It is Borda so the lines stay visible over Fundo.
- The hue tokens take the light of the same hue. `teal` and `accent` are both Ardentia.
- The selection of text inside a pane is not a token. herdr computes it from the host terminal's background, so it is not `#234b58`.
