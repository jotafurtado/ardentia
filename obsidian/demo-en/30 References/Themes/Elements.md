---
tags:
  - theme
  - reading
---
Everything Obsidian's Markdown draws, from a link to a code block, on the note background. Part of [[Ardentia]].

## Links and tags

Internal link to [[Palette]]

External link to [obsidian.md](https://obsidian.md)

A note that does not exist yet: [[Changelog]]

#theme #theme/test #reading

## Emphasis

**Bold in lantern**, *italic in anemone*, ***both together***

~~Strikethrough~~, ==highlight== and `inline code`

Shortcut <kbd>Ctrl</kbd> <kbd>P</kbd> and a footnote[^1]

## Lists

- First level, bullet in ardentia
    - Second level, with an indent guide
        - Third level

1. Numbered list
2. With the numbers in anemone

## Tasks

- [ ] To do
- [x] Done
- [/] In progress
- [>] Deferred
- [!] Important
- [?] Question
- [-] Cancelled

## Callouts

> [!note] Note
> Background at 8% and outline at 28% of its own color.

> [!tip] Tip
> No side bar, the whole block carries the color.

> [!warning] Warning
> The body text keeps the regular color.

> [!danger] Danger
> Coral is reserved for errors and risk.

> [!success] Success
> Each type brings its own icon as well as its color.

> [!question]- Folded question
> A foldable callout.

> [!example] Example
> Anemone.

> [!quote] Quote
> Faint.

## Blockquote

> Ardentia: the phosphorescence of sea water, visible at night.

## Table

| Element | Light     | Variable       |
| ------- | --------- | -------------- |
| Link    | Ardentia  | `--link-color` |
| Tag     | Água-viva | `--tag-color`  |
| Bold    | Lanterna  | `--bold-color` |

## Code block

```typescript
type Light = 'ardentia' | 'coral';

interface Wave {
  energy: number;
  light: Light;
}

// only what moves glows
export const ignite = (sea: Wave[]): Wave[] =>
  sea.filter((w) => w.energy > 0);
```

```html
<note class="glow" data-sea="42">$sea /wave/g</note>
```

## Embedded note

![[Palette#When the water moves]]

## Horizontal rule

---

## Math

$e^{i\pi} + 1 = 0$

[^1]: The footnote sits at the end of the page.
