import 'package:brasil_fields/brasil_fields.dart';
import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/presentations/controllers/unity_controller.dart';
import 'package:flexihome/src/features/app/presentations/widgets/upcoming_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DetailsUnity extends GetView<UnityController> {
  const DetailsUnity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
            "${controller.unity.endereco!.logradouro!} ${controller.unity.numberAp!}"),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Column(
                spacing: 18,
                children: [
                  SizedBox(
                    height: 20,
                  ),
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
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.createEvent(controller.unity),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      child: Text(
                        'Adicionar agendamento',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.deleteUnity(controller.unity),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      child: Text(
                        'Deletar unidade',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 200,
                      child:
                          UpcomingEventsList(events: controller.unity.eventos!))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
