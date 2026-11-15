# Ardentia for Ghostty

<b>English</b> · <a href="README.pt-BR.md">Português</a>

Reference for the Ghostty port. For the overview, the palette and the principles, start at the [main README](../README.md). Validated with the command line of Ghostty 1.4.0 (`+validate-config` and `+show-config`). It was not reviewed in an open window.

## What is in this folder

| Path | What it is |
| --- | --- |
| `Ardentia` | The theme. A Ghostty config file with no extension, holding only color keys |
| `install.sh` | Copies the theme into Ghostty's themes folder |

## Install with the script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/ghostty/install.sh
```

The script copies `Ardentia` to `$XDG_CONFIG_HOME/ghostty/themes`, or to `~/.config/ghostty/themes` when `XDG_CONFIG_HOME` is not set. It creates the folder if it is missing and prints where the file went. To send the theme somewhere else, set `GHOSTTY_THEMES_DIR`:

```bash
GHOSTTY_THEMES_DIR="/path/to/themes" ./ardentia/ghostty/install.sh
```

The script does not edit your Ghostty `config` file and does not switch the active theme.

## Install by hand

Copy the file `Ardentia` from this folder to `~/.config/ghostty/themes/`. Keep the name as it is, with no extension: the file name is the theme name.

```bash
mkdir -p ~/.config/ghostty/themes
cp ardentia/ghostty/Ardentia ~/.config/ghostty/themes/
```

## Activate

Add this line to your Ghostty configuration:

```
theme = Ardentia
```

If Ghostty follows the system appearance, pair Ardentia with a light theme of your choice:

```
theme = dark:Ardentia,light:<another theme>
```

`ghostty +list-themes` shows the themes available. On macOS the binary is at `/Applications/Ghostty.app/Contents/MacOS/ghostty`, outside the PATH. Ghostty loads the theme first, so any color you set in your own configuration wins over the theme.

## The 16 colors

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

## Other colors

| Key | Ardentia color | Hex | Use |
| --- | --- | --- | --- |
| `background` | Nota | `#161a30` | window background |
| `foreground` | Texto | `#dde2fa` | default text |
| `cursor-color` | Ardentia | `#4de8d8` | cursor |
| `cursor-text` | Abismo | `#0b0d1a` | text under the cursor |
| `selection-background` | Ardentia at 24% over Nota | `#234b58` | selection |
| `selection-foreground` | Texto | `#dde2fa` | selected text |
| `split-divider-color` | Borda | `#272d52` | line between splits |
| `unfocused-split-fill` | Abismo | `#0b0d1a` | dimming of the unfocused split |

`split-divider-color` exists since Ghostty 1.1.0. Ghostty dims an unfocused split by drawing a semi-transparent rectangle over it, and `unfocused-split-fill` is the color of that rectangle. How strong the dimming is stays with `unfocused-split-opacity`, which the theme does not set.

## Fonts

The theme sets no font. Ardentia's code family is Cascadia Code. To use it, install the font on your system and add this line to your own configuration:

```
font-family = Cascadia Code
```

`ghostty +list-fonts` lists the names Ghostty accepts.

## Port notes

- The file sets only color keys. Ghostty's documentation warns that a theme can set any configuration option and should be reviewed before use. This one has no font, no opacity and no cursor style: the keys are the ones in the two tables above. It is a short file, so read it before installing.
- The terminal background is Nota, the surface the contrast ratios in the main README were measured against.
- Black is Relevo, almost the color of the background. It works as a background and as text over a colored background. A program that writes in black over the default background is unreadable, and `minimum-contrast = 1.1` in your Ghostty configuration fixes that.
- Bright black is Tênue, at 5.6:1 over Nota. It is the color of shell suggestions and of comments in many terminal programs, so it has to be legible.
- Red and green repeat the normal color in bright. The palette has no lighter variant of those two, and inventing one would break the rule that every color comes from the palette.
- Bright magenta is Água-viva, the light that did not fit in the six normal hues.
- The selection is a mix computed ahead of time. Ghostty colors are `#RRGGBB`, `RRGGBB` or a named X11 color, with no alpha, so `selection-background` is Ardentia at 24% over Nota, which gives `#234b58`. It is the same selection the Obsidian port draws, and the only color in the file that is not one of the palette's own. Texto over it measures 7.4:1.
- The theme does not set Ghostty's search highlight colors. They stay at Ghostty's defaults.
- The 16 colors are the same in the Zed, VS Code and herdr ports.
