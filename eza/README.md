# Ardentia for eza

<b>English</b> · <a href="README.pt-BR.md">Português</a>

Reference for the eza port. For the overview, the palette and the principles, start at the [main README](../README.md). The port is a `theme.yml`: it quiets the metadata of a long listing and leaves color only where it tells something. It has no screenshots.

## What is in this folder

| Path | What it is |
| --- | --- |
| `theme.yml` | The theme. Every color is one of the palette, written as `#rrggbb` |
| `install.sh` | Copies the theme to the folder where eza reads it |

## Requirements

- eza with theme support. The port was written and tested against version 0.23.5.
- A terminal with 24-bit color.

## Install with the script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/eza/install.sh
```

The script copies `theme.yml` to the folder where eza reads it and prints where the file went:

| System | Folder |
| --- | --- |
| macOS | `~/Library/Application Support/eza` |
| Linux | `$XDG_CONFIG_HOME/eza`, or `~/.config/eza` when that variable is not set |

To send it somewhere else, set `EZA_CONFIG_DIR`, the folder eza itself reads first. When a different `theme.yml` is already there, the script keeps it as `theme.yml.bak-<date>` before it writes. It does not edit `~/.zshrc`.

## Install by hand

Copy `theme.yml` from this folder to the folder in the table above, keeping the name `theme.yml`.

## Activate

Nothing to turn on: eza reads the theme on every run, with no flag. To go back, delete the file, or put the backup in its place.

The theme cannot hide a column or reorder them: the order is fixed in eza. To drop the owner column, which is always the same on a personal machine, do it in the command. This alias also keeps the header row:

```zsh
alias ll="eza -lah --no-user --icons --git"
```

## Colors

Metadata is Tênue `#8791c2`, so color is left for what asks for attention. A field that is not in the table keeps the eza default.

| Field | Color |
| --- | --- |
| Normal file, every file type (image, video, audio, archive, document, source) | Texto `#dde2fa` |
| Folder, mount point | Maré `#7cb2ff` |
| Symbolic link | Ardentia `#4de8d8` |
| Executable | Sargaço `#b4ee7c`, bold |
| Pipe, socket, device, special file | Anêmona `#b9a0ff` |
| Broken link and its target | Coral `#ff7383` |
| Permissions, size, owner, group, date, inode, blocks, octal, flags, punctuation | Tênue |
| Header row, with `-h` | Texto, underlined |
| Special permission bits, a file with more than one link | Lanterna `#ffcc70` |
| Owner and group `root` | Coral |
| Git: new | Sargaço |
| Git: modified | Lanterna |
| Git: deleted, in conflict | Coral |
| Git: renamed | Ardentia |
| Git: ignored | Tênue |
| Git repository: main branch | Ardentia |
| Git repository: other branch | Lanterna |
| Git repository: clean | Sargaço |
| Git repository: dirty | Lanterna |

## Port notes

- `EZA_COLORS` wins over the theme, key by key. If you already have it set, its keys cover the ones here.
- `--color=never` turns the whole theme off.
- File types (image, video, document and so on) are all Texto, so color does not repeat what the icon already says. Icons are not part of the port: they take the color of the name.
- eza drops the whole theme, with no warning, when one color in it is not valid. That is why every color is `#rrggbb`, and why `bun scripts/check-themes.ts`, at the root of the repository, checks them against the palette.
- On macOS eza does not read `~/.config/eza` or `$XDG_CONFIG_HOME`, so the script writes to `~/Library/Application Support/eza`. Only macOS was tested.
- The 16 terminal colors do not come from this file. A terminal that runs Ardentia, such as Ghostty or Rex, already draws what eza leaves at its default.
