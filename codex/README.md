# Ardentia for Codex

<b>English</b> · <a href="README.pt-BR.md">Português</a>

Reference for the Codex port. For the overview, the palette and the principles, start at the [main README](../README.md). The port is a syntax theme for the Codex terminal interface, a `.tmTheme` file. It has no screenshots.

## What is in this folder

| Path | What it is |
| --- | --- |
| `ardentia.tmTheme` | The theme. Every color is one of the palette, written as `#rrggbb` |
| `install.sh` | Copies the theme to the folder where Codex reads themes |

## What it themes

Codex lets a `.tmTheme` color the code blocks and the diffs it draws in the terminal. The colors of the rest of the interface come from the terminal, so pair this theme with the Ardentia theme of [Ghostty](../ghostty/) or [Rex](../rex/). The Codex desktop app does not read this file.

## Requirements

- Codex CLI with custom `.tmTheme` support. The port was written against version 0.169.0.
- A terminal with 24-bit color.

## Install with the script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/codex/install.sh
```

The script copies `ardentia.tmTheme` to `~/.codex/themes/`, or to `$CODEX_HOME/themes/` when that variable is set, and prints where the file went. When a different `ardentia.tmTheme` is already there, the script keeps it as `ardentia.tmTheme.bak-<date>` before it writes. It does not edit `config.toml`.

## Install by hand

Copy `ardentia.tmTheme` from this folder to `~/.codex/themes/`, keeping the name: the file name, without `.tmTheme`, is the theme name.

## Activate

In Codex, type `/theme` and pick `ardentia`, with live preview as you move. Or set it in `~/.codex/config.toml`:

```toml
[tui]
theme = "ardentia"
```

To go back, pick another theme, or remove the `theme` line: the file stays where it is.

## Colors

| Group | Colors |
| --- | --- |
| Editor | Background Fundo `#101326`, text Texto `#dde2fa`, cursor Ardentia `#4de8d8`, selection Borda `#272d52`, current line Nota `#161a30`, gutter Tênue `#8791c2` |
| Syntax | Comment in Tênue, keyword in Água-viva `#ff7ac6`, function in Maré `#7cb2ff`, variable in Texto, string in Sargaço `#b4ee7c`, number and escape in Estrela `#ffa26b`, type in Lanterna `#ffcc70`, operator in Anêmona `#b9a0ff`, punctuation in Suave `#a8b0db`, invalid in Coral `#ff7383` |
| Markdown | Heading in Água-viva, link in Maré, code in Coral, quote in Suave, emphasis in Anêmona, strong in Lanterna, lists in Ardentia |
| Diff | Added in Sargaço, removed in Coral, hunk header in Anêmona |

## Port notes

- The diff has no tinted background, so an added line and a removed line differ by the color of the text. The palette has no dark green or dark red to tint it with.
- Every color is `#rrggbb`. `bun scripts/check-themes.ts`, at the root of the repository, checks that and that each one belongs to the palette. It does not run Codex, so a theme the check accepts can still be refused by Codex, which then falls back to its default theme.
- The theme was not tried on screen.
