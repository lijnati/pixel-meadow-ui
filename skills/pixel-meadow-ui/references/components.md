# Pixel Meadow · Component & section catalog

Every pattern below exists, working, in `assets/template-product.html` or `assets/template-cinematic.html`.
Copy from those files rather than re-deriving; this file explains when to use each one and what makes it right.

## Contents
1. Scene frames (cinematic frame, paper hero, art card, final band)
2. Navigation (glass pill nav, sky nav)
3. Buttons and links
4. Hero copy blocks
5. Waitlist form
6. Proof strip
7. Step cards with isometric line art
8. Tabs + product mock
9. Feature row with art card and floating receipt
10. Pricing calculator
11. FAQ
12. Letter / long-read page
13. Footer
14. Pixel critters and the scene API

---

## 1. Scene frames
The art always sits inside a rounded window with white page around it. That inset is the signature.
- **Cinematic frame**: `.frame { position:fixed; inset:12px; border-radius:28px; overflow:hidden }`. Layers inside:
  `.photo` (the scene canvas, `data-depth=".35"`), `.haze` (radial + vertical dark gradients for text
  contrast), `canvas.pollen`, then content. Add a film-grain `::after` at 6–7% `mix-blend-mode:overlay`.
- **Paper hero**: `.sky-hero { margin:20px; border-radius:18px; height:min(900px,100svh - 40px); min-height:760px }`.
  `.sky-shade` gradient on top of the art: `linear-gradient(#00385230, #0000 27%, #025b8615 62%, #0000)`.
- **Art card**: a smaller scene (aspect ~1/.95, radius 18px) that holds a floating white UI card. Use it to
  make one feature feel celebratory (payout, success, reward).
- **Final band**: same as the hero but shorter, centered H2 + lede + the hero's two CTAs. Uses a different seed.

Keep the center clear: scene presets put the big shapes at the edges and the bottom. Copy goes center.

## 2. Navigation
- **Glass pill nav (cinematic)**: 60px tall, max 950px, `grid-template-columns: 1fr auto 1fr`, logo left,
  1–3 links centered in `--ink-soft`, one white small pill CTA right. `.glass` treatment.
- **Sky nav (paper)**: transparent, `padding:25px 38px`, brand left (yellow round check-mark logo + bold
  lowercase wordmark, -0.04em), links 14px, then ghost "Log in" + white pill CTA with `↗`.
  Below 960px hide the links; below 640px hide the ghost button.

## 3. Buttons and links
All buttons are pills. 49px tall (39px small, 44px mobile), `font: 550 14px`, 24px side padding, 12px icon gap.
| Variant | Use | Style |
|---|---|---|
| `btn-butter` | primary on paper and on bright art | `#ffe46b` bg, `#313712` text, hover `#fff09c` |
| `btn-light` / `btn-sheet` | primary on cinematic art; secondary on bright art | white / `#fffefa`, ink text |
| `btn-ink` | confirm actions inside product mocks | `#183d32` bg, white |
| `btn-outline` | secondary inside mocks | white + inset 1px `--rule-strong` |
| `btn-ghost` | low-priority nav action on art | transparent white text, hover fills white |
Arrows are text glyphs: `→` for in-page or primary, `↗` for external or secondary. Text links underline on
hover with `text-underline-offset: 5–6px`.

## 4. Hero copy blocks
Center-aligned. H1 (2 lines, two short sentences, optional italic serif word), lede ≤ 57ch,
CTA row (primary + secondary), fine print 12px. Cinematic heroes may add an eyebrow (12px, .32em caps)
or dot-separated tags. Paper heroes use the split-word reveal; cinematic heroes use `.reveal` with stagger.

## 5. Waitlist form (cinematic)
Glass pill, 540px max: transparent input + white button inside. `:focus-within` brightens the border and
adds a 5px white glow ring. Below it, a `.form-note` line that turns into the error or success message.
States: invalid → shake + warm border + "Hmm, that email doesn't look quite right."; submitting →
"Saving your spot…"; done → "You're on the list ✓" and the email becomes the placeholder.
Mobile: stack, 26px radius, full-width button.

## 6. Proof strip
Directly under the paper hero: one 12px line left ("Built for…/Works with…"), icon+label items right,
a 1px separator, then partner names in bold. Bottom hairline. Never logos in color.

## 7. Step cards with isometric line art
3 columns, 16px gap, pastel mint/cream/ice, radius 14, min-height 400px, `padding:25px 30px 30px`.
Top-left number in a 22px hairline circle; centered line drawing; H3 21px; 13px copy at 1.8.
Line art = isometric boxes drawn with `stroke:#183d32` at 55% opacity, 1px, fill `#fffefa` at 55%
(the `iso()` helper in the product template draws `stack`, `tray`, `grid`; extend it with new compositions
of `box(x,y,z,w,d,h)` for other metaphors: a phone, a chart, a door, a parcel).

## 8. Tabs + product mock
Segmented control: `--paper-deep` track, 4px padding, active pill in ink with white text. Real `role="tab"`
markup with arrow-key support. Each panel is a 2-column split: left H3 (34px, two lines) + paragraph +
numbered steps + butter CTA; right a tinted panel (`--ice-2` or `--mint`, radius 17) containing a
**realistic white app window** that bleeds off the bottom (radius 14 14 0 0).
The mock sells the product. It needs: a header row with icon + name + mono meta; a status chip; an ID in
mono; a sentence-case title in 22px/600; a person row with initials avatar; an attachment row; a
two-column fact split with a hairline divider; a mint confirmation note; footer buttons (outline + ink).
Use plausible example data and say so in the footer ("Product previews use example data").

## 9. Feature row with art card
Left: H2, paragraph, 3 icon ticks (17px stroked icons), butter CTA, small `↗` text link.
Right: art card with a floating white receipt: header with mint check, big number (currency label small
and raised, decimals at .45em), a muted caption, a hairline row and a mint "next step" row, then white pill
chips pinned to the bottom of the art.

## 10. Pricing calculator
Two halves inside a hairline-bordered, radius-18 container: left white "builder" (stepper pill,
range slider with filled track via `--fill`, radio-chip options), right cream panel holding a white
estimate card (line items with mono multipliers, big total 34px, full-width butter button with the arrow
pushed to the right edge, mono disclaimer). Recompute live in JS.

## 11. FAQ
Two columns: left sticky intro (a line-art doodle, H2 "X questions. Y answers.", one muted line);
right native `<details>` rows with hairlines and a CSS chevron that rotates 180°.

## 12. Letter / long-read page (cinematic variant)
For "about", "manifesto", "product story" pages. Fixed frame with a `dusk` scene that slowly scales as you
read (`--p` = scroll progress → `transform: scale(1.1 - p*.06) translateY(p*-2%)`), plus a dark radial
shade. Content scrolls inside `.scroller` with a top/bottom fade mask:
`mask-image: linear-gradient(180deg, transparent 0, transparent 70px, #000 170px, #000 calc(100% - 70px), transparent 100%)`.
Column 640px, Newsreader 300 at 1.8 line-height, warm off-white `rgba(255,249,238,.86)`.
Head: eyebrow, H1 with italic serif second line, italic serif date. Salutation in Instrument Serif 1.75em,
first paragraph with a 4.1em drop cap. Section headings: italic serif 1.6em preceded by a roman
numeral in 12px caps. Signature in italic serif 3.4em, a "P.S." line, and an underlined CTA link.
Paragraph reveals use `blur(4px) translateY(16px)`.

## 13. Footer
Paper: brand + tagline left, inline nav right, hairline, then © / legal links / honest disclaimer.
Cinematic: two lines pinned to the bottom of the frame (© left, "Questions? email" right), fade in at .9s.

## 14. Pixel critters and the scene API
```js
PixelScene.mount(el, { preset: "meadow" | "bloom" | "dusk" | "highland", seed: 7, pixel: 4, sky: ["#hex", ...] });
PixelScene.sprite(el, "bee" | "butterfly" | "bird", { scale: 4 });
PixelScene.pollen(canvas, { max: 70, color: "255,246,220" });
PixelScene.parallax(rootEl);            // animates any [data-depth] inside rootEl
```
- `el` must be positioned and sized; the canvas fills it and re-renders on resize.
- Change `seed` per instance so the hero, art card and final band never look copy-pasted.
- `pixel` (3–6) sets chunkiness; default scales with width. Bigger pixels for small cards.
- `meadow` also accepts `sunX`, `sunY` (0–1), `clouds:[light, mid, shadow]` and `clearCenter:false`.
- `dusk` accepts `sunX`, `sunY`, `sun:false`. `highland` accepts `sunX`, `sunY`, `clouds`, `huts:false`.
- Need something the presets don't draw (a city skyline, sea, snow)? Prefer recoloring a preset first; if you
  must extend `pixel-scene.js`, follow its pattern: draw into the low-res `Buf` with banded/dithered fills
  (`bayer`), 3–4 tone ramps per material, a 1px rim light on ridges, and hash() speckle for texture.
- One or two critters per scene, placed near flowers or edges, wrapped in `.critter.bob` or `.critter.sway`.

### Using real artwork instead
If the user has (or wants) commissioned/AI-generated pixel art, swap the canvas for
`<img class="sky-art" src="..." style="object-fit:cover;image-rendering:pixelated">`. Prompt for generating it:
"16-bit pixel art landscape, [rolling green hills with white daisies | giant sunflowers framing a bright blue
sky with fluffy pixel clouds], soft pastel clouds, warm sun, wide 16:9, empty center for text, no text,
crisp pixels, Stardew-like palette".
