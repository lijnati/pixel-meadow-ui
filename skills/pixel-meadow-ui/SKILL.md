---
name: pixel-meadow-ui
description: Design and build landing pages, waitlists, and product marketing sites in the "Pixel Meadow" style, with 16-bit pixel-art nature heroes (rolling meadows, giant sunflowers, dusk hills) inside rounded inset frames, frosted-glass pill nav, DM Sans display type with an Instrument Serif italic accent, butter-yellow and white pill buttons, paper-white sections in deep green ink, pastel step cards, realistic product mocks, and soft blur-in motion. Use this skill whenever the user wants a landing page, homepage, waitlist, coming-soon page, pricing section, product site, or UI that looks like millow.space or testr, or asks for something "cozy", "pixel art", "Stardew-like", "calm and premium", "nature", "glassmorphism on art", "warm indie SaaS", or wants to restyle an existing page that way, even if they don't name the style. Works for plain HTML, React/Next.js, and Tailwind.
---

# Pixel Meadow UI

A design system distilled from two pages people love: a cinematic AI-companion waitlist (a pixel meadow
behind glass) and a playful product site (a sunflower sky over calm paper sections). The feeling is
**warm, quiet confidence**. The art does the emotional work, while the type and UI stay restrained,
precise and grown-up. The contrast between charming 16-bit pixel art and crisp modern UI makes it memorable.

This skill gives you everything needed to reproduce that quality for *any* product:
- `assets/pixel-scene.js`: a zero-dependency generator that paints the pixel-art scenes procedurally
  (presets `meadow`, `bloom`, `dusk`, `highland`), plus pixel critters, pollen motes and mouse parallax.
  No image files needed.
- `assets/template-cinematic.html`: a one-screen teaser/waitlist. Glass nav, headline, email capture.
- `assets/template-product.html`: a full SaaS landing page. Hero, proof strip, pastel step cards, tabs with
  a product mock, an art-card feature, a pricing calculator, FAQ, a closing band and a footer.
- `references/tokens.md`: exact type scale, colors, radii, spacing and motion specs. Read it before styling.
- `references/components.md`: when and how to use each section pattern, plus the letter/long-read
  layout and the scene API. Read the relevant parts before composing a page.

## Workflow

1. **Pick the mode from the brief.**
   - *Cinematic*: one screen, everything floats on the art. Good for waitlists, teasers, emotional products
     (AI companion, wellbeing, journaling) and "letter" pages. Scene `meadow` (day) or `dusk` (reflective).
   - *Paper*: a pixel-art hero and closing band frame paper-white content sections. Good for any product
     that has to explain itself (SaaS, marketplaces, tools, fintech). Scene `bloom` for playful or
     `meadow` for calm.
   If the user asks for a "landing page" for a real product with features and pricing, use Paper.
   For "coming soon" or "waitlist", use Cinematic. A product site can also link to a Cinematic letter page.

2. **Start from the matching template, not from scratch.** Copy it into the user's project (or your
   output folder) along with `pixel-scene.js`. For a single-file deliverable (an artifact, a one-page
   demo), inline the script contents into a `<script>` tag instead of `src="pixel-scene.js"`. The
   templates already contain the subtle details (grain, haze gradients, focus rings, reduced-motion,
   accessible tabs, error states) that make the style feel finished. Rebuilding them from memory loses those details.

3. **Replace all content with the user's product.** The templates use fictional brands (Glade, Orchard).
   Rewrite every headline, step, mock and FAQ for the user's product, following the voice rules below.
   Remove sections that don't serve the product. Add ones that do, built from the same parts.
   Keep the rhythm: **art → paper → paper → … → art → footer**.

4. **Choose the scene for the story, and make it this product's scene.** Presets:
   | Preset | Feels like | Good for |
   |---|---|---|
   | `meadow` | calm day, rolling green hills, daisies, pastel clouds, warm sun | wellbeing, AI companions, calm SaaS |
   | `bloom` | bright saturated sky, giant sunflowers framing the center | playful consumer, marketplaces, rewards |
   | `dusk` | low setting sun, stars, silhouetted hills, fireflies | letters, manifestos, "about", evening CTAs |
   | `highland` | golden hour, flat-topped mountains, acacias, round huts, yellow daisies | African / Ethiopian products, fintech for the continent, travel, agriculture |
   Don't default to `meadow` every time. Pick what fits the product's place and mood, and vary between pages.
   Recolor with `sky: [...]` stops (top to horizon) for a different hour or brand hue (for example dawn
   `["#f4b9a0", "#f7d6b0", "#cfe3ef"]` or violet dusk `["#2a1f4f", "#5b3f7a", "#c06c84", "#f6b26b"]`), and use a
   different `seed` for every instance (hero, art card, final band). Add 1–2 critters at the edges. The scenes
   keep the central band clear of clouds. If a headline still crosses busy art, strengthen the haze/shade
   gradient rather than shrinking the type.

5. **Adapt to the stack.** For React/Next.js, put the scene in a client component that calls
   `PixelScene.mount(ref.current, opts)` in `useEffect` (guard against double-mount in StrictMode by
   clearing the element first), and import the script as a module or vendor it into `/public`. For Tailwind,
   map tokens into `theme.extend` (colors `ink`, `paper`, `butter`, `mint`, `cream`, `ice`; radius `pill: 999px`;
   `ease-meadow: cubic-bezier(.22,1,.36,1)`) and keep the few signature effects (glass, split reveal, scene)
   as small CSS classes. Load fonts with `next/font/google` (DM_Sans, Instrument_Serif, Geist_Mono).

6. **Verify visually.** If a browser or Playwright is available, screenshot at 1440×900 and 390×844 and look:
   is the headline readable on the art? Is the center of the scene clear? Do reveals fire? Does nothing
   overflow horizontally on mobile? Fix before handing over.

## Non-negotiables (what makes it look like *this* style)

- The art lives in a **rounded window inset from a white page edge** (12px/28px cinematic, 20px/18px paper).
  It never bleeds full-width.
- **Pixel art stays pixelated**: low-res canvas + `image-rendering: pixelated`. Never blur or smooth it.
  Modern UI elements on top stay perfectly crisp. That contrast is the point.
- **Display type is DM Sans 500–650 with tight negative tracking** (-0.035 to -0.04em) and line-height
  ~1.02–1.12. One italic **Instrument Serif** word may carry the emotion ("a little more *understood*").
- **Every interactive surface is a pill.** Buttons, nav, input, tabs. Cards are 14–18px radius. Nothing is square.
- **Color is calm**: deep green ink (#183d32) on white/paper, never black. Pastels only as card fills. One
  loud color at most (butter #ffe46b) and only on the primary action.
- **Motion is slow and soft**: 1–1.2s, `cubic-bezier(.22,1,.36,1)`, blur-to-sharp reveals, tiny arrow nudges.
  Nothing bounces or spins. Always respect `prefers-reduced-motion`.
- **Generous whitespace**: 90px section padding, 1160px container, 60px column gaps, max ~46–57ch line length.

## Voice (copy matters as much as pixels)

- Headlines are **two short, parallel sentences** that rhyme in structure: "Clear spending. Calmer teams."
  "Fewer receipts. More clarity." "Simple plans. Honest pricing." Or one sentence with a single italic word.
- Plain, warm, human and specific. Speak to one person. No hype words ("revolutionary", "supercharge",
  "unleash", "seamless"). No exclamation marks.
- Ledes are one or two sentences stating the concrete benefit, ≤ 57ch per line.
- Microcopy is kind: "Hmm, that email doesn't look quite right." / "Saving your spot…" / "You're on the list ✓".
- Fine print is honest: "An estimate, not a charge." / "Product previews use example data."
- Buttons are verbs + outcome: "Start a free budget →", "Get early access →", "Book a walkthrough ↗".

## Originality and respect for the source sites

Reproduce the *design language*, never the source sites' identity. Don't reuse their names, logos, wordmarks,
taglines, body copy or illustration files, and don't build a page that could pass for theirs. Every page you
make should belong unmistakably to the user's product. The procedural scenes are original art, so use them.

## Quick checklist before delivering

- [ ] Right mode for the brief; sections chosen for this product, not left over from the template
- [ ] All template copy replaced; voice rules followed; no lorem ipsum
- [ ] Scene presets/seeds varied; center clear; critters placed tastefully
- [ ] Fonts load (DM Sans, Instrument Serif; Geist Mono / Newsreader only if used)
- [ ] Mobile (≤ 640px) checked: nav collapses, form stacks, nothing overflows
- [ ] Keyboard: visible focus, tabs work with arrows, form labels present
- [ ] `prefers-reduced-motion` honored; scene still renders (it's static art)
- [ ] `pixel-scene.js` shipped next to the page or inlined
