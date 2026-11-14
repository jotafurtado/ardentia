# Ardentia for Obsidian

<b>English</b> · <a href="README.pt-BR.md">Português</a>

Reference for the Obsidian port. For the overview, screenshots and install steps, start at the [main README](../README.md). Tested on Obsidian 1.15.

## What is in this folder

| Path | What it is |
| --- | --- |
| `theme.css` | The theme. Thirteen sections, from palette to glow, with a Style Settings block at the top |
| `snippets/` | Optional CSS snippets: glow off, glow doubled and the embedded fonts |
| `screenshots/` | Images used by the README and by the community directory |
| `demo/` | A demo vault with one note per design board |
| `scripts/` | The script that rebuilds the font snippet |
| `install.sh` | Copies the theme and the snippets into a vault |

The theme's `manifest.json` lives at the repository root, not here. The Obsidian community directory reads it from the root of the default branch.

## Measurements

| Variable | Value | Use |
| --- | --- | --- |
| `--ardentia-gap` | 8px | between islands |
| `--ardentia-raio` | 14px | islands and modals |
| `--radius-m` | 10px | blocks and callouts |
| `--radius-s` | 7px | items and tabs |
| `--file-line-width` | 700px | reading column |
| `--line-height-normal` | 1.6 | note body |
| `--ribbon-width` | 44px | ribbon |
| `--icon-stroke` | 1.75px | icon stroke |

Headings are sized in `em` (H1 1.6, H2 1.35, H3 1.18, H4 1.06, H5 1, H6 0.85 in spaced uppercase), all at weight 600. The body size is Obsidian's own setting, `--font-text-size`.

## Fonts

| Job | Family | Variable |
| --- | --- | --- |
| Headings | Bricolage Grotesque | `--h1-font` to `--h6-font` |
| Text | Atkinson Hyperlegible Next | `--font-text-theme` |
| Interface | Geist | `--font-interface-theme` |
| Code | Cascadia Code | `--font-monospace-theme` |

To rebuild the embedded font snippet from Google Fonts:

```bash
bun obsidian/scripts/build-font-snippet.ts
```

Copyright notices for the four families are in [`snippets/FONTS.md`](snippets/FONTS.md).

## Glow

`--ardentia-brilho` goes from `0` to `2`, with `1` as the original drawing. Two limits come from Obsidian itself: the regular editor cursor is the browser's native caret, which takes a color but not a shadow, and the graph is drawn on a canvas, which takes no CSS halo either.

## Demo vault

`demo/` is a vault with the notes from the design boards (Ardentia, Paleta, Tipografia, Layout, Elementos) and the theme wired in through symbolic links. Open the folder as a vault to see every element and to edit `theme.css` with immediate results. The notes are in Portuguese. On Windows, clone with symlinks enabled or use `install.sh` instead.

## Implementation notes

- The sidebar labels ("Cofre", "Sumário", "Grafo local") come from `--ardentia-rotulo-*` variables, in Portuguese when Obsidian is in Portuguese and in English otherwise. Obsidian does not expose the view name inside the panel.
- The buttons of each sidebar view, the property type icon and "Add property" are hidden at rest and appear on hover, so the note and the islands look like the drawing without losing function.
- The language label on code blocks in reading mode depends on one rule per language. The common ones are covered.
- With the translucent window on, only the abyss lets the desktop through. The islands stay opaque.
- The back and forward arrows stay visible at the left of the note header, before the breadcrumb.

## Releasing

A tag in the form `x.y.z` that matches `version` in the root `manifest.json` triggers [the release workflow](../.github/workflows/release-obsidian.yml), which attaches `manifest.json` and `theme.css` to a GitHub release. Obsidian downloads the theme from that release. Tags for other apps carry a prefix, such as `zed-1.0.0`.
