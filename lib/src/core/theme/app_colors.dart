import 'package:flutter/material.dart';

class AppColors {
  // Cores principais
  static const Color primary = Color(0xFF6200EE);
  static const Color primaryVariant = Color(0xFF3700B3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryVariant = Color(0xFF018786);
  static const Color backgroundDarkCard = Color(0x1FFFFFFF);

  // Cores de fundo e superfície
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);

  // Cores de feedback (erro, sucesso, aviso, neutro)
  static const Color error = Color(0xFFB00020);
  static const Color success = Color.fromARGB(255, 114, 255, 114);
  static const Color danger = Color.fromARGB(255, 255, 86, 86);
  static const Color warning = Color.fromARGB(255, 255, 229, 84);
  static const Color neutral = Color(0xFF848484);
  static const Color shade = Color.fromRGBO(238, 238, 238, 1);

  // Cores de texto e ícones
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF000000);
  static const Color onBackground = Color(0xFF000000);
  static const Color onSurface = Color(0xFF000000);
  static const Color onError = Color(0xFFFFFFFF);
}
