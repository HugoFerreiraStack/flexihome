import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/presentations/controllers/register_unity_controller.dart';
import 'package:flexihome/src/features/app/presentations/widgets/register_unity_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterUnityPage extends GetView<RegisterUnityController> {
  const RegisterUnityPage({super.key});

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
        ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                          controller.condominiums.clear();
                          controller.clearFields();
                          controller.selectedCondominium = null;
                        },
                        icon: Icon(
                          Icons.chevron_left_rounded,
                          color: Colors.white,
                        )),
                    Text(
                      'Cadastrar Unidade',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        decorationColor: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  16.0),
                    child: Column(
                      children: [
                        Image.asset(
                              'assets/icons/unidade.png', height: 150,
                            ), 
                        RegisterUnityForm(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
