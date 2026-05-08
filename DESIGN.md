---
name: Serene Ledger
source-note: Palette in lib/app_theme.dart (`AppPalette` + `AppTheme.light`)
colors:
  bg-1: '#ffffff'
  bg-2: '#f7f6f3'
  bg-3: '#ebe7e4'
  primary: '#e91e63'
  on-primary: '#ffffff'
  primary-container: '#fce4ec'
  on-primary-container: '#880e4f'
  on-surface: '#1a1a1a'
  on-surface-variant: '#6b6b6b'
  secondary: '#5c5c5c'
  outline: '#bdb5ad'
  outline-variant: '#e0d8ce'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  inverse-surface: '#2c2c2c'
  on-inverse-surface: '#f5f5f5'
  inverse-primary: '#f48fb1'
  category-transport: '#e65100'
  category-food: '#00897b'
  category-drinks: '#1e88e5'
  category-shopping: '#2e7d32'
  category-fun: '#5c6bc0'
  category-health: '#c62828'
  category-utilities: '#ffb300'
  category-housing: '#6d4c41'
  category-unknown: '#b0bec5'
  display-currency: 'CHF'
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

## Brand & style

Warm ledger UI: three neutrals (**BG1–3**), **pink** accent, platform sans-serif (SF / system).

## Colours

Authoritative definitions: **`AppPalette`** in [`lib/app_theme.dart`](lib/app_theme.dart).

- **BG1** — White. Cards, entry rows, FAB, dialog bodies tied to `surfaceContainerLowest`.
- **BG2** — Warm grey page. Scaffold, app bar, tertiary container tone; maps to `ColorScheme.surface`.
- **BG3** — Taupe. Bottom navigation and muted on-card chips; also used for `secondaryContainer` and most `surfaceContainer*` roles so Material 3 stays consistent without extra ramp stops.
- **Primary** — `#E91E63` for FAB, selected nav, emphasis.
- **Category disks** — `AppPalette.category*` (transport, food, drinks, shopping, fun, health, utilities, housing, unknown fallback).

`ColorScheme` fixed / inverse / error slots are filled from the same file for Material 3 compatibility.

## Typography

- **Amounts:** Grey currency prefix, bold whole units, smaller fraction (`_CurrencyAmountTypographic` in [`lib/stitch_app.dart`](lib/stitch_app.dart)).
- **Entry titles:** `titleMedium` weight 600.

## Entries list

- **Date row:** Full width; weekday + day + month left, day total right.
- **Rows:** InkWell + dividers; 40dp category circles, outlined icons.

## Implementation

- Palette: [`lib/app_theme.dart`](lib/app_theme.dart) — `AppPalette`, `AppTheme.light`.
- UI: [`lib/stitch_app.dart`](lib/stitch_app.dart).
