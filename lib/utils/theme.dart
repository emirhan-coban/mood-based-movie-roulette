import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Renk Paleti (Sinematik Koyu Tema)
  static const Color _backgroundColor = Color.fromARGB(255, 14, 15, 20); // Çok koyu gri/siyah
  static const Color _surfaceColor = Color(0xFF1E1F25);    // Kartlar ve TextFieldlar için
  static const Color _primaryColor = Color(0xFF6C63FF);    // Vurgu rengi (Modern Mor)
  static const Color _accentColor = Color(0xFFFFD700);     // Altın sarısı (Yıldızlar/Puanlar için)
  static const Color _textColor = Colors.white;

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: _primaryColor,
      
      // Font Yapılandırması (Poppins)
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: _textColor),
          displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: _textColor),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: _textColor),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ),

      // TextField Tasarımı (Günlük Yazma Alanı)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surfaceColor,
        hintStyle: const TextStyle(color: Colors.white38),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _primaryColor, width: 2),
        ),
      ),

      // Buton Tasarımı
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),

      // Kart Tasarımı (Film Sonuçları İçin)
      cardTheme: CardThemeData(
        color: _surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8,
      ),
    );
  }
}