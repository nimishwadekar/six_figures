---
name: Serene Ledger
source-note: Entries Tab reference (warm UI) + app implementation in lib/app_theme.dart
colors:
  surface: '#f7f4ef'
  surface-dim: '#e8e0d8'
  surface-bright: '#fcfaf6'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2ede6'
  surface-container: '#ede7df'
  surface-container-high: '#eae6df'
  surface-container-highest: '#ded8cf'
  navigation-bar-background: '#f0e8e6'
  on-surface: '#1a1a1a'
  on-surface-variant: '#6b6b6b'
  inverse-surface: '#2c2c2c'
  on-inverse-surface: '#f5f5f5'
  outline: '#bdb5ad'
  outline-variant: '#e0d8ce'
  surface-tint: transparent
  primary: '#e91e63'
  on-primary: '#ffffff'
  primary-container: '#fce4ec'
  on-primary-container: '#880e4f'
  inverse-primary: '#f48fb1'
  secondary: '#5c5c5c'
  on-secondary: '#ffffff'
  secondary-container: '#e8e8e8'
  on-secondary-container: '#2c2c2c'
  tertiary: '#6d6d6d'
  on-tertiary: '#ffffff'
  tertiary-container: '#eae6df'
  on-tertiary-container: '#1a1a1a'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  background: '#f7f4ef'
  on-background: '#1a1a1a'
  display-currency: 'CHF'
  category-icon-transport: '#e65100'
  category-icon-food: '#00897b'
  category-icon-drinks: '#1e88e5'
  category-icon-shopping: '#2e7d32'
  category-icon-fun: '#5c6bc0'
typography:
  display-currency:
    fontFamily: Platform default sans-serif
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: 0
  h1:
    fontFamily: Platform default sans-serif
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  h2:
    fontFamily: Platform default sans-serif
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Platform default sans-serif
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 22px
  body-md:
    fontFamily: Platform default sans-serif
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-caps:
    fontFamily: Platform default sans-serif
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.8px
    textTransform: uppercase
  data-tabular:
    fontFamily: Platform default sans-serif
    fontSize: 16px
    fontWeight: '600'
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

The UI follows a **warm, soft expense-tracker** look: bone/cream surfaces, white metric cards, and a **pink accent** for FAB and navigation selection. Typography uses the **platform default sans-serif** (SF on iOS, system sans on Android).

## Colors

- **Surfaces:** Warm off-white page (`#F7F4EF`), white cards, slightly darker bands for date headers (`surfaceContainerHigh`).
- **Primary (accent):** Pink `#E91E63` for FAB, active nav, and key emphasis — not teal.
- **Navigation bar:** Light pink-beige `#F0E8E6` with a soft pill indicator using primary at low opacity.
- **Category icons:** Distinct hues — burnt orange (transport), teal (food), blue (drinks), green (shopping), indigo (fun).

## Typography

- **Metrics and list amounts:** Grey **CHF** (or home currency) prefix, **bold whole units**, **smaller fraction** on the baseline (see `_CurrencyAmountTypographic` in `lib/stitch_app.dart`).
- **Entry titles:** Semi-bold (`titleMedium` weight 600).

## Entries list

- **Date row:** Full-width band; **one line** — `Weekday, 25th Sep` left, **CHF total** right.
- **Rows:** Flat **ink-well** rows with **dividers** (not a card per row); **40dp circular** category icons with **outlined** glyphs.

## Elevation

- Metric cards: light shadow + subtle border; list rows rely on **dividers** and band background rather than heavy elevation.

## Implementation

Authoritative theme: **`lib/app_theme.dart`** (`AppTheme.light`). Shell and screens: **`lib/stitch_app.dart`**.
