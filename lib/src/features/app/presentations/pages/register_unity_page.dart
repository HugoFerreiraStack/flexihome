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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      IconButton(onPressed: () => Get.back(), icon: Icon(Icons.chevron_left_rounded, color: Colors.white,)),
                      Text(
                        'Cadastrar Unidade',
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          decorationColor: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                RegisterUnityForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
