import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexihome/src/config/routes/app_pages.dart';
import 'package:flexihome/src/core/services/auth/auth_service.dart';
import 'package:flexihome/src/features/app/domain/entities/host.dart';
import 'package:flexihome/src/features/login/domain/usecases/login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  LoginController({required this.loginUsecase});

  final LoginUsecase loginUsecase;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _rememberMe = false.obs;
  bool get rememberMe => _rememberMe.value;
  set rememberMe(bool value) => _rememberMe.value = value;

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;

    User? user = await AuthService.to.signInWithEmailAndPassword(
      email,
      password,
    );

    if (user != null) {
      AuthService.to.host = await getUserData(user.uid).then((value) {
        Get.offAllNamed(AppRoutes.APP);
        return null;
      });
    }
  }

  Future<Host> getUserData(String id) async {
    final response = await loginUsecase.execute(id);

    return response.fold(
      (l) {
        log('Error: $l');
        throw Exception('Failed to get user data');
      },
      (r) {
        log('Success: ${r.toJson()}');
        AuthService.to.host = r;
        return r;
      },
    );
  }

  void checkStateUser() {
    AuthService.to.checkStateUser();
  }

  @override
  void onInit() {
    checkStateUser();
    super.onInit();
  }
}
