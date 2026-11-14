---
tags:
  - theme
  - obsidian
created: 2026-11-11
status: draft
---
**Ardentia** is the glow the sea lights at night, when plankton stirs. The theme starts there: an abyss for a background, almost black, and color only where there is *signal*, as in the [[Palette]], headings, links and ==highlights==.

## Principles

- The background stays quiet, color is always a signal.
- Each heading level steps one color down the spectrum.
- Free typefaces, one for each job: reading, operating, coding.

> [!tip] Islands layout
> Each panel floats over the abyss with 8 px of breathing room. The continuous layout is still there for those who prefer everything joined.

### Next steps

- [x] Define the palette
- [x] Choose the free typefaces
- [ ] Test in the vault #theme/test

```css
/* the glow lives in the variables */
.theme-dark {
  --background-primary: #161A30;
  --text-accent: #4DE8D8;
}
```

See also [[Typography]], [[Layout]], [[Elements]] and the [[Changelog]].
