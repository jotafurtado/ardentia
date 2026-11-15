# Ardentia for Zed

<b>English</b> · <a href="README.pt-BR.md">Português</a>

Reference for the Zed port. For the overview, the palette and the principles, start at the [main README](../README.md). The theme file follows Zed's theme schema v0.2.0. The port is not published in Zed's extension registry yet, and it has no screenshots.

## What is in this folder

| Path | What it is |
| --- | --- |
| `themes/ardentia.json` | The theme family, with a single dark theme named Ardentia |
| `extension.toml` | The extension manifest, with the id `ardentia-theme` |
| `LICENSE` | A copy of the MIT license from the repository root. Zed's extension registry asks for the license inside the extension folder |
| `install.sh` | Copies the theme into Zed's local themes folder |

## Install by hand

Zed loads any theme file placed in its local themes folder. No extension is needed.

1. Download [`themes/ardentia.json`](themes/ardentia.json).
2. Put it in `~/.config/zed/themes/` on macOS and Linux, or in `%USERPROFILE%\AppData\Roaming\Zed\themes\` on Windows. Create the folder if it does not exist.
3. The theme is in the theme selector the next time Zed loads.

## Install with the script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/zed/install.sh
```

The script copies `ardentia.json` to `~/.config/zed/themes` and creates the folder if it is missing. On Linux it uses `$XDG_CONFIG_HOME/zed/themes` when that variable is set. On macOS Zed ignores that variable, and so does the script. To send the file somewhere else, set `ZED_THEMES_DIR`:

```bash
ZED_THEMES_DIR="/path/to/themes" ./ardentia/zed/install.sh
```

It does not edit `settings.json` and does not change the active theme.

## Install as a dev extension

This folder is also a Zed theme extension. To load it without publishing:

1. Clone the repository.
2. In Zed, open the extensions page and click `Install Dev Extension`, or run the action `zed::InstallDevExtension`.
3. Select the `zed/` folder of the clone.

## Select the theme

Open the theme selector from the command palette (action `theme_selector::Toggle`), move to Ardentia and press enter. Zed saves the choice to your settings file.

To set it by hand in `settings.json`, use it as the dark theme, since Ardentia has no light variant:

```json
{
  "theme": {
    "mode": "system",
    "light": "One Light",
    "dark": "Ardentia"
  }
}
```

## Color mapping

Every color in the file comes from the Ardentia palette in the main README, from its three lighter lights (Ardentia clara, Maré clara, Lanterna clara) or from two support colors, Base-40 `#4a5388` and the shadow `#04050c`. Some carry an alpha value.

### Surfaces

| Where | Color |
| --- | --- |
| Editor, gutter, toolbar, terminal, active tab | Nota `#161a30` |
| Panels, tab bar, inactive tabs, menus and popovers | Fundo `#101326` |
| Title bar, status bar, app background | Abismo `#0b0d1a` |
| Hover, selected list item, buttons, current line | Relevo `#1d2240` |
| Borders, dividers, indent guides, wrap guide | Borda `#272d52` |
| Scrollbar thumb, active indent guide | Borda forte `#3a4273`, at 80% for the thumb at rest |
| Text in the editor and in the interface | Texto `#dde2fa` |
| Muted text, icons | Suave `#a8b0db` |
| Placeholders, muted icons, hints | Tênue `#8791c2` |
| Edit predictions | Tênue at 80% |
| Line numbers, invisible characters, ignored files | Base-40 `#4a5388`, with the current line number in Suave |
| Cursor, focus border, accent text and icons | Ardentia `#4de8d8` |
| Selection | Ardentia at 24% |
| Matching brackets | Ardentia at 18% |
| Other occurrences of the symbol under the cursor | Ardentia at 12% |
| Search matches | Lanterna `#ffcc70` at 22%, and at 45% for the current match |

| State | Color |
| --- | --- |
| Error, deleted | Coral `#ff7383` |
| Warning, conflict | Estrela `#ffa26b` |
| Info, renamed | Maré `#7cb2ff` |
| Success, created | Sargaço `#b4ee7c` |
| Modified | Lanterna `#ffcc70` |

### Syntax

| Element | Color | Style |
| --- | --- | --- |
| Comments, doc comments | Tênue `#8791c2` | italic |
| Keywords, `this` and `self` | Água-viva `#ff7ac6` | italic |
| Preprocessor directives | Água-viva `#ff7ac6` | |
| Operators, labels, lifetimes, decorators | Anêmona `#b9a0ff` | |
| Functions and methods | Maré `#7cb2ff` | |
| Types, constructors, enums, namespaces, modules, concepts | Lanterna `#ffcc70` | |
| Variables, parameters | Texto `#dde2fa` | |
| Properties, attributes | Ardentia `#4de8d8` | |
| Numbers, booleans, constants, enum variants, CSS units | Estrela `#ffa26b` | |
| Strings | Sargaço `#b4ee7c` | |
| String escapes | Ardentia `#4de8d8` | |
| Regular expressions | Lanterna `#ffcc70` | |
| Tags | Coral `#ff7383` | |
| Punctuation, brackets, delimiters | Suave `#a8b0db` | |

| Markup | Color | Style |
| --- | --- | --- |
| Headings | Água-viva `#ff7ac6` | bold |
| Strong emphasis | Lanterna `#ffcc70` | bold |
| Emphasis | Anêmona `#b9a0ff` | italic |
| Inline code and literal text | Coral `#ff7383` | |
| Link text, list markers | Ardentia `#4de8d8` | |
| Link address | Maré `#7cb2ff` | |
| Formatting marks, strikethrough | Tênue `#8791c2` | |

### Terminal

The terminal sits on Nota `#161a30`, with text in Texto `#dde2fa`. The 16 ANSI colors are the same in the Zed, VS Code, Ghostty and Herdr app ports.

| ANSI | Normal | Bright |
| --- | --- | --- |
| Black | Relevo `#1d2240` | Tênue `#8791c2` |
| Red | Coral `#ff7383` | Coral `#ff7383` |
| Green | Sargaço `#b4ee7c` | Sargaço `#b4ee7c` |
| Yellow | Lanterna `#ffcc70` | Lanterna clara `#ffe2a8` |
| Blue | Maré `#7cb2ff` | Maré clara `#a9ccff` |
| Magenta | Anêmona `#b9a0ff` | Água-viva `#ff7ac6` |
| Cyan | Ardentia `#4de8d8` | Ardentia clara `#8ff5ea` |
| White | Suave `#a8b0db` | Texto `#dde2fa` |

## Fonts

A Zed theme carries colors, and font style and weight for syntax. It does not choose a font family, so this port sets none. In Ardentia, code is set in Cascadia Code and the interface in Geist. To use them in Zed, install both on your system and add this to `settings.json`:

```json
{
  "buffer_font_family": "Cascadia Code",
  "ui_font_family": "Geist"
}
```

## Port notes

- Zed asks for a dim variant (`dim`) of each ANSI color and the palette has none. Each dim color is the normal color at 60% opacity, and the dim foreground is Tênue.
- Bright red and bright green repeat the normal color. The palette has no lighter variant of those two.
- The first entry in `players`, which is you, uses Ardentia, the color of the cursor. The others follow the heading spectrum: Água-viva, Anêmona, Maré, Sargaço, Lanterna, Estrela, Coral.
- `accents` lists the six heading colors in order: Água-viva, Anêmona, Maré, Ardentia, Sargaço, Lanterna.
- Zed themes style Markdown headings through a single `title` entry, so every level is Água-viva in bold. The level by level spectrum of the Obsidian port does not exist here.
- Zed's Markdown grammar marks only the marker of a block quote, not the quoted text. The marker is Tênue and the text keeps the default color.
- Zed uses the same `attribute` capture for HTML attribute names and for attributes in languages such as Rust and C. The port colors it Ardentia, like a property, so `#[derive]` in Rust shows in Ardentia.
- The published schema is behind the app. Besides the 142 keys of schema v0.2.0, the theme sets 15 keys that Zed 1.28.1 reads and the schema does not list yet: `search.active_match_background`, `editor.hover_line_number`, `editor.debugger_active_line.background`, `debugger.accent`, `drop_target.border` and ten `version_control` keys. Without them the word diff, the conflict markers and the conflict state in the Git panel would show in Zed's default colors.
- The schema has no key for the outline of floating surfaces. Menus and popovers take `border.variant`, which this port keeps on Borda, the same color as the dividers.
- The schema has no key for a tab indicator. The active tab is told apart by its background, Nota over the Fundo of the tab bar.
- Over selected text, comments and part of the syntax measure less than 4.5:1, because the selection is Ardentia at 24%, as in the source theme.
- The folder has the layout of a theme extension: the manifest, the `themes` directory and the license inside the folder. Publishing to the registry is a separate step that has not been taken.
