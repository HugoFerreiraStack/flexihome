import 'package:flutter/material.dart';

class ResponsiveHelper {
  final BuildContext context;

  ResponsiveHelper(this.context);
  // Obter largura da tela
  double get screenWidth => MediaQuery.of(context).size.width;

  // Obter altura da tela
  double get screenHeight => MediaQuery.of(context).size.height;

  // Breakpoints para diferentes tipos de tela
  bool get isWide =>
      screenWidth >= 1920 ||
      screenWidth > 1025; // Largura maior ou igual a 1920px
  bool get isWeb => screenWidth == 1024 || screenWidth < 1919;

  bool get isTablet =>
      screenWidth >= 601 && screenWidth < 1023; // Largura entre 600px e 1023px
  bool get isMobile => screenWidth < 600; // Largura menor que 600px
  // Largura entre 1025px e 1440px

  double get responsivePaddingForm {
    if (isMobile) {
      return 16.0;
    } else if (isTablet) {
      return 200;
    } else if (isWeb) {
      return 700;
    } else if (isWide) {
      return 800;
    } else {
      return 16.0;
    }
  }
}
