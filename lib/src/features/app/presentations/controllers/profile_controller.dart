import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexihome/src/config/routes/app_pages.dart';
import 'package:flexihome/src/core/extensions/constants.dart';
import 'package:flexihome/src/core/extensions/storage_helper.dart';
import 'package:flexihome/src/core/services/auth/auth_service.dart';
import 'package:flexihome/src/features/app/domain/entities/host.dart';
import 'package:flexihome/src/features/app/domain/entities/register_params.dart';
import 'package:flexihome/src/features/app/domain/entities/user_type_enum.dart';
import 'package:flexihome/src/features/app/domain/usecases/register_user_usecase.dart';
import 'package:flexihome/src/features/app/domain/usecases/save_user_usecase.dart';
import 'package:flexihome/src/features/app/domain/usecases/send_email_usecase.dart';
import 'package:flexihome/src/features/login/presentations/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  ProfileController({
    required this.registerUsecase,
    required this.saveUserUsecase,
    required this.sendEmailUsecase,
  });

  final RegisterUsecase registerUsecase;
  final SaveUserUsecase saveUserUsecase;
  final SendEmailUsecase sendEmailUsecase;

  final formkey = GlobalKey<FormState>();

  final _buttons = <Widget>[].obs;
  List<Widget> get buttons => _buttons;
  set buttons(value) => _buttons.value = value;

  final Rx<UserTypeEnum?> _registerUserType = Rx<UserTypeEnum?>(null);
  set registerUserType(UserTypeEnum? value) => _registerUserType.value = value;
  UserTypeEnum? get registerUserType => _registerUserType.value;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cnpjController = TextEditingController();
  final TextEditingController razaoSocialController = TextEditingController();
  final TextEditingController fantasyNameController = TextEditingController();

  void generateButtons() {
    buttons.clear();
    buttons.addAll([
      SizedBox(
        width: 300,
        child: ElevatedButton(
          onPressed: () {
            AuthService.to.signOut();
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            textStyle: TextStyle(fontSize: 18),
          ),
          child: Text('Logout'),
        ),
      ),
      SizedBox(
        width: 300,
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed(AppRoutes.REGISTER_USER);
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            textStyle: TextStyle(fontSize: 18),
          ),
          child: Text('Cadastrar Usuário'),
        ),
      ),
    ]);
  }

  Future<void> registerUser() async {
    if (formkey.currentState!.validate()) {
      final params = RegisterParams(
        email: emailController.text,
        password: Uuid().v4(),
        host: UserApp(
          blocked: true,
          email: emailController.text,
          name: nameController.text,
          phone: phoneController.text,
          userType: UserTypeEnum.ANFITRIAO,
          fantasyName: fantasyNameController.text,
          socialReason: razaoSocialController.text,
          cnpj: cnpjController.text,
        ),
      );

      try {
        // Salvar as credenciais do usuário atual
        final currentUser = FirebaseAuth.instance.currentUser;
        final currentEmail = currentUser?.email;
        final currentPassword = storage.read('password');

        // Criar o novo usuário
        final newUser =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: params.email,
          password: params.password,
        );

        log('Novo usuário cadastrado com sucesso: ${newUser.user?.uid}');

        // Restaurar a sessão do usuário atual
        if (currentEmail != null && currentPassword != null) {
          await FirebaseAuth.instance.signOut(); // Desloga do novo usuário
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: currentEmail,
            password: currentPassword,
          );
          LoginController.to
              .getUserData(FirebaseAuth.instance.currentUser!.uid)
              .then((value) {
            AuthService.to.host = value;
            Get.back();
          });
          log('Sessão do usuário inicial restaurada com sucesso.');
        }

        // Atualizar os documentos no Firestore
        final querySnapshot = await FirebaseFirestore.instance
            .collection(Constants.collectionCondominio)
            .where('idImobiliaria',
                isEqualTo: AuthService.to.host?.idImobiliaria)
            .get();

        for (var doc in querySnapshot.docs) {
          await FirebaseFirestore.instance
              .collection(Constants.collectionCondominio)
              .doc(doc.id)
              .update({
            'usuarios': FieldValue.arrayUnion([newUser.user!.uid]),
          });

          log('Documento atualizado: ${doc.id}');
        }
      } catch (e) {
        log('Erro ao cadastrar usuário: $e');
        Get.snackbar('Erro', 'Erro ao cadastrar usuário. Tente novamente.');
      }
    }
  }

  Future<void> saveUserData(
    UserCredential credential,
    RegisterParams params,
  ) async {
    final id = credential.user!.uid;
    final host = params.host;
    host.id = id;
    host.idImobiliaria = AuthService.to.host!.idImobiliaria;
    host.blocked = false;
    host.expirationDate = AuthService.to.host!.expirationDate;
    host.userType = UserTypeEnum.ANFITRIAO;

    final result = await saveUserUsecase.execute(host);
    result.fold(
      (l) {
        Get.snackbar('Erro', l.message ?? 'Erro ao salvar dados do usuário');
      },
      (r) {
        sendEmail();
      },
    );
  }

  Future<void> sendEmail() async {
    final result = await sendEmailUsecase.execute(emailController.text);
    result.fold(
      (l) {
        Get.snackbar('Erro', l.message ?? 'Erro ao enviar email');
      },
      (r) {
        clearFields();
      },
    );
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    cnpjController.clear();
    razaoSocialController.clear();
    fantasyNameController.clear();
    registerUserType = null;
  }

  @override
  void onInit() {
    super.onInit();
    generateButtons();
  }
}
