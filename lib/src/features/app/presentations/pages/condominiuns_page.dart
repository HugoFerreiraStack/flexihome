import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/presentations/controllers/register_condominium_controller.dart';
import 'package:flexihome/src/features/app/presentations/pages/register_condominium_page.dart';
import 'package:flexihome/src/features/app/presentations/widgets/card_condominium.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CondominiunsPage extends GetView<RegisterCondominiumController> {
  const CondominiunsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
          onPressed: () => Get.to(RegisterCondominiumPage()),
          onLongPress: () => Get.snackbar('Botão', 'Adicionar Condomínio',
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
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text(
                    'Condomínios',
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
                    controller: null,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Procure um condomínio',
                      hintText: 'Digite o nome do condomínio',
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
                // todo lista condominios
                Obx(() => Expanded(
                  child: ListView.builder(
                      itemCount: controller.condominiums.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CardCondominium(
                          title: controller.condominiums[index].name,
                          address: controller.condominiums[index].endereco?.logradouro,  
                        );
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
