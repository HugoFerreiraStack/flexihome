import 'package:flexihome/src/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

    final formkey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final cepController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  void buttonLogout(){
    AuthService.to.signOut();
  }

  @override
  void onInit() {
    super.onInit();
    // generateButtons();
  }
}
