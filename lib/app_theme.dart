import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  /// Warm bone surfaces + pink accent (Entries reference / TravelSpend-like).
  static ThemeData get light {
    const accentPink = Color(0xFFE91E63);
    const surfaceWarm = Color(0xFFF7F4EF);
    const surfaceNav = Color(0xFFF0E8E6);
    const surfaceBand = Color(0xFFEAE6DF);
    const onSurfaceMain = Color(0xFF1A1A1A);
    const onSurfaceMuted = Color(0xFF6B6B6B);

    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: accentPink,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFFCE4EC),
      onPrimaryContainer: Color(0xFF880E4F),
      secondary: Color(0xFF5C5C5C),
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFE8E8E8),
      onSecondaryContainer: Color(0xFF2C2C2C),
      tertiary: Color(0xFF6D6D6D),
      onTertiary: Colors.white,
      tertiaryContainer: surfaceBand,
      onTertiaryContainer: onSurfaceMain,
      error: Color(0xFFBA1A1A),
      onError: Colors.white,
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF93000A),
      surface: surfaceWarm,
      onSurface: onSurfaceMain,
      onSurfaceVariant: onSurfaceMuted,
      outline: Color(0xFFBDB5AD),
      outlineVariant: Color(0xFFE0D8CE),
      shadow: Color(0x1A000000),
      scrim: Color(0x66000000),
      inverseSurface: Color(0xFF2C2C2C),
      onInverseSurface: Color(0xFFF5F5F5),
      inversePrimary: Color(0xFFF48FB1),
      surfaceTint: Colors.transparent,
      surfaceDim: Color(0xFFE8E0D8),
      surfaceBright: Color(0xFFFCFAF6),
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: Color(0xFFF2EDE6),
      surfaceContainer: Color(0xFFEDE7DF),
      surfaceContainerHigh: surfaceBand,
      surfaceContainerHighest: Color(0xFFDED8CF),
      primaryFixed: Color(0xFFFCE4EC),
      primaryFixedDim: Color(0xFFF8BBD0),
      onPrimaryFixed: Color(0xFF4A0020),
      onPrimaryFixedVariant: Color(0xFFAD1457),
      secondaryFixed: Color(0xFFE0E0E0),
      secondaryFixedDim: Color(0xFFBDBDBD),
      onSecondaryFixed: Color(0xFF1A1A1A),
      onSecondaryFixedVariant: Color(0xFF424242),
      tertiaryFixed: surfaceBand,
      tertiaryFixedDim: Color(0xFFD7D0C6),
      onTertiaryFixed: onSurfaceMain,
      onTertiaryFixedVariant: onSurfaceMuted,
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
        backgroundColor: surfaceNav,
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
