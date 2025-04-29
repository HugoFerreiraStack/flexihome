import 'package:brasil_fields/brasil_fields.dart';
import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/domain/entities/condominio.dart';
import 'package:flexihome/src/features/app/presentations/controllers/register_unity_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterUnityForm extends GetView<RegisterUnityController> {
  const RegisterUnityForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          spacing: 18,
          children: [
            Obx(() => DropdownButtonFormField<Condominio>(
                dropdownColor: AppColors.primary,
                decoration: InputDecoration(
                  labelText: 'Condomínio',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                hint: Text(
                  'Selecione o condomínio',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                value: controller.selectedCondominium,
                items: controller.condominiums
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e.nome!,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (Condominio? newValue) {
             controller.setSelectedCondominio(newValue!);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, selecione o tipo de usuário';
                  }
                  return null;
                },
              )),
            TextFormField(
              controller: controller.nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Qual o melhor nome para esta unidade?',
                hintText: 'Nome da unidade',
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
                SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: controller.numberController,
                    keyboardType: TextInputType.number,
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
            SizedBox(   
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.registerunity,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Salvar', style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
