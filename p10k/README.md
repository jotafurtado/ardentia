# Ardentia for Powerlevel10k

<b>English</b> · <a href="README.pt-BR.md">Português</a>

Reference for the Powerlevel10k port. For the overview, the palette and the principles, start at the [main README](../README.md). The port is a complete Powerlevel10k configuration, loaded in place of `~/.p10k.zsh`. It has no screenshots.

## What is in this folder

| Path | What it is |
| --- | --- |
| `ardentia.zsh` | The configuration. It clears every Powerlevel10k option set before it and sets its own, so it works alone |
| `install.sh` | Copies the configuration next to your zsh files, under its own name |

## Requirements

- Powerlevel10k, already installed and loaded by your `~/.zshrc`. The port was written against version 1.20.0.
- zsh 5.7.1 or newer, for 24-bit color.
- A terminal with 24-bit color.
- A terminal font with Nerd Font glyphs, for the rounded ends, the separator and the icons.

## Install with the script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/p10k/install.sh
```

The script copies `ardentia.zsh` to `~/.p10k-ardentia.zsh`, or to `$ZDOTDIR/.p10k-ardentia.zsh` when that variable is set. To send it somewhere else, set `P10K_ARDENTIA_FILE` to the full path of the file. It creates the folder if it is missing and prints where the file went. The file gets its own name, so your `~/.p10k.zsh` is left alone, and the script refuses a destination named `.p10k.zsh`.

The script does not edit `~/.zshrc`.

## Install by hand

Copy `ardentia.zsh` from this folder to `~/.p10k-ardentia.zsh`:

```bash
cp ardentia/p10k/ardentia.zsh ~/.p10k-ardentia.zsh
```

## Activate

In `~/.zshrc`, find the line that loads the Powerlevel10k configuration:

```zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
```

Replace it with this one:

```zsh
[[ ! -f ~/.p10k-ardentia.zsh ]] || source ~/.p10k-ardentia.zsh
```

Open a new terminal, or run `exec zsh`. To go back, put the old line in again: `~/.p10k.zsh` stays where it was.

## Segments

The prompt has two lines. The first is one capsule in Relevo `#1d2240`, with rounded ends. The segments sit side by side on that background, split by a thin arrow in Borda forte `#3a4273`. The second line is the prompt character, with no background. Color goes in the text, and only where it tells something.

| Segment | What it shows | Text color |
| --- | --- | --- |
| Folder | The current folder. When it is long, the middle parts shrink to their shortest unique prefix | Maré `#7cb2ff`. Shortened parts in Tênue `#8791c2`. The anchors, which are the first part, the last part and the root of a project, in Maré clara `#a9ccff`, bold |
| Git | `on` and the branch, then what is pending: `⇣` and `⇡` for commits behind and ahead of the remote, `*` for stashes, `~` for conflicts, `+` for staged changes, `!` for unstaged changes, `?` for untracked files. Only inside a repository | Branch in Anêmona `#b9a0ff`. Behind and ahead in Ardentia `#4de8d8`. Staged in Sargaço `#b4ee7c`. Unstaged in Lanterna `#ffcc70`. Untracked in Maré. Conflicts and an operation in progress in Coral `#ff7383`. `on`, stashes and a status still being read in Tênue |
| Status | `✔` when the last command worked. `✘` and the exit code when it failed | Sargaço when it worked, Coral when it failed |
| Duration | `took` and how long the last command ran, from 3 seconds on | Tênue |
| Background jobs | An icon while a job runs in the background | Tênue |
| Prompt character | `❯` on the second line. In the vi modes, `❮`, `V` and `▶` | Ardentia when the last command worked, Coral when it failed |

On a narrow terminal the prompt drops what matters least. Below 80 columns the Git segment, the status icon, the duration and the background jobs are hidden. Below 50 columns the folder shows only its last part.

Nothing is drawn on the right side.

## Port notes

- The configuration started as the one its author already used, made by the Powerlevel10k wizard in the classic style: grey blocks with angled ends and colors from the 256-color table. What each segment shows, and when, is the same. The drawing changed, to follow the theme's first principle: the background stays quiet and color is a signal.
- The two-line frame is gone. The second line holds the prompt character, which is what the transient prompt already showed.
- The file is a complete configuration, not a layer of colors. It clears every `POWERLEVEL9K_*` option first, so a segment you had on in your own file is off here. To bring one back, add it to `POWERLEVEL9K_LEFT_PROMPT_ELEMENTS` in your copy. A segment that this file does not color takes the colors of Powerlevel10k, which are not from the palette.
- Every color is one of the palette's own, written as `#rrggbb`. `bun scripts/check-themes.ts`, at the root of the repository, checks that.
- Relevo measures 1.1:1 over Nota, the background of the Ghostty and Rex ports, so the capsule is discreet on those terminals. Every text color in the capsule measures at least 5:1 over Relevo. The prompt character measures 11.3:1 over Nota in Ardentia and 6.6:1 in Coral.
- The colors are 24-bit escape sequences. A terminal without 24-bit color shows them wrong.
- After a segment with no background, Powerlevel10k switches the text to black before it prints a space. That black never paints a visible character.
- The narrow-terminal rules read `_p9k__clm`, an internal variable of Powerlevel10k. A later version may rename it; the rules would then stop hiding segments.
- The file leaves `POWERLEVEL9K_CONFIG_FILE` unset, so `p10k configure` writes to `~/.p10k.zsh` as usual and not over this file.
- The transient prompt and the instant prompt stay on, as in the original configuration. The instant prompt only works with its block at the top of `~/.zshrc`, which the Powerlevel10k wizard adds.
