# Ardentia for Kiro CLI

<b>English</b> · <a href="README.pt-BR.md">Português</a>

Reference for the Kiro CLI port. For the overview, the palette and the principles, start at the [main README](../README.md). Kiro CLI 3.3.0 does not take colors of your own: its theme settings only choose among fixed presets. So this port carries no colors. It makes the interface draw with the 16 colors of the terminal, and the palette comes from a terminal that already runs Ardentia. It has no screenshots.

## What is in this folder

| Path | What it is |
| --- | --- |
| `kiro_cli_theme.json` | The theme preferences of Kiro CLI, with no fixed base and no preset for the prompt, the response or the diff |
| `install.sh` | Writes the preferences into the settings folder of Kiro CLI and keeps a copy of the ones that were there |

## Requirements

- Kiro CLI. The port was written against version 3.3.0.
- A terminal that runs Ardentia, for the palette to show: the [Ghostty](../ghostty/README.md) port or the [Rex](../rex/README.md) port. On any other terminal the interface takes the colors of that terminal.

## Install with the script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/kiro-cli/install.sh
```

The script writes `kiro_cli_theme.json` to `~/.kiro/settings/`, or to `$KIRO_HOME/settings/` when that variable is set. To send it somewhere else, set `KIRO_SETTINGS_DIR`. If a different `kiro_cli_theme.json` is already there, the script first keeps a copy of it in the same folder, named `kiro_cli_theme.json.bak-` and the date and time.

The script does not edit any shell file.

## Install by hand

Copy `kiro_cli_theme.json` from this folder to the settings folder of Kiro CLI. If you have chosen a theme in Kiro CLI before, keep a copy of the file that is there first:

```bash
cp ardentia/kiro-cli/kiro_cli_theme.json ~/.kiro/settings/kiro_cli_theme.json
```

## Activate

Add this line to the configuration file of your shell, `~/.zshrc` or `~/.bashrc`:

```bash
export KIRO_TERMINAL_THEME=safe
```

Open a new terminal and start Kiro CLI. To go back, take the line out and put your copy of `kiro_cli_theme.json` in again, or choose a theme in the settings of Kiro CLI.

If you later choose the dark or the light theme in the settings of Kiro CLI, it saves that choice in `kiro_cli_theme.json`, and the choice wins over the variable.

## What changes

With `KIRO_TERMINAL_THEME=safe`, Kiro CLI uses its `safe` theme, which names terminal colors instead of fixing its own. The table shows what each part takes and what that is on a terminal with Ardentia.

| Part of the interface | Terminal color | On a terminal with Ardentia |
| --- | --- | --- |
| Text | Default | Texto |
| Links, functions in code | Blue | Maré |
| Accent, keywords in code | Magenta | Anêmona |
| Information, variables in code | Cyan | Ardentia |
| Success, lines added in a diff | Green | Sargaço |
| Warning, strings in code | Yellow | Lanterna |
| Error, lines removed in a diff | Red | Coral |
| Brand, numbers in code | Bright magenta | Água-viva |
| Highlight | Bright blue | Maré clara |
| Comments in code | Bright black | Tênue |

Two parts keep the colors of Kiro CLI on every theme, this one included: the mascot on the home screen and the context usage panel.

## Port notes

- The theme file of Kiro CLI 3.3.0 has four fields: `baseTheme`, `promptPreset`, `responsePreset` and `diffPreset`. Each one picks from a fixed list, and no list has a color of the palette. That is why the port leaves all four out.
- `baseTheme` only takes `dark` and `light`. The `safe` theme is asked for with the `KIRO_TERMINAL_THEME` variable, and a `baseTheme` saved in the file wins over the variable. The file of the port has no `baseTheme` for that reason.
- Without the variable, Kiro CLI tries to tell whether the terminal is dark or light and uses its own dark or light theme, whose colors are fixed.
- The mascot on the home screen and the six bands of the context usage panel have fixed colors on the three themes of Kiro CLI. The port cannot change them.
- All of this was read in the interface code of Kiro CLI 3.3.0. A later version may change the file, the variable or the themes.
- The port has no colors of its own, so `scripts/check-themes.ts` does not check it.
