import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF006767),
      brightness: Brightness.light,
    ).copyWith(
      primary: const Color(0xFF006767),
      onPrimary: const Color(0xFFFFFFFF),
      primaryContainer: const Color(0xFF1D8181),
      onPrimaryContainer: const Color(0xFFF3FFFE),
      secondary: const Color(0xFF505F76),
      onSecondary: const Color(0xFFFFFFFF),
      secondaryContainer: const Color(0xFFD0E1FB),
      onSecondaryContainer: const Color(0xFF54647A),
      tertiary: const Color(0xFF565D63),
      onTertiary: const Color(0xFFFFFFFF),
      tertiaryContainer: const Color(0xFF6F757C),
      onTertiaryContainer: const Color(0xFFFCFCFF),
      error: const Color(0xFFBA1A1A),
      onError: const Color(0xFFFFFFFF),
      errorContainer: const Color(0xFFFFDAD6),
      onErrorContainer: const Color(0xFF93000A),
      surface: const Color(0xFFFAF8FF),
      onSurface: const Color(0xFF131B2E),
      onSurfaceVariant: const Color(0xFF3E4948),
      outline: const Color(0xFF6E7979),
      outlineVariant: const Color(0xFFBDC9C8),
      shadow: const Color(0x14006767),
      scrim: const Color(0x66000000),
      inverseSurface: const Color(0xFF283044),
      onInverseSurface: const Color(0xFFEEF0FF),
      inversePrimary: const Color(0xFF7DD5D4),
      surfaceTint: const Color(0xFF006A6A),
      // New Material 3 tonal surfaces from DESIGN.md
      surfaceDim: const Color(0xFFD2D9F4),
      surfaceBright: const Color(0xFFFAF8FF),
      surfaceContainerLowest: const Color(0xFFFFFFFF),
      surfaceContainerLow: const Color(0xFFF2F3FF),
      surfaceContainer: const Color(0xFFEAEDFF),
      surfaceContainerHigh: const Color(0xFFE2E7FF),
      surfaceContainerHighest: const Color(0xFFDAE2FD),
      // Fixed colors from DESIGN.md
      primaryFixed: const Color(0xFF99F1F1),
      primaryFixedDim: const Color(0xFF7DD5D4),
      onPrimaryFixed: const Color(0xFF002020),
      onPrimaryFixedVariant: const Color(0xFF004F50),
      secondaryFixed: const Color(0xFFD3E4FE),
      secondaryFixedDim: const Color(0xFFB7C8E1),
      onSecondaryFixed: const Color(0xFF0B1C30),
      onSecondaryFixedVariant: const Color(0xFF38485D),
      tertiaryFixed: const Color(0xFFDDE3EB),
      tertiaryFixedDim: const Color(0xFFC1C7CF),
      onTertiaryFixed: const Color(0xFF161C22),
      onTertiaryFixedVariant: const Color(0xFF41474E),
    );

    final baseTextTheme = ThemeData(brightness: Brightness.light).textTheme;
    final textTheme = GoogleFonts.plusJakartaSansTextTheme(baseTextTheme)
        .copyWith(
      // display-currency
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        height: 44 / 36,
        letterSpacing: -0.72, // -0.02em
      ),
      // h1
      headlineLarge: GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 32 / 24,
        letterSpacing: -0.24, // -0.01em
      ),
      // h2
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 28 / 20,
      ),
      // body-lg
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
      ),
      // body-md
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
      ),
      // label-caps
      labelSmall: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 16 / 12,
        letterSpacing: 0.6, // 0.05em
      ),
      // data-tabular
      titleSmall: GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 20 / 15,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );

    final rounded16 = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      textTheme: textTheme,
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLowest,
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
