import 'dart:developer';

import 'package:flexihome/src/core/services/auth/auth_service.dart';
import 'package:flexihome/src/features/app/domain/entities/condominio.dart';
import 'package:flexihome/src/features/app/domain/entities/endereco.dart';
import 'package:flexihome/src/features/app/domain/entities/unidade.dart';
import 'package:flexihome/src/features/app/domain/entities/user_type_enum.dart';
import 'package:flexihome/src/features/app/domain/usecases/cep_usecase.dart';
import 'package:flexihome/src/features/app/domain/usecases/set_unity_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterUnityController extends GetxController {
  static RegisterUnityController get to => Get.find();

  final CepUsecase cepUsecase;
  final SetunityUsecase setunityUsecase;

  RegisterUnityController({
    required this.cepUsecase,
    required this.setunityUsecase,
  });

  final _condominiums = <Condominio>[].obs;
  List<Condominio> get condominiums => _condominiums;
  set condominiums(List<Condominio> value) => _condominiums.value = value;

  final _selectedCondominium = Condominio().obs;
  Condominio get selectedCondominium => _selectedCondominium.value;
  set selectedCondominium(Condominio value) =>
      _selectedCondominium.value = value;

  final _unity = Unidade().obs;
  Unidade get unity => _unity.value;
  set unity(Unidade value) => _unity.value = value;

  final _endereco = Endereco().obs;
  Endereco get endereco => _endereco.value;
  set endereco(Endereco value) => _endereco.value = value;

  final nameController = TextEditingController();
  final cepController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final complementoController = TextEditingController();

  final _isloading = false.obs;
  bool get isloading => _isloading.value;
  set isloading(bool value) => _isloading.value = value;

  Future<void> searchCep() async {
    isloading = true;
    final response = await cepUsecase.execute(cepController.text);

    response.fold(
      (error) {
        isloading = false;
      },
      ((info) {
        endereco = Endereco.fromCep(info.toJson());
        streetController.text = endereco.logradouro!;
        neighborhoodController.text = endereco.bairro!;
        cityController.text = endereco.cidade!;
        cepController.text = endereco.cep!;
        stateController.text = endereco.estado!;
        isloading = false;
      }),
    );
  }

  void clearFields() {
    nameController.clear();
    cepController.clear();
    streetController.clear();
    numberController.clear();
    neighborhoodController.clear();
    cityController.clear();
    complementoController.clear();
    stateController.clear();
  }

  Future<void> registerunity() async {
    unity.endereco = endereco;
    unity.endereco!.complemento = complementoController.text;
    unity.condominio = selectedCondominium;

    if (AuthService.to.host?.userType == UserTypeEnum.IMOBILIARIA) {
      unity.idImobiliaria = AuthService.to.host?.id;
    } else {
      unity.idHost = AuthService.to.host?.id;
    }

    final response = await setunityUsecase.execute(unity);
    response.fold(
      (l) {
        log('Error: $l');
        isloading = false;
      },
      (r) {
        log('Success: $r');
        clearFields();
        isloading = false;
      },
    );
  }
}
