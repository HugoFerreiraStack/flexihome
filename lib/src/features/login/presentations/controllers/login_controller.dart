import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexihome/src/config/routes/app_pages.dart';
import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/core/services/auth/auth_service.dart';
import 'package:flexihome/src/features/app/domain/entities/host.dart';
import 'package:flexihome/src/features/login/domain/usecases/login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  LoginController({required this.loginUsecase});

  final GetStorage storage = GetStorage();
  final LoginUsecase loginUsecase;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _rememberMe = true.obs;
  bool get rememberMe => _rememberMe.value;
  set rememberMe(bool value) => _rememberMe.value = value;

  Future<void> resetPassword() async {
    if (emailController.text.isEmpty) {
      Get.snackbar(
          'Atenção', 'Digite seu e-mail para enviar a recuperação de senha',
          colorText: Colors.white,
          backgroundColor: AppColors.primary,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
      return;
    }
    if (!emailController.text.isEmail) {
      Get.snackbar('Atenção', 'Digite um e-mail válido',
          colorText: Colors.white,
          backgroundColor: AppColors.primary,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
      return;
    }
    if (emailController.text.length < 5) {
      Get.snackbar('Atenção', 'Digite um e-mail válido',
          colorText: Colors.white,
          backgroundColor: AppColors.primary,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
      return;
    }
    if (!emailController.text.contains('@')) {
      Get.snackbar('Atenção', 'Digite um e-mail válido',
          colorText: Colors.white,
          backgroundColor: AppColors.primary,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
      return;
    }
    if (!emailController.text.contains('.')) {
      Get.snackbar('Atenção', 'Digite um e-mail válido',
          colorText: Colors.white,
          backgroundColor: AppColors.primary,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
      return;
    }

    Get.snackbar('Email enviado para ', emailController.text.toLowerCase(),
        colorText: Colors.white,
        backgroundColor: AppColors.primary,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3));
    AuthService().sendPasswordResetEmail(emailController.text.trim());
  }

  void setRememberMe(bool value) => storage.write('rememberMe', rememberMe);
  bool? getRememberMe() =>
      (storage.read('rememberMe') != null) ? storage.read('rememberMe') : null;

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;
    if (rememberMe) {
      storage.write('rememberMe', rememberMe);
    }

    User? user = await AuthService.to.signInWithEmailAndPassword(
      email,
      password,
    );

    if (user != null) {
      AuthService.to.host = await getUserData(user.uid).then((value) {
        log('User data: ${AuthService.to.host?.toJson()}');
        if (value.blocked == true) {
          Get.snackbar('Atenção', 'Usuário bloqueado',
              colorText: Colors.white,
              backgroundColor: AppColors.primary,
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 3));
          return null;
        }
        Get.offAllNamed(AppRoutes.APP);
        return null;
      });
    } else {
      Get.snackbar('Atenção', 'Usuário ou senha inválidos',
          colorText: Colors.white,
          backgroundColor: AppColors.primary,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
    }
  }

  Future<UserApp> getUserData(String id) async {
    final response = await loginUsecase.execute(id);

    return response.fold(
      (l) {
        log('Error: $l');
        throw Exception('Failed to get user data');
      },
      (r) {

        AuthService.to.host = r;
        log('User data: ${AuthService.to.host?.toJson()}');
        return r;
      },
    );
  }
}
