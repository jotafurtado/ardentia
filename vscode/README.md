# Ardentia for VS Code

<b>English</b> · <a href="README.pt-BR.md">Português</a>

Reference for the VS Code port. For the overview, the palette and the principles, start at the [main README](../README.md). The port is a color theme extension. It is not on the Visual Studio Marketplace or on Open VSX yet, so it installs from this folder. It has no screenshots.

## What is in this folder

| Path | What it is |
| --- | --- |
| `package.json` | The extension manifest. It registers one dark theme, Ardentia, under `contributes.themes` |
| `themes/ardentia-color-theme.json` | The theme: workbench colors in `colors`, TextMate rules in `tokenColors` and semantic rules in `semanticTokenColors` |
| `CHANGELOG.md` | Version history of this port |
| `LICENSE` | A copy of the MIT license from the repository root, so the license travels inside the extension package |
| `.vscodeignore` | Keeps `install.sh` and hidden files out of the `.vsix` package |
| `install.sh` | Copies the extension into the VS Code extensions folder |

## Install by hand

VS Code loads extensions from its extensions folder: `~/.vscode/extensions` on macOS and Linux, `%USERPROFILE%\.vscode\extensions` on Windows.

1. Clone the repository, or download it.
2. Copy the `vscode/` folder into the extensions folder and name the copy `jotafurtado.ardentia-1.0.0`.
3. Restart VS Code.

## Install with the script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/vscode/install.sh
```

The script reads the version from `package.json` and copies `package.json`, `themes/`, both README files, `CHANGELOG.md` and `LICENSE` to `~/.vscode/extensions/jotafurtado.ardentia-1.0.0`. If that folder already exists, it is replaced. Nothing else in the extensions folder is touched. To send the extension somewhere else, set `VSCODE_EXTENSIONS_DIR`:

```bash
VSCODE_EXTENSIONS_DIR="/path/to/extensions" ./ardentia/vscode/install.sh
```

It does not edit `settings.json` and does not change the active theme.

## Install from a `.vsix`

The folder can be packaged with `vsce`, the VS Code extension packaging tool, which needs Node.js:

```bash
npm install -g @vscode/vsce
cd ardentia/vscode
vsce package
code --install-extension ardentia-1.0.0.vsix
```

`vsce package` writes the `.vsix` file in this folder. Instead of the last command, you can open the Extensions view in VS Code, select `Views and More Actions...` and then `Install from VSIX...`.

## Select the theme

Run `Preferences: Color Theme` from the Command Palette, or go to File, Preferences, Theme, Color Theme, and pick Ardentia.

## Color mapping

Every color in the file comes from the Ardentia palette in the main README, from its three lighter lights (Ardentia clara, Maré clara, Lanterna clara) or from two support colors, Base-40 `#4a5388` and the shadow `#04050c`. Some carry an alpha value.

### Surfaces

| Where | Color |
| --- | --- |
| Editor, terminal, active tab, breadcrumbs, minimap | Nota `#161a30` |
| Side bar, panel, tab strip, inactive tabs | Fundo `#101326` |
| Title bar, activity bar, status bar | Abismo `#0b0d1a` |
| Menus, Command Palette, hover, suggestions, notifications, find widget | Fundo `#101326`, outlined in Borda forte `#3a4273` |
| Input fields, dropdowns | Abismo `#0b0d1a`, outlined in Borda `#272d52`. With focus the outline is Ardentia |
| Hover in lists and tabs, selected item in a list without focus, current line | Relevo `#1d2240` |
| Selected item in a list with focus | Ardentia at 12% |
| Dividers, indent guides, rulers | Borda `#272d52` |
| Scrollbar thumb, active indent guide | Borda forte `#3a4273`, at 80% for the thumb at rest |
| Text in the editor, in hovers, in the Command Palette and in notifications | Texto `#dde2fa` |
| Side bar labels, menu items, inactive tabs, status bar text | Suave `#a8b0db` |
| Placeholders, descriptions, icons at rest, CodeLens, hints, Git blame annotations | Tênue `#8791c2` |
| Inline suggestions | Tênue at 80% |
| Disabled text | Tênue at 60% |
| Line numbers, whitespace characters, ignored files | Base-40 `#4a5388`, with the current line number in Suave |
| Cursor, focus border, active tab indicator, links, progress bar, buttons, badges | Ardentia `#4de8d8`, with Abismo for text over it |
| Selection | Ardentia at 24% |
| Other occurrences of the word or of the selection | Ardentia at 12% |
| Search matches | Lanterna `#ffcc70` at 22%, and at 45% for the current match, with its text in Texto |
| Changed lines in a diff, and the changed span inside them | Sargaço or Coral at 8% for the line, plus 12% for the span |
| Three-way merge editor | Sargaço for changes and Coral for the base at 12%, and at 18% for the changed words |

| State | Color |
| --- | --- |
| Error, deleted | Coral `#ff7383` |
| Warning, conflict | Estrela `#ffa26b` |
| Info, renamed | Maré `#7cb2ff` |
| Success, added, untracked | Sargaço `#b4ee7c` |
| Modified | Lanterna `#ffcc70` |

### Syntax

| Element | Color | Style |
| --- | --- | --- |
| Comments, doc comments | Tênue `#8791c2` | italic |
| Keywords, `this` and `self` | Água-viva `#ff7ac6` | italic |
| Preprocessor directives | Água-viva `#ff7ac6` | |
| Operators, Python's `and`, `or`, `not`, `in` and `is`, labels, lifetimes, YAML anchors, decorators, CSS pseudo-classes | Anêmona `#b9a0ff` | |
| Functions, methods, macros | Maré `#7cb2ff` | |
| Types, classes, interfaces, enums, namespaces, Java type references, C# built-in types, CSS class and id selectors | Lanterna `#ffcc70` | |
| Variables, parameters | Texto `#dde2fa` | |
| Properties, object keys, HTML attributes, CSS properties, JSON, YAML and TOML keys | Ardentia `#4de8d8` | |
| Numbers, booleans, constants, `null`, enum members, CSS units | Estrela `#ffa26b` | |
| Strings | Sargaço `#b4ee7c` | |
| String escapes | Ardentia `#4de8d8` | |
| Regular expressions | Lanterna `#ffcc70` | |
| HTML, JSX and XML tags | Coral `#ff7383` | |
| Punctuation, brackets, delimiters | Suave `#a8b0db` | |

| Markup | Color | Style |
| --- | --- | --- |
| Markdown headings 1 to 6 | Água-viva, Anêmona, Maré, Ardentia, Sargaço, Lanterna | bold |
| Headings in formats with a single heading scope | Água-viva `#ff7ac6` | bold |
| Bold | Lanterna `#ffcc70` | bold |
| Italic | Anêmona `#b9a0ff` | italic |
| Inline code and raw blocks | Coral `#ff7383` | |
| Quotes | Suave `#a8b0db` | italic |
| Link text, list markers | Ardentia `#4de8d8` | |
| Link address | Maré `#7cb2ff` | |
| Formatting marks, strikethrough | Tênue `#8791c2` | |

### Terminal

The integrated terminal sits on Nota `#161a30`, with text in Texto `#dde2fa`, the cursor in Ardentia and the selection in Ardentia at 24%. The 16 ANSI colors are the same in the Zed, VS Code, Ghostty and Herdr app ports.

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

## Semantic highlighting

The theme sets `semanticHighlighting` to `true`. With the setting `editor.semanticHighlighting.enabled` at `configuredByTheme`, which the VS Code documentation gives as the default, a language server that provides semantic tokens refines the colors of the TextMate rules.

`semanticTokenColors` has rules for the standard token types (`namespace`, `class`, `enum`, `interface`, `struct`, `typeParameter`, `type`, `parameter`, `variable`, `property`, `enumMember`, `decorator`, `event`, `function`, `method`, `macro`, `label`, `comment`, `string`, `keyword`, `number`, `regexp`, `operator`), with the same colors as the syntax table. A token type that has no rule falls back to the TextMate rules.

Two modifiers change a color:

- `variable.readonly` is Estrela, the color of constants. JavaScript and TypeScript are the exception: there `const` declares almost every local, so a `const` binding keeps Texto, like any variable.
- `property.static.readonly` is Estrela, for class constants. Other properties are Ardentia.

## Fonts

A VS Code color theme carries colors and font styles for tokens, not a font family, so this port sets none. In Ardentia, code is set in Cascadia Code. To use it in VS Code, install it on your system and set `editor.fontFamily` in `settings.json`:

```json
{
  "editor.fontFamily": "Cascadia Code"
}
```

## Port notes

- The port was written against the VS Code documentation. Every identifier in `colors` is in the Theme Color reference, but the theme has not been loaded in a running VS Code yet. If something looks wrong, please open an issue.
- Alpha values appear only in `colors`. `tokenColors` and `semanticTokenColors` use opaque colors, because semantic rules do not support transparency.
- Bracket pair colors (`editorBracketHighlight.foreground1` to `6`) follow the heading spectrum: Água-viva, Anêmona, Maré, Ardentia, Sargaço, Lanterna. They show when bracket pair colorization is enabled.
- The active tab has the background of the editor and an Ardentia line on top (`tab.activeBorderTop`).
- The status bar stays on Abismo while debugging. Only its text and its border turn Estrela.
- The remote indicator at the left of the status bar is Relevo with Ardentia text, not a solid block of accent color.
- Tags and types inside documentation comments, such as `@param` in JSDoc and PHPDoc, stay in Tênue italic with the rest of the comment.
- In JavaScript and TypeScript, a constant written in capitals can change from Estrela to Texto when the language server loads. The TextMate rules color its uses Estrela, and the semantic rule for a `const` binding colors it Texto.
- Over selected text, comments and part of the syntax measure less than 4.5:1, because the selection is Ardentia at 24%, as in the source theme.
- Bright red and bright green repeat the normal color in the terminal. The palette has no lighter variant of those two.
- The file also sets the keys the Theme Color reference lists for the modern UI (`modernUI.*`, `surface.*`, `modernTab.*`, `modernEditorTab.*`, `modernActivityBar.*`), with Abismo around the floating surfaces.
- The manifest has no `icon`. VS Code asks for a PNG of at least 128x128 pixels, and the port does not have one yet.
- The folder has the layout of an extension: the manifest, the `themes` directory, the changelog and the license inside the folder. Publishing to the Marketplace or to Open VSX is a separate step that has not been taken.
