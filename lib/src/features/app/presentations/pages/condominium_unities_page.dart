import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/presentations/controllers/condominium_unity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CondominiumUnitiesPage extends GetView<CondominiumUnityController> {
  const CondominiumUnitiesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
            ),
          title: Text(
            // TODO PASSAR O NOME DO CONDOMINIO
            "Unidades do ${'\$NOMECONDOMIONIO'}}"),
      ),
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                    // TODO CRIAR CONTROLLER APENAS PARA BUSCAR UNIDADES DESTE CONDOMÍNIO ESPECÍFICO 
                    // controller: controller.searchController,
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
                        // itemCount: controller.unitys.length,
                        itemCount: 1,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          // TODO ALTERAR PARA BUSCAR UNIDADES ESPECÍFICAS DO CONDOMINIO
                          return Text('BUSCAR UNIDADES DO CONDOMINIO');
                          // return CardUnity(
                          //   unity: controller.unitys[index],
                          // );
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
