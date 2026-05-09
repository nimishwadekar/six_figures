// Defines the application's visual identity: the AppPalette colour tokens
// and the Material 3 ThemeData (colour scheme, typography, component
// themes) consumed by MaterialApp.

import 'package:flutter/material.dart';

/// Canonical colours for Six Figures. Extend here as the palette grows.
abstract final class AppPalette {
  AppPalette._();

  // —— Midnight Sapphire (Serene Ledger) ——
  static const Color midnightBackground = Color(0xFF0F172A);
  static const Color midnightGlassFill = Color(0xCC1E293B); // #1E293B @ 80%
  static const Color midnightSurfaceBorder = Color(0xFF334155);
  static const Color sapphireAccent = Color(0xFF3B82F6);

  /// BG1 — cards, list rows, elevated surfaces on dark scaffold.
  static const Color bg1 = Color(0xFF111C38);

  /// BG2 — grouped list backdrop behind bordered cards.
  static const Color bg2 = Color(0xFF0F172A);

  /// BG3 — bottom navigation bar.
  static const Color bg3 = Color(0xFF161F35);

  static const Color primary = sapphireAccent;
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF1E3A5F);
  static const Color onPrimaryContainer = Color(0xFFBFDBFE);
  static const Color primaryFixedDim = Color(0xFF334155);
  static const Color onPrimaryFixed = Color(0xFFFFFFFF);
  static const Color onPrimaryFixedVariant = Color(0xFFB3CFFF);

  static const Color onSurface = Color(0xFFFFFFFF);
  static const Color onSurfaceMuted = Color(0xB3FFFFFF); // white70

  static const Color onSurfaceVariant = Color(0xB3FFFFFF);
  static const Color secondary = Color(0xFF94A3B8);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFFB3CFFF);

  static const Color tertiary = Color(0xFF64748B);
  static const Color onTertiary = Color(0xFFFFFFFF);

  static const Color outline = midnightSurfaceBorder;
  static const Color outlineVariant = midnightSurfaceBorder;

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  static const Color inverseSurface = Color(0xFF2C2C2C);
  static const Color onInverseSurface = Color(0xFFF5F5F5);
  static const Color inversePrimary = Color(0xFFF48FB1);

  static const Color shadow = Color(0x1A000000);
  static const Color scrim = Color(0x66000000);

  // —— Category icon disks (entries & pickers) ——
  static const Color categoryTransport = Color(0xFFE65100);
  static const Color categoryFood = Color(0xFF00897B);
  static const Color categoryDrinks = Color(0xFF1E88E5);
  static const Color categoryShopping = Color(0xFF2E7D32);
  static const Color categoryFun = Color(0xFF5C6BC0);
  static const Color categoryHealth = Color(0xFFC62828);
  static const Color categoryUtilities = Color(0xFFFFB300);
  static const Color categoryHousing = Color(0xFF6D4C41);
  static const Color categoryUnknown = Color(0xFFB0BEC5);
}

/// Centralized UI scaling controls.
///
/// Tweak these values from code to make the entire app's typography and
/// component sizing larger/smaller without touching each widget.
abstract final class AppUiScale {
  AppUiScale._();

  /// Multiplies text sizes defined in [AppTheme].
  static const double text = 1.0;

  /// Multiplies common component sizes (heights, icon sizes, radii, spacing).
  static const double element = 0.9;

}

class AppTheme {
  AppTheme._();

  static ThemeData get light => midnightSapphire;

  static double _ts(double value) => value * AppUiScale.text;
  static double _es(double value) => value * AppUiScale.element;

  static ThemeData get midnightSapphire {
    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppPalette.primary,
      onPrimary: AppPalette.onPrimary,
      primaryContainer: AppPalette.primaryContainer,
      onPrimaryContainer: AppPalette.onPrimaryContainer,
      secondary: AppPalette.secondary,
      onSecondary: AppPalette.onSecondary,
      secondaryContainer: AppPalette.bg3,
      onSecondaryContainer: AppPalette.onSecondaryContainer,
      tertiary: AppPalette.tertiary,
      onTertiary: AppPalette.onTertiary,
      tertiaryContainer: AppPalette.bg1,
      onTertiaryContainer: AppPalette.onSurface,
      error: AppPalette.error,
      onError: AppPalette.onError,
      errorContainer: AppPalette.errorContainer,
      onErrorContainer: AppPalette.onErrorContainer,
      surface: AppPalette.midnightBackground,
      onSurface: AppPalette.onSurface,
      onSurfaceVariant: AppPalette.onSurfaceVariant,
      outline: AppPalette.outline,
      outlineVariant: AppPalette.outlineVariant,
      shadow: AppPalette.shadow,
      scrim: AppPalette.scrim,
      inverseSurface: AppPalette.inverseSurface,
      onInverseSurface: AppPalette.onInverseSurface,
      inversePrimary: AppPalette.inversePrimary,
      surfaceTint: Colors.transparent,
      surfaceDim: AppPalette.bg3,
      surfaceBright: AppPalette.bg1,
      surfaceContainerLowest: AppPalette.bg1,
      surfaceContainerLow: AppPalette.bg3,
      surfaceContainer: AppPalette.bg3,
      surfaceContainerHigh: AppPalette.bg3,
      surfaceContainerHighest: AppPalette.bg3,
      primaryFixed: AppPalette.primaryContainer,
      primaryFixedDim: AppPalette.primaryFixedDim,
      onPrimaryFixed: AppPalette.onPrimaryFixed,
      onPrimaryFixedVariant: AppPalette.onPrimaryFixedVariant,
      secondaryFixed: AppPalette.bg3,
      secondaryFixedDim: AppPalette.outlineVariant,
      onSecondaryFixed: AppPalette.onSurface,
      onSecondaryFixedVariant: AppPalette.onSurfaceVariant,
      tertiaryFixed: AppPalette.bg2,
      tertiaryFixedDim: AppPalette.bg3,
      onTertiaryFixed: AppPalette.onSurface,
      onTertiaryFixedVariant: AppPalette.onSurfaceVariant,
    );

    final baseTextTheme = ThemeData(
      brightness: Brightness.dark,
    ).textTheme.apply(
          bodyColor: AppPalette.onSurface,
          displayColor: AppPalette.onSurface,
        );
    final textTheme = baseTextTheme.copyWith(
      displayLarge: baseTextTheme.displayLarge?.copyWith(
        fontSize: _ts(28),
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(
        fontSize: _ts(21),
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        fontSize: _ts(18),
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        fontSize: _ts(17),
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        fontSize: _ts(14),
        fontWeight: FontWeight.w400,
        height: 1.35,
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        fontSize: _ts(13),
        fontWeight: FontWeight.w400,
        height: 1.35,
      ),
      bodySmall: baseTextTheme.bodySmall?.copyWith(
        fontSize: _ts(12),
        fontWeight: FontWeight.w400,
        height: 1.35,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        fontSize: _ts(14),
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      labelSmall: baseTextTheme.labelSmall?.copyWith(
        fontSize: _ts(11),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.8,
        height: 1.33,
      ),
      titleSmall: baseTextTheme.titleSmall?.copyWith(
        fontSize: _ts(13),
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
    );

    final rounded16 = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: AppPalette.midnightBackground,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: AppPalette.midnightBackground,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.headlineMedium?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        height: _es(72),
        backgroundColor: AppPalette.bg3,
        surfaceTintColor: Colors.transparent,
        indicatorColor: colorScheme.primary.withValues(alpha: 0.18),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelSmall?.copyWith(
            fontSize: _ts(11),
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? colorScheme.primary : colorScheme.secondary,
            size: _es(22),
          );
        }),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppPalette.sapphireAccent,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_es(28))),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withValues(alpha: 0.7),
        thickness: 1,
        space: 1,
      ),
      cardTheme: CardThemeData(
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: rounded16,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      buttonTheme: ButtonThemeData(
        shape: rounded16,
        buttonColor: colorScheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(44, 44),
          shape: rounded16,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(44, 44),
          shape: rounded16,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(44, 44),
          shape: rounded16,
        ),
      ),
    );
  }
}
