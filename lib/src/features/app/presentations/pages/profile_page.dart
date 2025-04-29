import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/presentations/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: Get.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            AppColors.tertiary,
            AppColors.primary,
            AppColors.secondary
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botão central
                Center(
                  child: Column(
                    children: controller.buttons
                        .map((b) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: b,
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
