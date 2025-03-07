import 'dart:developer';

import 'package:flexihome/src/core/services/auth/auth_service.dart';
import 'package:flexihome/src/features/app/domain/entities/condominio.dart';
import 'package:flexihome/src/features/app/domain/entities/endereco.dart';
import 'package:flexihome/src/features/app/domain/entities/set_condominium_params.dart';
import 'package:flexihome/src/features/app/domain/entities/user_type_enum.dart';
import 'package:flexihome/src/features/app/domain/usecases/cep_usecase.dart';
import 'package:flexihome/src/features/app/domain/usecases/register_condominium_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterCondominiumController extends GetxController {
  static RegisterCondominiumController get to => Get.find();

  final CepUsecase cepUsecase;
  final SetCondominioUsecase setCondominioUsecase;

  RegisterCondominiumController({
    required this.cepUsecase,
    required this.setCondominioUsecase,
  });

  final _condominium = Condominio().obs;
  Condominio get condominium => _condominium.value;
  set condominium(Condominio value) => _condominium.value = value;

  final _endereco = Endereco().obs;
  Endereco get endereco => _endereco.value;
  set endereco(Endereco value) => _endereco.value = value;

  final _isloading = false.obs;
  bool get isloading => _isloading.value;
  set isloading(bool value) => _isloading.value = value;

  final nameController = TextEditingController();
  final cepController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final cityController = TextEditingController();

  void clearFields() {
    nameController.clear();
    cepController.clear();
    streetController.clear();
    numberController.clear();
    neighborhoodController.clear();
    cityController.clear();
  }

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
        isloading = false;
      }),
    );
  }

  Future<void> registerCondominium() async {
    final params = SetCondominiumParams(condominio: condominium);
    if (AuthService.to.host?.userType == UserTypeEnum.IMOBILIARIA) {
      params.idImobiliaria = AuthService.to.host?.id;
    } else {
      params.idHost = AuthService.to.host?.id;
    }

    final response = await setCondominioUsecase.execute(params);
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
