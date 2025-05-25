import 'package:flexihome/src/core/formaters/cnpj_formatter.dart';
import 'package:flexihome/src/core/formaters/phone_formatter.dart';
import 'package:flexihome/src/features/app/presentations/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterForm extends GetView<ProfileController> {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formkey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextFormField(
            controller: controller.nameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Nome',
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
            inputFormatters: [cnpjFormatter],
            controller: controller.cnpjController,
            decoration: InputDecoration(
              labelText: 'CNPJ',
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
                return 'Por favor, insira o CNPJ';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'E-mail',
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
                return 'Por favor, insira o e-mail';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Por favor, insira um e-mail válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [phoneFormatter],
            decoration: InputDecoration(
              labelText: 'Telefone',
              labelStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Colors.white.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o telefone';
              }
              return null;
            },
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: controller.razaoSocialController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Razão Social',
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
                return 'Por favor, insira a razão social';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: controller.fantasyNameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Nome Fantasia',
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
                return 'Por favor, insira o nome fantasia';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: controller.registerUser,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle: TextStyle(fontSize: 18),
            ),
            child: Text('Cadastrar'),
          ),
        ],
      ),
    );
  }
}
