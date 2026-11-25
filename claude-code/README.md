# Ardentia for Claude Code

<b>English</b> · <a href="README.pt-BR.md">Português</a>

Reference for the Claude Code port. For the overview, the palette and the principles, start at the [main README](../README.md). The port is a custom theme, `ardentia.json`: it sits on top of the built-in `dark-ansi` theme, which draws with the 16 colors of the terminal, and fixes the backgrounds that `dark-ansi` paints with the wrong one. It has no screenshots.

## What is in this folder

| Path | What it is |
| --- | --- |
| `ardentia.json` | The theme. Every color is one of the palette, written as `#rrggbb` |
| `install.sh` | Copies the theme to the folder where Claude Code reads it |

## Requirements

- Claude Code with custom themes. The port was written and tested against version 2.1.332.
- A terminal that runs Ardentia, such as [Ghostty](../ghostty/README.md) or [Rex](../rex/README.md): everything the theme does not override comes from the 16 colors of the terminal.
- A terminal with 24-bit color.

## Install with the script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/claude-code/install.sh
```

The script copies `ardentia.json` to `~/.claude/themes` and prints where the file went. When `CLAUDE_CONFIG_DIR` is set, it writes to `$CLAUDE_CONFIG_DIR/themes` instead. When a different `ardentia.json` is already there, the script keeps it as `ardentia.json.bak-<date>` before it writes. It does not edit `settings.json`.

## Install by hand

Copy `ardentia.json` from this folder to `~/.claude/themes`, keeping the name `ardentia.json`.

## Activate

Run `/theme` in Claude Code and pick Ardentia. Claude Code watches the folder, so the theme shows up in the list without a restart. The other way is to set it in `~/.claude/settings.json`:

```json
{
  "theme": "custom:ardentia"
}
```

To go back, pick another theme in `/theme`. That takes Ardentia out of use and leaves the file where it is.

## Colors

The port overrides six keys, all of them backgrounds. Every other key keeps the value of `dark-ansi`, one of the 16 colors of the terminal.

| Key | What it paints | Color |
| --- | --- | --- |
| `userMessageBackground` | Background of the box of a sent prompt | Relevo `#1d2240` |
| `userMessageBackgroundHover` | The same box under the pointer | Borda `#272d52` |
| `composerSidebarBackground` | Background of the composer sidebar | Relevo `#1d2240` |
| `memoryBackgroundColor` | Background of the memory input | Relevo `#1d2240` |
| `bashMessageBackgroundColor` | Background of the shell command input | Relevo `#1d2240` |
| `rate_limit_empty` | Empty track of the usage limit | Borda `#272d52` |

## Port notes

- The theme only fixes the backgrounds. Text, borders, diffs and the rest come from the terminal, so on a terminal without Ardentia the result is that terminal's colors with these six backgrounds on top.
- Without this port, `dark-ansi` paints the box of a sent prompt with the bright black of the terminal. In the Ardentia terminal ports that color is Tênue `#8791c2`, the color of muted text, and Texto over it measures 2.4:1. With the port the box goes down to Relevo, at 12.1:1.
- The arrow before a sent prompt has no key of its own: it uses `inactive`, the key of all inactive text in the interface. The port leaves it alone.
- The format of a custom theme was read from Claude Code 2.1.332, not from public documentation, and may change in a later version. Claude Code drops, with no warning, an override whose key the base theme does not have or whose color it cannot read. That is why `bun scripts/check-themes.ts`, at the root of the repository, checks the keys against the list of that version and the colors against the palette.
- Claude Code also takes `rgb(...)`, `ansi:<name>` and `ansi256(n)` as a color. The port uses only `#rrggbb` from the palette.
- There is no light variant. The status line is a separate port, [cc-statusline](../cc-statusline/README.md).
