import 'package:brasil_fields/brasil_fields.dart';
import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/presentations/controllers/condominium_controller.dart';
import 'package:flexihome/src/features/app/presentations/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DetailsCondominiumPage extends GetView<CondominiumController> {
  const DetailsCondominiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
            "Condomínio: ${controller.condominium.name}"),
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
          child:  SafeArea(
            child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                      child: Column(
                        spacing: 18,
                        children: [
                          // Image.asset(
                          //   'assets/icons/condominio.png', height: 150,
                          // ),
                          TextFormField(
                            initialValue: controller.condominium.cep,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CepInputFormatter()
                            ],
                            decoration: InputDecoration(
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
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue: controller.condominium.logradouro,
                            decoration: InputDecoration(
                              labelText: 'Logradouro',
                              hintText: 'Nome da rua',
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
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue: controller.condominium.bairro,
                            decoration: InputDecoration(
                              labelText: 'Bairro',
                              hintText: 'Nome do bairro',
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
                          ),
                          TextFormField(
                            initialValue: controller.condominium.cidade,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Cidade',
                              hintText: 'Nome da cidade',
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
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  initialValue: controller.condominium.estado,
                                  readOnly: true,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelText: 'UF',
                                    hintText: 'Sigla do estado',
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
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                  initialValue: controller.condominium.numero,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: 'Numero na rua',
                                    hintText: 'Numero do condomínio na rua',
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
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            initialValue: controller.condominium.complemento,
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Complemento',
                              hintText: 'Ex: Bloco A',
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
                          ),
                          CustomButton(
                            buttonType: ButtonType.secondary,
                            textButton: 'Unidades do condomínio',
                            function:  () => controller.getUnitysByIdCondominium()),
                          CustomButton(
                            buttonType: ButtonType.primary,
                            textButton: 'Deletar condomínio',
                            function:  () {
                              Get.defaultDialog(
                                title: 'Excluir',
                                middleText: 'Você tem certeza que deseja excluir este condomínio?',
                                textCancel: 'Não',
                                textConfirm: 'Sim',
                                buttonColor: AppColors.primary,
                                cancelTextColor: Colors.red,
                                onCancel: () {},
                                onConfirm: () => controller.deleteCondominium(controller.condominium)
                              );
                            })
                        ],
                      ),
                    ),
                    ),
          ),
      ),
    );
  }
}
