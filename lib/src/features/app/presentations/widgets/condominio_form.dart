import 'package:brasil_fields/brasil_fields.dart';
import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/presentations/controllers/register_condominium_controller.dart';
import 'package:flexihome/src/features/app/presentations/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CondominiumForm extends GetView<RegisterCondominiumController> {
  const CondominiumForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formkey,
      child: Column(
        spacing: 18,
        children: [
          TextFormField(
            controller: controller.nameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Qual o melhor nome para este local?',
              hintText: 'Nome do condomínio',
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
                return 'Por favor, insira o nome';
              }
              return null;
            },
          ),
          TextFormField(
            controller: controller.cepController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter()
            ],
            decoration: InputDecoration(
              labelText: 'CEP',
              hintText: 'Digite o CEP',
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
            focusNode: controller.cepFocus,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o CEP';
              }
              return null;
            },
          ),
          TextFormField(
            controller: controller.streetController,
            keyboardType: TextInputType.name,
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o nome da rua';
              }
              return null;
            },
          ),
          TextFormField(
            controller: controller.neighborhoodController,
            keyboardType: TextInputType.name,
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o nome do bairro';
              }
              return null;
            },
          ),
          TextFormField(
            controller: controller.cityController,
            keyboardType: TextInputType.name,
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o nome da cidade';
              }
              return null;
            },
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.stateController,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a sigla do estado';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: controller.numberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Número',
                    hintText: 'Número do condominio',
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
                      return 'Por favor, insira o numero';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          CustomButton(
            buttonType: ButtonType.primary,
            textButton: 'Salvar',
            function: controller.registerCondominium)
        ],
      ),
    );
  }
}
