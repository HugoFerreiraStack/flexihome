import 'package:flexihome/src/config/themes/app_assets.dart';
import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/splash/presentations/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
gradient: LinearGradient(colors: [AppColors.tertiary,AppColors.primary, AppColors.secondary],begin: Alignment.bottomLeft, end: Alignment.topRight)        ),
        child: Center(
          child: FadeTransition(
            opacity: controller.animation!,
            child: Image.asset(AppAssets.splash),
          ),
        ),
      ),
    );
  }
}
