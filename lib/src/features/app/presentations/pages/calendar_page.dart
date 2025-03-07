import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/presentations/controllers/app_controller.dart';
import 'package:flexihome/src/features/app/presentations/controllers/register_condominium_controller.dart';
import 'package:flexihome/src/features/app/presentations/pages/register_condominium_page.dart';
import 'package:flexihome/src/features/app/presentations/widgets/card_condominium.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarPage extends GetView<AppController> {
  const CalendarPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () => Get.to(RegisterCondominiumPage()),
        onLongPress: () => Get.snackbar('Botão', 'Adicionar Condomínio', snackPosition: SnackPosition.BOTTOM),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.all(24)),
        child: Icon(Icons.add, color: Colors.white,)),
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
                  child: Text(
                    'Condomínios',
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      decorationColor: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
