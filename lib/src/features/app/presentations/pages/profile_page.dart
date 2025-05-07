import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/presentations/controllers/profile_controller.dart';
import 'package:flexihome/src/features/app/presentations/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: Get.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            AppColors.tertiary,
            AppColors.primary,
            AppColors.secondary
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      'Perfil',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        decorationColor: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),    
                // TODO AJUSTAR FORMULÁRIO DA IMOBILIÁRIA           
                Form(
                  key: controller.formkey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      spacing: 18,
                      children: [
                        TextFormField(
                          readOnly: true,
                          enabled: false,
                          controller: controller.nameController,
                          keyboardType: TextInputType.name,
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            labelText: 'IMOBILIÁRIA',
                            hintText: 'IMOBILIÁRIA',
                            hintStyle: TextStyle(color: AppColors.flexGrey),
                            labelStyle: TextStyle(color: AppColors.flexGrey),
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
                              return 'Por favor, insira o nome';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          readOnly: true,
                          enabled: false,
                          controller: controller.cepController,
                          keyboardType: TextInputType.number,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly,
                          //   CepInputFormatter()
                          // ],
                          decoration: InputDecoration(
                            labelText: 'E-MAIL',
                            hintText: 'E-mail',
                            hintStyle: TextStyle(color: AppColors.flexGrey),
                            labelStyle: TextStyle(color:  AppColors.flexGrey),
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
                          // focusNode: controller.cepFocus,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o CEP';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          readOnly: true,
                          enabled: false,
                          controller: controller.streetController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'Contato',
                            hintText: 'Nome da rua',
                            hintStyle: TextStyle(color: AppColors.flexGrey),
                            labelStyle: TextStyle(color: AppColors.flexGrey),
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
                              return 'Por favor, insira o nome da rua';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          readOnly: true,
                          enabled: false,
                          controller: controller.neighborhoodController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'Contato Secundário',
                            hintText: 'Nome do bairro',
                            hintStyle: TextStyle(color: AppColors.flexGrey),
                            labelStyle: TextStyle(color: AppColors.flexGrey),
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
                              return 'Por favor, insira o nome do bairro';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          readOnly: true,
                          enabled: false, 
                          controller: controller.cityController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'CNPJ',
                            hintText: 'Nome da cidade',
                            hintStyle: TextStyle(color: AppColors.flexGrey),
                            labelStyle: TextStyle(color: AppColors.flexGrey),
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
                              return 'Por favor, insira o nome da cidade';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          readOnly: true,
                          enabled: false, 
                          controller: controller.stateController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'RAZÃO SOCIAL',
                            hintText: 'Sigla do estado',
                            hintStyle: TextStyle(color: AppColors.flexGrey),
                            labelStyle: TextStyle(color: AppColors.flexGrey),
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
                              return 'Por favor, insira a sigla do estado';
                            }
                            return null;
                          },
                        ),
                        // CustomButton(
                        //   buttonType: ButtonType.primary,
                        //   textButton: 'Salvar',
                        //   function: controller.registerCondominium)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),     
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomButton(
                  buttonType: ButtonType.tertiary,
                  textButton: 'Logout',
                  function: controller.buttonLogout),
                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
