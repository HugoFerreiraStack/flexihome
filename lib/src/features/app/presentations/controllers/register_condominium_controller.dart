import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flexihome/src/core/extensions/constants.dart';
import 'package:flexihome/src/core/services/auth/auth_service.dart';
import 'package:flexihome/src/features/app/domain/entities/condominio.dart';
import 'package:flexihome/src/features/app/domain/entities/endereco.dart';
import 'package:flexihome/src/features/app/domain/usecases/cep_usecase.dart';
import 'package:flexihome/src/features/app/domain/usecases/register_condominium_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RegisterCondominiumController extends GetxController {
  static RegisterCondominiumController get to => Get.find();

  final CepUsecase cepUsecase;
  final SetCondominioUsecase setCondominioUsecase;

  RegisterCondominiumController({
    required this.cepUsecase,
    required this.setCondominioUsecase,
  });

  final formkey = GlobalKey<FormState>();
  final FocusNode cepFocus = FocusNode();

  final _condominiums = <Condominio>[].obs;
  List<Condominio> get condominiums => _condominiums;
  set condominiums(List<Condominio> value) => _condominiums.value = value;

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
  final stateController = TextEditingController();

  Future<void> getCondominiums() async {
    condominiums.clear();
    try {
      CollectionReference condominiosColection =
          FirebaseFirestore.instance.collection(
        Constants.collectionCondominio,
      );

      QuerySnapshot querySnapshot = await condominiosColection.get();

      for (var element in querySnapshot.docs) {
        condominiums.add(Condominio.fromJson(
          element.data() as Map<String, dynamic>,
        ));
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  void clearFields() {
    nameController.clear();
    cepController.clear();
    streetController.clear();
    numberController.clear();
    neighborhoodController.clear();
    cityController.clear();
    stateController.clear();
  }

  Future<void> searchCep() async {
    isloading = true;
    String cep = cepController.text.replaceAll('.', '').replaceAll('-', '');
    final response = await cepUsecase.execute(cep);

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

        condominium.cidade = endereco.cidade;
        condominium.estado = endereco.estado;
        condominium.nome = nameController.text;
        condominium.id = Uuid().v4();
        condominium.criadoPor = AuthService.to.host?.email;
        condominium.criadoEm = DateTime.now();
        condominium.usuarios = [AuthService.to.host!.id!];
        condominium.numero = numberController.text;
        condominium.logradouro = endereco.logradouro;
        condominium.bairro = endereco.bairro;
        condominium.cep = endereco.cep;
        

        isloading = false;
      }),
    );
  }

  Future<void> registerCondominium() async {
    if(nameController.text.isEmpty) {
      Get.snackbar('Atenção', 'Preencha o nome do condomínio', 
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }
    if (formkey.currentState!.validate()) {
      isloading = true;
    } else {
      return;
    }
    condominium.nome = nameController.text;
    condominium.numero=numberController.text;
    condominium.id = Uuid().v4();

    final response = await setCondominioUsecase.execute(condominium);
    response.fold(
      (l) {
        log('Error: $l');
        isloading = false;
      },
      (r) {
        log('Success: $r');
        clearFields();
        getCondominiums();
        isloading = false;
      },
    );
  }

  @override
  void onInit() {
    getCondominiums();
    super.onInit();
    cepFocus.addListener(() {
      if (!cepFocus.hasFocus) {
        searchCep();
      }
    });
  }
}
