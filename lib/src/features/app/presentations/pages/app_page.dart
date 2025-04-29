import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/presentations/controllers/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class AppPage extends GetView<AppController> {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex,
          children: controller.pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: controller.bottomNavitems,
          currentIndex: controller.currentIndex,
          selectedItemColor: AppColors.secondary,
          unselectedItemColor: AppColors.flexGrey,
          onTap: (value) {
            controller.currentIndex = value;
          },
        ),
      ),
    );
  }
}
