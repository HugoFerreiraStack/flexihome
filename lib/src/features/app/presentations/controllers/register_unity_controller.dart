import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flexihome/src/core/extensions/constants.dart';
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

  final formkey = GlobalKey<FormState>();
  final FocusNode cepFocus = FocusNode();

  final _unitys = <Unidade>[].obs;
  List<Unidade> get unitys => _unitys;
  set unitys(List<Unidade> value) => _unitys.value = value;

  final _condominiums = <Condominio>[].obs;
  List<Condominio> get condominiums => _condominiums;
  set condominiums(List<Condominio> value) => _condominiums.value = value;

  final Rxn<Condominio> _selectedCondominium = Rxn<Condominio>();
  Condominio? get selectedCondominium => _selectedCondominium.value;
  set selectedCondominium(Condominio? value) =>
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

  final searchController = TextEditingController();

  final _isloading = false.obs;
  bool get isloading => _isloading.value;
  set isloading(bool value) => _isloading.value = value;

  void setSelectedCondominio(Condominio value) {
    selectedCondominium = value;
    cepController.text = value.cep!;
    numberController.text = value.numero!;

    searchCep();
  }

  Future<void> getUnitys() async {
    unitys.clear();
    try {
      CollectionReference unitysColection =
          FirebaseFirestore.instance.collection(
        Constants.collectionUnidade,
      );

      QuerySnapshot querySnapshot = await unitysColection.get();

      for (var element in querySnapshot.docs) {
        unitys.add(Unidade.fromJson(
          element.data() as Map<String, dynamic>,
        ));
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> getCondominiums() async {
    condominiums.clear();
    try {
      CollectionReference condominiosColection =
          FirebaseFirestore.instance.collection(
        Constants.collectionCondominio,
      );

      QuerySnapshot querySnapshot = await condominiosColection
          .where('idImobiliaria', isEqualTo: AuthService.to.host?.idImobiliaria)
          .get();

      for (var element in querySnapshot.docs) {
        condominiums.add(Condominio.fromJson(
          element.data() as Map<String, dynamic>,
        ));
      }
    } catch (e) {
      log('Error: $e');
    }
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
    final unityId = FirebaseFirestore.instance
        .collection(Constants.collectionUnidade)
        .doc()
        .id;

    unity.id = unityId;
    unity.endereco = endereco;
    unity.endereco?.complemento = complementoController.text;
    unity.condominio = selectedCondominium;
    unity.criadoPor = AuthService.to.host?.email?.toLowerCase();
    unity.idHost = AuthService.to.host?.id;
    unity.usuarios = selectedCondominium?.usuarios;
    if (AuthService.to.host?.userType == UserTypeEnum.ANFITRIAO) {
      unity.usuarios?.add(AuthService.to.host?.id ?? '');
    }
    unity.usuarios = unity.usuarios?.toSet().toList();
    for (var condominio in condominiums) {
      log('ID condominio: ${condominio.id}');
      condominio.usuarios = unity.usuarios;
      condominio.totalUnitys = (condominio.totalUnitys ?? 0) + 1;
      await FirebaseFirestore.instance
          .collection(Constants.collectionCondominio)
          .doc(condominio.id)
          .update(condominio.toJson());
    }
    unity.criadoEm = DateTime.now();
    unity.idImobiliaria = AuthService.to.host?.idImobiliaria;

    final response = await setunityUsecase.execute(unity);
    response.fold(
      (l) {
        log('Error: $l');
        isloading = false;
      },
      (r) {
        log('Success: $r');
        clearFields();
        getUnitys();
        isloading = false;
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    getCondominiums();
    getUnitys();
  }
}
