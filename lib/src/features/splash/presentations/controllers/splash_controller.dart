import 'package:flexihome/src/config/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static SplashController get to => Get.find();

  AnimationController? animationController;
  Animation<double>? animation;

  void startAnimation() {
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeIn,
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
      //  Get.offNamed(AppRoutes.LOGIN);
      }
    });
    animationController!.forward();
  }

  @override
  void onInit() {
    startAnimation();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  //  Get.offNamed(AppRoutes.LOGIN);
  }

  @override
  void onClose() {
    animationController?.dispose();
    super.onClose();
  }
}
