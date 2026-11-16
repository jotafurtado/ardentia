# Ardentia for OpenCode

<b>English</b> · <a href="README.pt-BR.md">Português</a>

Reference for the OpenCode port. For the overview, the palette and the principles, start at the [main README](../README.md). The port is a theme for the OpenCode terminal interface, in the V2 theme format, with dark mode only. It has no screenshots.

## What is in this folder

| Path | What it is |
| --- | --- |
| `ardentia.json` | The theme. Every color is one of the palette, written as `#rrggbb` |
| `install.sh` | Copies the theme to the folder where OpenCode reads themes |

## Requirements

- OpenCode with the V2 theme format. The port was written against version 2.3.0.
- A terminal with 24-bit color.

## Install with the script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/opencode/install.sh
```

The script copies `ardentia.json` to `~/.config/opencode/themes/`, or to `$XDG_CONFIG_HOME/opencode/themes/` when that variable is set, and prints where the file went. To send it somewhere else, set `OPENCODE_THEMES_DIR` to the folder. When a different `ardentia.json` is already there, the script keeps it as `ardentia.json.bak-<date>` before it writes. It does not edit `cli.json`, `opencode.json` or `~/.zshrc`.

## Install by hand

Copy `ardentia.json` from this folder to `~/.config/opencode/themes/`, keeping the name: the file name, without `.json`, is the theme name. A theme in `.opencode/themes/` of a project takes the place of a global one with the same name.

## Activate

In OpenCode, press `Ctrl+P`, choose Open settings, then Theme, and pick `ardentia`. Or set it in `~/.config/opencode/cli.json`:

```json
{
  "theme": { "name": "ardentia", "mode": "dark" }
}
```

To go back, pick another theme, or put the old `theme.name` in again: the file stays where it is.

## Colors

Only the dark mode is defined. Backgrounds go from Fundo `#101326` to Borda forte `#3a4273`, and color is left for what tells something.

| Group | Colors |
| --- | --- |
| Background | Nota `#161a30`. Raised surfaces in Relevo `#1d2240`, Borda `#272d52` and Borda forte `#3a4273`. Form fields in Fundo |
| Text | Texto `#dde2fa`. Muted in Suave `#a8b0db`, faint in Tênue `#8791c2` |
| Actions | Primary in Ardentia `#4de8d8`, with Abismo `#0b0d1a` text. Secondary in Relevo. Destructive in Coral `#ff7383` |
| Feedback | Error in Coral, warning in Lanterna `#ffcc70`, success in Sargaço `#b4ee7c`, info in Maré `#7cb2ff` |
| Border and scrollbar | Borda and Borda forte |
| Diff | Added in Sargaço, removed in Coral, context in Tênue, hunk header in Anêmona `#b9a0ff`. The background of every line is Relevo |
| Syntax | Comment in Tênue, keyword in Água-viva `#ff7ac6`, function in Maré, variable in Texto, string in Sargaço, number in Estrela `#ffa26b`, type in Lanterna, operator in Anêmona, punctuation in Suave |
| Markdown | Heading in Água-viva, link in Maré, link text in Ardentia, code in Coral, quote in Suave, emphasis in Anêmona, strong in Lanterna, lists in Ardentia |
| Hue scales and categories | `accent` and `interactive` point to Ardentia. `neutral` goes from Texto to Fundo in nine steps. The other hues repeat their palette color. The categories use the colored hues |

## Port notes

- The diff has no tinted background, so an added line and a removed line differ by the color of the text, not by a green or red band. The palette has no dark green or dark red to tint it with.
- OpenCode asks for nine steps for each color scale. The palette has no such scale, so each hue repeats its palette color, with a lighter first step for Ardentia, Maré and Lanterna. The effect is that the steps OpenCode uses to lighten or darken a color do not change it.
- The theme has dark mode only. With `"mode": "light"` or `"system"` OpenCode uses the mode that exists, so the result is a dark theme. That was read in the code of OpenCode, and was not tried on screen.
- Every color is `#rrggbb`. `bun scripts/check-themes.ts`, at the root of the repository, checks that, the keys OpenCode asks for and the references between colors. It does not run OpenCode, so a theme the check accepts can still be refused by OpenCode.
- The port uses the V2 format. The older format, with `defs` and `theme`, is not part of the port.
