import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
}
