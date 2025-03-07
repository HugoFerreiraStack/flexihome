import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/presentations/controllers/register_condominium_controller.dart';
import 'package:flexihome/src/features/app/presentations/widgets/register_condominio_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterCondominiumPage extends GetView<RegisterCondominiumController> {
  const RegisterCondominiumPage({super.key});

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
          child: Column(
            children: [
          Row(
            children: [
              IconButton(onPressed: () => Get.back(), icon: Icon(Icons.chevron_left_rounded, color: Colors.white,)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Cadastrar Condomínio',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
              RegisterCondominioForm(),
            ],
          ),
        ),
      ),
    );
  }
}
