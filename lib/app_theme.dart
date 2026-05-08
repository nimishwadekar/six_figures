// Defines the application's visual identity: the AppPalette colour tokens
// and the Material 3 ThemeData (colour scheme, typography, component
// themes) consumed by MaterialApp.

import 'package:flutter/material.dart';

/// Canonical colours for Six Figures. Extend here as the palette grows.
abstract final class AppPalette {
  AppPalette._();

  /// BG1 — cards, list rows, FAB surface, dialogs.
  static const Color bg1 = Color(0xFFFFFFFF);

  /// BG2 — page / scaffold / app bar.
  static const Color bg2 = Color(0xFFF7F6F3);

  /// BG3 — bottom navigation, muted chips on cards.
  static const Color bg3 = Color(0xFFEBE7E4);

  static const Color primary = Color(0xFFE91E63);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFFCE4EC);
  static const Color onPrimaryContainer = Color(0xFF880E4F);
  static const Color primaryFixedDim = Color(0xFFF8BBD0);
  static const Color onPrimaryFixed = Color(0xFF4A0020);
  static const Color onPrimaryFixedVariant = Color(0xFFAD1457);

  static const Color onSurface = Color(0xFF1A1A1A);
  static const Color onSurfaceVariant = Color(0xFF6B6B6B);

  static const Color secondary = Color(0xFF5C5C5C);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF2C2C2C);

  static const Color tertiary = Color(0xFF6D6D6D);
  static const Color onTertiary = Color(0xFFFFFFFF);

  static const Color outline = Color(0xFFBDB5AD);
  static const Color outlineVariant = Color(0xFFE0D8CE);

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

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
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
      tertiaryContainer: AppPalette.bg2,
      onTertiaryContainer: AppPalette.onSurface,
      error: AppPalette.error,
      onError: AppPalette.onError,
      errorContainer: AppPalette.errorContainer,
      onErrorContainer: AppPalette.onErrorContainer,
      surface: AppPalette.bg2,
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

    final baseTextTheme = ThemeData(brightness: Brightness.light).textTheme;
    final textTheme = baseTextTheme.copyWith(
      displayLarge: baseTextTheme.displayLarge?.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.35,
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.35,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      labelSmall: baseTextTheme.labelSmall?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.8,
        height: 1.33,
      ),
      titleSmall: baseTextTheme.titleSmall?.copyWith(
        fontSize: 15,
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
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: colorScheme.surface,
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
        height: 72,
        backgroundColor: AppPalette.bg3,
        indicatorColor: colorScheme.primary.withValues(alpha: 0.18),
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelSmall?.copyWith(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? colorScheme.primary : colorScheme.onSurface,
            size: 24,
          );
        }),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.surfaceContainerLowest,
        foregroundColor: colorScheme.primary,
        elevation: 3,
        shape: const CircleBorder(),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withValues(alpha: 0.7),
        thickness: 1,
        space: 1,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shape: rounded16,
        elevation: 0,
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
