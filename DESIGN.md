---
name: Serene Ledger
colors:
  surface: '#faf8ff'
  surface-dim: '#d2d9f4'
  surface-bright: '#faf8ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f3ff'
  surface-container: '#eaedff'
  surface-container-high: '#e2e7ff'
  surface-container-highest: '#dae2fd'
  on-surface: '#131b2e'
  on-surface-variant: '#3e4948'
  inverse-surface: '#283044'
  inverse-on-surface: '#eef0ff'
  outline: '#6e7979'
  outline-variant: '#bdc9c8'
  surface-tint: '#006a6a'
  primary: '#006767'
  on-primary: '#ffffff'
  primary-container: '#1d8181'
  on-primary-container: '#f3fffe'
  inverse-primary: '#7dd5d4'
  secondary: '#505f76'
  on-secondary: '#ffffff'
  secondary-container: '#d0e1fb'
  on-secondary-container: '#54647a'
  tertiary: '#565d63'
  on-tertiary: '#ffffff'
  tertiary-container: '#6f757c'
  on-tertiary-container: '#fcfcff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#99f1f1'
  primary-fixed-dim: '#7dd5d4'
  on-primary-fixed: '#002020'
  on-primary-fixed-variant: '#004f50'
  secondary-fixed: '#d3e4fe'
  secondary-fixed-dim: '#b7c8e1'
  on-secondary-fixed: '#0b1c30'
  on-secondary-fixed-variant: '#38485d'
  tertiary-fixed: '#dde3eb'
  tertiary-fixed-dim: '#c1c7cf'
  on-tertiary-fixed: '#161c22'
  on-tertiary-fixed-variant: '#41474e'
  background: '#faf8ff'
  on-background: '#131b2e'
  surface-variant: '#dae2fd'
typography:
  display-currency:
    fontFamily: Plus Jakarta Sans
    fontSize: 36px
    fontWeight: '700'
    lineHeight: 44px
    letterSpacing: -0.02em
  h1:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  h2:
    fontFamily: Plus Jakarta Sans
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-caps:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '700'
    lineHeight: 16px
    letterSpacing: 0.05em
  data-tabular:
    fontFamily: Plus Jakarta Sans
    fontSize: 15px
    fontWeight: '500'
    lineHeight: 20px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  container-margin: 20px
  stack-gap: 16px
  element-gap: 8px
  card-padding: 20px
  grid-gutter: 12px
---

## Brand & Style

The design system is built upon a foundation of **Minimalism** and **Modern Corporate** aesthetics, specifically tailored for high-frequency mobile interactions. The brand personality is that of a "calm companion"—efficient and precise, yet soft enough to reduce the friction of financial tracking. 

The target audience consists of travelers and mindful spenders who value clarity over complexity. To achieve this, the system prioritizes heavy whitespace to reduce cognitive load and a "soft-touch" interface that feels premium and intentional. The emotional response should be one of control and tranquility, replacing the typical anxiety associated with expense tracking with a sense of organized flow.

## Colors

The palette revolves around a **Calm Teal** primary accent, chosen for its balance between the trustworthiness of blue and the growth associations of green. 

- **Primary:** Used for actionable elements, progress bars, and key data highlights.
- **Secondary/Neutrals:** A range of slate grays provides a sophisticated hierarchy for labels and metadata without competing with the primary data points.
- **Backgrounds:** A very light off-white (`#F8FAFC`) distinguishes the background from pure white (`#FFFFFF`) card surfaces, creating a natural sense of depth without heavy shadows.
- **Semantic Colors:** Softened versions of emerald and rose are used for "In" and "Out" cash flows to maintain readability while adhering to the minimalist aesthetic.

## Typography

The design system utilizes **Plus Jakarta Sans** across all levels. This typeface was selected for its modern, geometric structure and slightly rounded terminals, which reinforce the "approachable professional" vibe.

- **Currency Prominence:** A specific `display-currency` style is used for the primary balance. It uses a tighter letter spacing and a heavy weight to ensure it is the first thing a user sees.
- **Readability:** Body text maintains a generous line height. For transaction lists, `data-tabular` ensures that numerical figures align vertically for easy comparison.
- **Hierarchy:** We use uppercase bold labels for category headers to create clear section breaks without needing heavy lines.

## Layout & Spacing

This design system employs a **fluid grid** model optimized for mobile viewports. 

- **Margins:** A consistent 20px outer margin ensures content doesn't feel cramped against the screen edges.
- **Rhythm:** A base-4 spacing scale is used. Most vertical stacks between cards use 16px (`stack-gap`), while internal elements within a card use 8px (`element-gap`).
- **Data Density:** While minimalist, the layout allows for high data density in lists by using horizontal padding to create "breathing room" rather than vertical height.

## Elevation & Depth

Depth in the design system is achieved through **Tonal Layering** and **Ambient Shadows**. 

- **Surface Strategy:** The lowest level is the light-gray background. The second level consists of white cards.
- **Shadow Profile:** Shadows are extremely diffused (Blur: 20px, Spread: 0, Opacity: 4%) with a slight Y-offset (4px). They are tinted with the Primary color to prevent a "dirty" gray look.
- **Interactive Depth:** When a user taps a card or button, it should visually "sink" (shadow decreases) or "lift" (shadow increases) subtly to provide tactile feedback.
- **Overlays:** Modals and bottom sheets use a high-blur backdrop filter (10px) to maintain the minimalist focus on the active task.

## Shapes

The shape language is consistently **Rounded**, using a 16px (`1rem`) radius for standard cards and containers.

- **Buttons:** Use a fully rounded pill-shape to distinguish them from informational cards.
- **Icons:** Should follow a "soft-corner" aesthetic (2px corner radius on icon paths) to match the UI container roundedness.
- **Input Fields:** Match the card roundedness (0.5rem - 1rem) to create a unified visual language across forms.

## Components

- **Cards:** The primary container for transactions and budget summaries. Should have a white background, the defined ambient shadow, and 20px internal padding.
- **Primary Buttons:** Solid Teal background with white text. Use the pill-shape for high-level actions like "Add Expense."
- **Secondary Buttons/Chips:** Ghost style with a light teal or gray border and matching text for category filtering.
- **Transaction Lists:** Clean rows with a small 40x40px rounded-rect icon for the category, a bold title, and the tabular-num amount right-aligned.
- **Progress Bars:** Thin (4px - 6px height) with rounded caps. Use a light gray track and the teal primary color for the fill.
- **Currency Toggle:** A subtle segmented control that allows users to switch between home and local currency without leaving the main dashboard.
- **Data Visualization:** Simple donut charts or line graphs using the primary teal and its lighter tints to maintain the monochromatic, clean look.