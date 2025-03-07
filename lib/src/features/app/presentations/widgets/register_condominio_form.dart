import 'package:brasil_fields/brasil_fields.dart';
import 'package:flexihome/src/features/app/presentations/controllers/register_condominium_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterCondominioForm extends GetView<RegisterCondominiumController> {
  const RegisterCondominioForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formkey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          TextFormField(
            controller: controller.nameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Nome',
              hintText: 'Nome do condomínio',
              hintStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Colors.white.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
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
          const SizedBox(height: 20),
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
              hintStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Colors.white.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
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
          const SizedBox(height: 20),
          TextFormField(
            controller: controller.streetController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Logradouro',
              hintText: 'Nome da rua',
              hintStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Colors.white.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
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
          const SizedBox(height: 20),
          TextFormField(
            controller: controller.neighborhoodController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Bairro',
              hintText: 'Nome do bairro',
              hintStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Colors.white.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
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
          const SizedBox(height: 20),
          TextFormField(
            controller: controller.cityController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Cidade',
              hintText: 'Nome da cidade',
              hintStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Colors.white.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
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
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.stateController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'UF',
                    hintText: 'Sigla do estado',
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
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
                    hintText: 'Numero do condominio',
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
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
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: controller.registerCondominium,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle: TextStyle(fontSize: 18),
            ),
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
