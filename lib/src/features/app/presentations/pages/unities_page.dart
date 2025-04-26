import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/presentations/controllers/register_unity_controller.dart';
import 'package:flexihome/src/features/app/presentations/pages/register_unity_page.dart';
import 'package:flexihome/src/features/app/presentations/widgets/card_unity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnitiesPage extends GetView<RegisterUnityController> {
  const UnitiesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
          onPressed: () {
            controller.getCondominiums();
            Get.to(RegisterUnityPage());
          },
          onLongPress: () => Get.snackbar('Botão', 'Adicionar Unidade',
              snackPosition: SnackPosition.BOTTOM),
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.all(24)),
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:  16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text(
                    'Unidades',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      decorationColor: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: TextFormField(
                    controller: controller.searchController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Procure uma unidade',
                      hintText: 'Digite o nome da unidade',
                      hintStyle: TextStyle(color: AppColors.flexGrey),
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a unidade';
                      }
                      return null;
                    },
                    // FUNC GET UNIDADE
                    onChanged: null,
                  ),
                ),
                // lista unidades
                Obx(() => Expanded(
                  child: ListView.builder(
                      itemCount: controller.unitys.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return CardUnity(title: controller.unitys[index].endereco?.logradouro,);
                      },
                    ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
