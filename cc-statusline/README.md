# Ardentia for the Claude Code status line

<b>English</b> · <a href="README.pt-BR.md">Português</a>

Reference for the Claude Code status line. For the overview, the palette and the principles, start at the [main README](../README.md). The status line is a Bash script that Claude Code runs to draw the line under the prompt. It has no screenshots.

## What is in this folder

| Path | What it is |
| --- | --- |
| `statusline.sh` | The status line. Reads the JSON Claude Code sends on standard input and prints one line in segments |
| `install.sh` | Copies the status line into the Claude Code configuration folder |

## Requirements

- `jq`, to read the JSON.
- `git`, for the branch and the count of changed files.
- A terminal font with Nerd Font glyphs, for the arrows and the icons.
- A terminal with 24-bit color.

## Install with the script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/cc-statusline/install.sh
```

The script copies `statusline.sh` to `~/.claude/ardentia-statusline.sh`, or to `$CLAUDE_CONFIG_DIR/ardentia-statusline.sh` when that variable is set. It creates the folder if it is missing, makes the file executable and prints where it went. The file gets its own name, so a `statusline.sh` already in that folder is left alone.

The script does not edit `settings.json`.

## Install by hand

Copy `statusline.sh` from this folder to `~/.claude/ardentia-statusline.sh` and make it executable:

```bash
cp ardentia/cc-statusline/statusline.sh ~/.claude/ardentia-statusline.sh
chmod +x ~/.claude/ardentia-statusline.sh
```

## Activate

Add this to the `settings.json` of Claude Code, which is `~/.claude/settings.json` by default:

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/ardentia-statusline.sh"
  }
}
```

If the file already has a `statusLine` entry, replace it.

## Segments

The status line is one capsule in Relevo `29;34;64`, with rounded ends. The segments sit side by side on that background, split by a thin arrow in Borda forte `58;66;115`. Color goes in the text, and only where it tells something. The colors are written in the script as RGB triplets.

| Segment | What it shows | Text color |
| --- | --- | --- |
| Folder | `~` at home, the folder name, or `…/name` when the folder is nested deeper under home | Maré `124;178;255` |
| Git | The branch, or the short commit when there is no branch. Only inside a repository | Anêmona `185;160;255` |
| Changes | The number of changed files, when there are any, then the lines added and removed in the session | Files in Lanterna `255;204;112`, lines added in Sargaço `180;238;124`, lines removed in Coral `255;115;131`. A zero is Tênue `135;145;194` |
| Model | An icon for the model family, the model name and an icon for the effort level | Ardentia `77;232;216` |
| Context | Tokens in use over the size of the context window, with the percentage. The icon changes at 25%, 50% and 75% | Sargaço below 50%, Lanterna from 50% to 74%, Coral from 75% on |
| Session name | The name of the session, cut at 40 characters. Only when the session has a name | Tênue |

## Port notes

- The script started as the status line its author already used, five solid blocks in five colors. What each segment shows is the same: texts, icons, cuts and calculations. The drawing changed, to follow the theme's first principle: the background stays quiet and color is a signal.
- The context is the segment that warns. It stays Sargaço while there is room, turns Lanterna at half the window and Coral at three quarters.
- In the changes segment a zero stays in Tênue, so color shows up only when lines were added or removed.
- Every color is one of the palette's own. The nine triplets sit at the top of the script, each under the name of its color.
- Relevo measures 1.1:1 over Nota, the background of the Ghostty port, so the capsule is discreet on that terminal. Every text color measures at least 5:1 over Relevo.
- The colors are 24-bit escape sequences. A terminal without 24-bit color shows them wrong.
- The status line sets `GIT_OPTIONAL_LOCKS=0`. Claude Code calls it often, and without that setting its `git status` would compete with your own Git commands for the index lock.
