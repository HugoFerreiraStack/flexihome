import 'package:brasil_fields/brasil_fields.dart';
import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/presentations/controllers/unity_controller.dart';
import 'package:flexihome/src/features/app/presentations/widgets/custom_buttons.dart';
import 'package:flexihome/src/features/app/presentations/widgets/upcoming_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DetailsUnity extends GetView<UnityController> {
  const DetailsUnity({super.key});

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
          "Unidade: ${controller.unity.name}"),
            // "${controller.unity.endereco!.logradouro!} ${controller.unity.numberAp!}"),
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
            child: SingleChildScrollView(
             child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Column(
                spacing: 18,
                children: [
                  TextFormField(
                    initialValue: controller.unity.endereco!.cep,
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
                    initialValue: controller.unity.endereco!.logradouro,
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
                    initialValue: controller.unity.endereco!.bairro,
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
                    initialValue: controller.unity.endereco!.cidade,
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
                          initialValue: controller.unity.endereco!.estado,
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
                          initialValue: controller.unity.numberAp,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Numero',
                            hintText: 'Numero da unidade',
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
                    initialValue: controller.unity.endereco!.complemento,
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Apartamento',
                      hintText: 'Numero do Apartamento',
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
                    buttonType: ButtonType.tertiary,
                    textButton: 'Adicionar agendamento',
                    function:  () => controller.createEvent(controller.unity)),
                  // TODO ADICIONAR INVENTÁRIO
                  CustomButton(
                    // TODO QUANDO CRIAR O INVENTÁRIO, TROCAR O TYPE PARA SECONDARY
                    buttonType: ButtonType.custom,
                    textButton: 'Adicionar inventário',
                    function:  () => Get.snackbar('NÃO SE PREOCUPE 🚧', 'Estamos desenvolvendo isto, em breve estará disponível!', backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM)),
                  CustomButton(
                    buttonType: ButtonType.primary,
                    textButton: 'Deletar unidade',
                    function:  () {
                              Get.defaultDialog(
                                title: 'Excluir',
                                middleText: 'Você tem certeza que deseja excluir esta unidade?',
                                textCancel: 'Não',
                                textConfirm: 'Sim',
                                buttonColor: AppColors.primary,
                                cancelTextColor: Colors.red,
                                onCancel: () {},
                                onConfirm: () => controller.deleteUnity(controller.unity),
                              );
                            }
                  )      
                  // TODO AINDA NÃO ESTÁ CARREGANDO NENHUM AGENDAMENTO PRÓXIMO
                  // SizedBox(
                  //     height: 50,
                  //     child:
                  //         UpcomingEventsList(events: controller.unity.eventos ?? []))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
