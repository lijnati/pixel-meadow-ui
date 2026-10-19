# Pixel Meadow · Design tokens

Two modes share one DNA: **Cinematic** (everything floats in glass on a full-bleed scene) and **Paper**
(a pixel-art hero and closing band frame calm, paper-white content sections). A page usually uses Paper,
with Cinematic for one-screen teasers, waitlists and "letter" pages.

## Typography

| Role | Family | Weight | Size | Line height | Tracking |
|---|---|---|---|---|---|
| Hero display (cinematic) | DM Sans | 500 | `clamp(42px, 6.6vw, 92px)` | 1.02 | -0.035em |
| Hero display (paper) | DM Sans | 650 | `max(48px, min(5.4vw, 78px))` | 1.08 | -0.04em |
| Accent word | Instrument Serif *italic* | 400 | 1.08em of parent | inherit | -0.01em |
| H2 section | DM Sans | 600 | `clamp(34px, 3.6vw, 47px)` | 1.12 | -0.035em |
| H3 card | DM Sans | 600 | 21px | 1.3 | -0.035em |
| Big number | DM Sans | 600 | 64px, decimals at .45em | 1 | -0.05em |
| Lede on art | DM Sans | 400 | 18–21px | 1.5–1.65 | 0 |
| Body | DM Sans | 400 | 15px | 1.6–1.8 | 0 |
| Small / card copy | DM Sans | 400 | 13px | 1.8 | 0 |
| Meta / IDs / labels | Geist Mono | 400–500 | 10.5px UPPERCASE | 1.4 | .02em |
| Eyebrow | DM Sans | 500 | 12px UPPERCASE | — | .32em |
| Long-read body | Newsreader | 300 | `clamp(18px, 1.35vw, 21px)` | 1.8 | 0 |

Google Fonts:
`https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,100..1000;1,9..40,400&family=Instrument+Serif:ital@0;1&family=Geist+Mono:wght@400;500&family=Newsreader:ital,opsz,wght@0,6..72,300;0,6..72,400;1,6..72,400&display=swap`
(Only load what the page uses.)

Rules: weight 500–650 for display, never 700+ (it gets chunky against pixel art). Two-line headlines
built from two short sentences. At most ONE italic serif word per headline.

## Color

### Cinematic (glass on art)
```css
--ink: #ffffff;
--ink-soft: rgba(255,255,255,.82);
--ink-mute: rgba(255,255,255,.62);
--forest: #15200f;            /* frame fallback behind the scene */
--glass-border: rgba(255,255,255,.32);
--glass-shadow: 0 20px 60px -20px rgba(10,25,40,.35), inset 0 1px 0 rgba(255,255,255,.45), inset 0 -1px 0 rgba(255,255,255,.06);
--blur: 22px;
```
Text on art: `text-shadow: 0 2px 30px rgba(10,30,50,.3)` (headline), `0 1px 20px rgba(10,30,50,.4)` (lede).

### Paper (content sections)
```css
--paper: #f7f9f5;  --paper-deep: #eaf0e8;  --sheet: #fffefa;
--ink: #183d32;    --ink-soft: #53665d;    --ink-faint: #5c7067;
--rule: #dce4da;   --rule-strong: #bdcabe;
--accent: #21634e; --accent-deep: #164c3b; --accent-soft: #e4eee4;
--sky: #087eb2;                      /* hero fallback bg while canvas paints */
--butter: #ffe46b; --butter-hover: #fff09c; --butter-ink: #313712;
--mint: #e8f1e5;   --cream: #fcf0c9;  --ice: #e7f0f6;  --ice-2: #edf5fa;
```
Pastel triad for step cards, always in this order: **mint → cream → ice**.
Status chips: cream bg + `#7a5b05` text with a pulsing dot. Success rows: mint.

### Re-theming
Keep the structure; swap the scene preset and one accent:
- Calm / wellbeing / AI companion → `meadow` scene, Cinematic, white buttons.
- Playful / marketplace / consumer → `bloom` scene, Paper, butter primary button.
- Reflective / about / manifesto → `dusk` scene, letter layout, Newsreader body.
- Custom brand hue: change `--accent`/`--ink` within the same family (deep, desaturated, dark enough
  for 7:1 on white), and pass `sky:[...]` stops to the scene. Never use pure black text.

## Shape, depth, spacing

```css
--radius-pill: 999px;    /* every button, nav, input, tab bar, chip-row */
--frame-radius: 28px;    /* cinematic frame (22px < 640px) */
--frame-gap: 12px;       /* white edge around the frame (8px < 640px) */
--hero-radius: 18px;     /* paper hero + final band (12px mobile), inset 20px from viewport */
--card-radius: 14px;     /* pastel cards, mock windows */
--panel-radius: 17–18px; /* tinted panels that hold a mock */
--container: 1160px;     /* content width; cinematic nav is 950px */
```
Section rhythm: 90px vertical padding (64px mobile); head row = H2 left, 46ch paragraph right, aligned to bottom.
Gaps: cards 16px, columns 60px, button groups 12px.
Shadows are soft and colored (tinted to ink/sky), never grey: e.g. `0 30px 60px -30px rgba(24,61,50,.25)`.
Borders are hairlines (`1px var(--rule)`) or inset rings (`box-shadow: inset 0 0 0 1px`).

## Motion

```css
--ease: cubic-bezier(.22, 1, .36, 1);   /* used for everything */
```
| Pattern | Spec |
|---|---|
| Reveal | from `opacity:0; translateY(24px); blur(6px)` → none, 1.1–1.2s, stagger with `--d` .1–.15s |
| Split-word headline | each word from `translateY(40%) blur(8px)`, 1s, 70ms stagger |
| Nav entrance | `fade-down` 14px, 1.2s |
| Button hover | lift 1px + deeper shadow; arrow `→` slides 3px (`↗` moves 2px up-right) |
| Press | `scale(.98)` |
| Parallax | scene layers `data-depth` .2–.9, eased 5%/frame, 40px × 24px max travel |
| Pollen | 20–70 warm motes `rgba(255,246,220)`, drifting up with sine sway and twinkle |
| Critters | pixel bee/butterfly: `bob` 2.6s or `sway` ±7° 3.4s |
| Error | `shake` ±6px .45s + warm border `rgba(255,190,170,.9)` |
| Live dot | `box-shadow` pulse 2s |

Always ship `prefers-reduced-motion: reduce` → no animation, reveals shown.
